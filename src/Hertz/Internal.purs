module Hertz.Internal where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import Effect (Effect)
import Prim.Row as Row
import Unsafe.Coerce (unsafeCoerce)
import Weber.Element (Element)
import Weber.Event (Event)

foreign import data Component :: Type -> Type

foreign import data VirtualNode :: Type

foreign import data Property :: Type

foreign import text :: String -> VirtualNode

foreign import property :: forall a. String -> a -> Property

foreign import on :: String -> (Event -> Effect Unit) -> Property

foreign import class_ :: String -> Property

class' :: String -> Property
class' = class_

foreign import ref_ :: (Nullable Element -> Effect Unit) -> Property

foreign import key :: String -> Property

ref :: (Maybe Element -> Effect Unit) -> Property
ref f = ref_ $ f <<< Nullable.toMaybe

foreign import element :: String -> Array Property -> Array VirtualNode -> VirtualNode

foreign import none :: VirtualNode

type Required props state action = (
  initialize :: Initialize props state action,
  update :: Update props state action,
  render :: Render props state action
)

type Optional props state action = (
  subscriptions :: Subscriptions props state action,
  didMount :: DidMount props state action,
  shouldUpdate :: ShouldUpdate props state action,
  didUpdate :: DidUpdate props state action,
  willUnmount :: WillUnmount props state action
)

type Initialize props state action = props -> Effect state

type Update props state action = Self props state action -> action -> Effect Unit

type Render props state action = {
  props :: props,
  state :: state,
  send :: Send action
} -> VirtualNode

type Subscriptions props state action = {
  props :: props,
  state :: state
} -> Array (Subscription action)

foreign import data Subscription :: Type -> Type

type SubscriptionSpec props state action = {
  initialize :: {
    props :: props,
    send :: Send action
  } -> Effect state,
  update :: {
    props :: props,
    state :: state,
    send :: Send action
  } -> Effect state,
  destroy :: {
    props :: props,
    state :: state,
    send :: Send action
  } -> Effect Unit
}

subscribe :: forall props state action. SubscriptionSpec props state action -> props -> Subscription action
subscribe spec props = unsafeCoerce { spec, props }

type DidMount props state action = Self props state action -> Effect Unit

type ShouldUpdate props state action = {
  prevProps :: props,
  prevState :: state,
  nextProps :: props,
  nextState :: state
} -> Effect Boolean

type DidUpdate props state action = Self props state action -> props -> state -> Effect Unit

type WillUnmount props state action = {
  props :: props,
  state :: state
} -> Effect Unit

type Self props state action = {
  props :: Effect props,
  get :: Effect state,
  put :: state -> Effect Unit,
  modify :: (state -> state) -> Effect Unit,
  send :: Send action
}

type Send action = action -> Effect Unit

foreign import component_ :: forall spec props. String -> spec -> Component props

component ::
  forall spec a b props state action
  . Row.Union a b (Optional props state action)
  => Row.Union (Required props state action) a spec
  => String
  -> Record spec
  -> Component props
component = component_

foreign import make :: forall props. Component props -> props -> VirtualNode

foreign import makeKeyed :: forall props. String -> Component props -> props -> VirtualNode

foreign import render :: String -> VirtualNode -> Effect Unit

foreign import log :: forall a. a -> Effect Unit
