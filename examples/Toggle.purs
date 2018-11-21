module Examples.Toggle where

import Prelude

import Effect (Effect)
import Hertz as H

hello :: H.Component Unit
hello = H.component "Hello" { initialize, update, render }
  where
    initialize _ = pure unit
    update _ _ = pure unit
    render _ = H.text "Hello!"

toggle :: forall props. H.Component { component :: H.Component props, props :: props }
toggle = H.component "Toggle" { initialize, update, render }
  where
    initialize _ = pure true
    update self _ = self.modify not
    render self = H.div [] [
      H.button [H.onClick \_ -> self.send unit] [H.text "Toggle"],
      if self.state then H.make self.props.component self.props.props else H.none
    ]

make :: forall props. H.Component props -> props -> H.VirtualNode
make component props = H.make toggle { component, props }

main :: Effect Unit
main = H.render "main" $ make hello unit
