module Examples.Stopwatch where

import Prelude

import Effect (Effect)
import Hertz as H
import Hertz.Timer as Timer

foreign import now :: Effect Number

foreign import toFixed :: Number -> Int -> String

data Action
  = Toggle
  | Reset
  | Tick

data State
  = Running { startedFrom :: Number, startedAt :: Number }
  | Stopped { elapsed :: Number }

component :: H.Component Unit
component = H.component "Stopwatch" { initialize, update, render, subscriptions }
  where
    initialize _ = do
      now' <- now
      pure { now: now', state: Stopped { elapsed: 0.0 } }
    update self = case _ of
      Toggle -> do
        state <- self.get
        now' <- now
        case state.state of
          Running { startedFrom, startedAt } ->
            self.modify $ _ { state = Stopped { elapsed: startedFrom + (now' - startedAt) } }
          Stopped { elapsed } ->
            self.modify $ _ { state = Running { startedFrom: elapsed, startedAt: now' } }
      Tick -> do
        now' <- now
        self.modify $ _ { now = now' }
      Reset ->
        self.modify $ _ { state = Stopped { elapsed: 0.0 } }
    render self = H.div [] [
      H.button [H.onClick \_ -> self.send Toggle] [H.text if isRunning self.state.state then "Stop" else "Start"],
      H.h2 [] [H.text $ toFixed seconds 2]
    ]
      where
        seconds = case self.state.state of
          Running { startedFrom, startedAt } ->
            startedFrom + (self.state.now - startedAt)
          Stopped { elapsed } ->
            elapsed
    subscriptions {state: {state}} =
      if isRunning state
        then [Timer.every 1 Tick]
        else []
    isRunning = case _ of
      Running _ -> true
      Stopped _ -> false

main :: Effect Unit
main = H.render "main" $ H.div [] [
  H.make component unit,
  H.make component unit,
  H.make component unit
]
