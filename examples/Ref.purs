module Examples.Ref where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Examples.Toggle as Toggle
import Hertz as H
import Weber.Element (Element)

data Action = Ref (Maybe Element)

component :: H.Component Unit
component = H.component "Ref" { initialize, update, render }
  where
    initialize _ = pure unit
    update _ = case _ of
      Ref (Just element) -> H.log element
      Ref Nothing -> H.log "Nothing"
    render self = H.div [H.ref $ self.send <<< Ref] [H.text "Hello"]

main :: Effect Unit
main = H.render "main" $ Toggle.make component unit
