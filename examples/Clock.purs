module Examples.Clock where

import Prelude

import Effect (Effect)
import Hertz as H
import Hertz.Timer as Timer

foreign import now :: Effect { h :: Int, m :: Int, s :: Int }

component :: H.Component Unit
component = H.component "Clock" { initialize, update, render, subscriptions }
  where
    initialize _ = now
    update self _ = do
      now' <- now
      self.put now'
    render {state: {h, m, s}} = H.h1 [] [
      H.text $ format h <> ":" <> format m <> ":" <> format s
    ]
      where
        format n | n < 10    = "0" <> show n
                 | otherwise = show n
    subscriptions _ = [Timer.every 100 unit]

main :: Effect Unit
main = H.render "main" $ H.make component unit
