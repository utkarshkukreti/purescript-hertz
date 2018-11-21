module Examples.Router where

import Prelude

import Control.Alt ((<|>))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..), maybe, optional)
import Effect (Effect)
import Hertz as H
import Hertz.Router as R

type State = { route :: Maybe Route, url :: Maybe R.Url }

data Message = Navigate R.Url

data Route
  = Index
  | PostIndex { sortBy :: Maybe String }
  | PostShow { id :: Int, hash :: Maybe String }
  | PostEdit { id :: Int }

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route

instance showRoute :: Show Route where
  show = genericShow

router :: R.Router Route
router =
  Index <$ R.end
  <|> (\sortBy -> PostIndex { sortBy }) <$> (R.s "posts" *> optional (R.queryString "sort-by")) <* R.end
  <|> (\id hash -> PostShow { id, hash }) <$> (R.s "posts" *> R.int) <*> optional R.hash <* R.end
  <|> (\id -> PostEdit { id }) <$> (R.s "posts" *> R.int) <* R.s "edit" <* R.end

toString :: Route -> String
toString = case _ of
  Index ->
    "/"
  PostIndex { sortBy } ->
    "/posts" <> maybe "" ("?sort-by=" <> _) sortBy
  PostShow { id, hash } ->
    "/posts/" <> show id <> maybe "" ("#" <> _) hash
  PostEdit { id } ->
    "/posts/" <> show id <> "/edit"

link :: R.Link Route
link = R.link R.Hash <<< toString

component :: H.Component Unit
component = H.component "Router" { initialize, update, render, subscriptions }
  where
    initialize _ = pure { route: Nothing, url: Nothing }
    update self = case _ of
      Navigate url -> self.modify _ { route = R.match router url, url = Just url }
    render self =
      H.div [] $ [
        H.h2 [] [H.text $ "Url: " <> show self.state.url],
        H.h2 [] [H.text $ "Route: " <> show self.state.route],
        H.div [] $ f <$> routes
      ]
      where
        routes = [
          Index,
          PostIndex { sortBy: Nothing },
          PostIndex { sortBy: Just "id" },
          PostIndex { sortBy: Just "title" },
          PostShow { id: 1, hash: Nothing },
          PostShow { id: 1, hash: Just "section-1" },
          PostShow { id: 2, hash: Nothing },
          PostShow { id: 2, hash: Just "section-1" }
        ]
        f route = H.h3 [H.class' (if Just route == self.state.route then "active" else "")] [
          link route [] [H.text $ show route <> " (" <> toString route <> ")"],
          H.button [H.onClick (\_ -> R.push R.Hash $ toString route)] [H.text "Push"],
          H.button [H.onClick (\_ -> R.replace R.Hash $ toString route)] [H.text "Replace"]
        ]

    subscriptions _ = [R.subscribe R.Hash Navigate]

main :: Effect Unit
main = do
  H.render "main" $ H.make component unit
