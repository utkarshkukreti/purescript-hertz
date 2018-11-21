module Examples.Lifecycle where

import Prelude

import Effect (Effect)
import Examples.Toggle as Toggle
import Hertz as H

data Action = Increment | Decrement

component :: H.Component Int
component = H.component "Counter" { initialize, update, render, didMount, shouldUpdate, didUpdate, willUnmount }
  where
    initialize x = pure x
    update self = case _ of
      Increment -> self.modify (_ + 1)
      Decrement -> self.modify (_ - 1)
    render self = H.div [] [
      H.button [H.onClick \_ -> self.send Decrement] [H.text "-"],
      H.text $ show self.state,
      H.button [H.onClick \_ -> self.send Increment] [H.text "+"]
    ]
    didMount self = H.log {"$": "didMount", self}
    shouldUpdate stuff = H.log {"$": "shouldUpdate", stuff} *> pure true
    didUpdate self prevProps prevState = H.log {"$": "didUpdate", self, prevProps, prevState}
    willUnmount self = H.log {"$": "willUnmount", self}

main :: Effect Unit
main = H.render "main" $ H.div [] [
  Toggle.make component (-3),
  Toggle.make component 0,
  Toggle.make component 3
]
