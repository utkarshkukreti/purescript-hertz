module Examples.HelloWorld where

import Prelude

import Effect (Effect)
import Hertz as H

main :: Effect Unit
main = H.render "main" $ H.h1 [] [H.text "Hello, world!"]
