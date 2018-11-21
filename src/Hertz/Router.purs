module Hertz.Router (
  Url,
  parse,
  Router(..),
  match,
  param,
  s,
  int,
  string,
  hash,
  end,
  query,
  queryString,
  queryInt,
  Mode(..),
  Link,
  link,
  push,
  replace,
  subscribe
) where

import Prelude

import Control.Alt (class Alt)
import Control.Alternative (class Alternative)
import Control.Plus (class Plus)
import Data.Array as Array
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import Data.String as String
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Hertz.Internal as H
import Weber.Event (Event)

type Url = {
  path :: Array String,
  query :: Array (Tuple String String),
  hash :: Maybe String
}

parse :: String -> Url
parse string' =
  let
    { before: pathAndQuery, after: hash' } = splitOnce "#" string'
    { before: path', after: query' } = splitOnce "?" pathAndQuery
    path = path' # String.split (String.Pattern "/") # Array.filter (_ /= "")
    query'' =
      query'
      # String.split (String.Pattern "&")
      # map (String.split (String.Pattern "="))
      # Array.foldl (\acc -> case _ of
        [name, value] -> acc <> [Tuple name value]
        _ -> acc
      ) []
    hash'' = if hash' == "" then Nothing else Just hash'
  in
    { path, query: query'', hash: hash'' }
  where
    splitOnce needle haystack =
      case String.indexOf (String.Pattern needle) haystack of
        Just i -> { before: String.take i haystack, after: String.drop (i + String.length needle) haystack }
        Nothing -> { before: haystack, after: "" }

newtype Router a = Router (Url -> Maybe (Tuple Url a))

instance functorRouter :: Functor Router where
  map f (Router a) = Router \url ->
    case a url of
      Just (Tuple url' a') -> Just $ Tuple url' $ f a'
      Nothing -> Nothing

instance altRouter :: Alt Router where
  alt (Router a) (Router b) = Router \url ->
    case a url of
      Just a' -> Just a'
      Nothing -> b url

instance applyRouter :: Apply Router where
  apply (Router f) (Router a) = Router \url ->
    case f url of
      Just (Tuple url' f') ->
        case a url' of
          Just (Tuple url'' a') -> Just $ Tuple url'' $ f' a'
          Nothing -> Nothing
      Nothing -> Nothing

instance applicativeRouter :: Applicative Router where
  pure a = Router \url -> Just $ Tuple url a

instance plusRouter :: Plus Router where
  empty = Router \_ -> Nothing

instance alternativeRouter :: Alternative Router

match :: forall a. Router a -> Url -> Maybe a
match (Router a) url = case a url of
  Just (Tuple _ a') -> Just a'
  Nothing -> Nothing

param :: forall a. (String -> Maybe a) -> Router a
param f = Router \url ->
  case Array.head url.path of
    Just head | Just a <- f head ->
      Just $ Tuple (url { path = Array.drop 1 url.path }) a
    _ -> Nothing

s :: String -> Router Unit
s string' = param (\string'' -> if string' == string'' then Just unit else Nothing)

foreign import parseInt_ :: String -> Nullable Int

int :: Router Int
int = param $ Nullable.toMaybe <<< parseInt_

string :: Router String
string = param Just

hash :: Router String
hash = Router \url ->
  case url.hash of
    Just hash' -> Just $ Tuple url hash'
    Nothing -> Nothing

end :: Router Unit
end = Router \url ->
  case url.path of
    [] -> Just $ Tuple url unit
    _ -> Nothing

query :: forall a. (String -> Maybe a) -> String -> Router a
query f name = Router \url ->
  url.query
  # Array.filter (\(Tuple name' _) -> name == name')
  # Array.head
  <#> (\(Tuple _ value) -> value)
  >>= f
  <#> (\a -> Tuple url a)

queryString :: String -> Router String
queryString = query Just

queryInt :: String -> Router Int
queryInt = query $ Nullable.toMaybe <<< parseInt_

foreign import onClick :: Event -> Effect Unit

data Mode = Hash | History

type Link a = a -> Array H.Property -> Array H.VirtualNode -> H.VirtualNode

prefixed :: Mode -> String -> String
prefixed mode url = case mode of
  Hash -> "#" <> url
  History -> url

link :: Mode -> Link String
link mode url props children =
  let props' = [H.on "click" onClick, H.property "href" $ prefixed mode url] <> props
  in H.element "a" props' children

foreign import push_ :: String -> Effect Unit
foreign import replace_ :: String -> Effect Unit

push :: Mode -> String -> Effect Unit
push mode url = push_ $ prefixed mode url

replace :: Mode -> String -> Effect Unit
replace mode url = replace_ $ prefixed mode url

foreign import data Token :: Type

foreign import addListener :: { mode :: String, handler :: (String -> Effect Unit) } -> Effect Token
foreign import removeListener :: Token -> Effect Unit

type Spec action = {
  handler :: Url -> action,
  mode :: Mode
}

subscription :: forall action. H.SubscriptionSpec (Spec action) Token action
subscription = { initialize, update, destroy }
  where
    initialize {props: {mode, handler}, send} = do
      let
        mode' = case mode of
          Hash -> "hash"
          History -> "history"
      token <- addListener { mode: mode', handler: send <<< handler <<< parse }
      pure token
    update {state} = pure state
    destroy {state: token} = removeListener token

subscribe :: forall action. Mode -> (Url -> action) -> H.Subscription action
subscribe mode handler = H.subscribe subscription { mode, handler }
