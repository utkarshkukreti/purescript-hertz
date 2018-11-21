module Examples.SvgClock where

import Prelude

import Effect (Effect)
import Hertz as H
import Hertz.Timer as Timer

foreign import now :: Effect Number
foreign import modulo :: Number -> Number -> Number

data Action
  = Toggle
  | Tick

component :: H.Component Unit
component = H.component "SvgClock" { initialize, update, render, subscriptions }
  where
    initialize _ = do
      now' <- now
      pure { isRunning: true, now: now' }
    update self = case _ of
      Toggle ->
        self.modify \s -> s { isRunning = not s.isRunning }
      Tick -> do
        now' <- now
        self.modify _ { now = now' }
    render {state: {isRunning, now: now'}, send} = H.div [] [
      H.div [] [
        H.button [H.onClick \_ -> send Toggle] [
          H.text $ if isRunning then "Stop" else "Start"
        ]
      ],
      H.element "svg" [
        p "width" 400,
        p "height" 400,
        p "viewBox" "0 0 200 200"
      ] [
        circle,
        line hourRotate "#333" 4 50,
        line minuteRotate "#333" 3 70,
        line secondRotate "crimson" 2 90
      ]
    ]
      where
        circle = H.element "circle" [
          p "cx" 100,
          p "cy" 100,
          p "r" 98,
          p "fill" "none",
          p "stroke" "black"
        ] []
        line rotate stroke strokeWidth height = H.element "line" [
          p "x1" 100,
          p "y1" 100,
          p "x2" $ 100 - height,
          p "y2" 100,
          p "stroke" stroke,
          p "stroke-width" strokeWidth,
          p "stroke-linecap" "round",
          p "transform" $ "rotate(" <> show rotate <> " 100 100)"
        ] []
        s = now' / 1000.0
        secondRotate = 90.0 + (s `modulo` 60.0) * 360.0 / 60.0
        minuteRotate = 90.0 + ((s / 60.0) `modulo` 60.0) * 360.0 / 60.0
        hourRotate = 90.0 + ((s / 60.0 / 60.0) `modulo` 12.0) * 360.0 / 12.0
        p = H.property

    subscriptions {state: {isRunning}} =
      if isRunning then [Timer.every 20 Tick] else []

main :: Effect Unit
main = H.render "main" $ H.make component unit
