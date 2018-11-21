module Examples.Counter where

import Prelude

import Effect (Effect)
import Hertz as H

data Action = Increment | Decrement | Reset

component :: H.Component Int
component = H.component "Counter" { initialize, update, render }
  where
    initialize x = pure x
    update self = case _ of
      Increment -> do
        -- Here's one way to update the state.
        state <- self.get
        self.put $ state + 1
      Decrement ->
        -- Here's a more idiomatic way to update the state.
        self.modify (_ - 1)
      Reset ->
        -- Reset simply replaces the state with `0`.
        self.put 0
    render self = H.div [] [
      H.button [H.onClick \_ -> self.send Decrement] [H.text "-"],
      H.text $ show self.state,
      H.button [H.onClick \_ -> self.send Increment] [H.text "+"],
      H.button [H.onClick \_ -> self.send Reset] [H.text "Reset"]
    ]

main :: Effect Unit
main = H.render "main" $ H.div [] [
  H.make component (-3),
  H.make component 0,
  H.make component 3
]
