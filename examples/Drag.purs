module Examples.Drag where

import Prelude

import Effect (Effect)
import Hertz as H
import Weber.Event as Event
import Hertz.Window as Window

data Action
  = OnMouseDown Event.Mouse
  | OnMouseUp
  | OnMouseMove Event.Mouse

component :: H.Component Unit
component = H.component "Drag" { initialize, update, render, subscriptions }
  where
    initialize _ = pure {
      isDragging: false,
      x: 0.0,
      y: 0.0,
      offsetX: 0.0,
      offsetY: 0.0
    }
    update self = case _ of
      OnMouseDown event ->
        self.modify _ {
          isDragging = true,
          offsetX = Event.offsetX event,
          offsetY = Event.offsetY event
        }
      OnMouseUp ->
        self.modify _ { isDragging = false }
      OnMouseMove event -> do
        state <- self.get
        self.modify _ {
          x = Event.pageX event - state.offsetX,
          y = Event.pageY event - state.offsetY
        }
    render self = H.div [] [
      H.h1 [
        H.onMouseDown $ self.send <<< OnMouseDown,
        H.style' {
          left: show self.state.x <> "px",
          top: show self.state.y <> "px"
        }
      ] [H.text "Drag Me!"]
    ]
    subscriptions {state} =
      if state.isDragging
      then [
        Window.onMouseMove OnMouseMove,
        Window.onMouseUp $ const OnMouseUp
      ]
      else []

main :: Effect Unit
main = H.render "main" $ H.make component unit
