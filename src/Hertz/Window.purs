module Hertz.Window where

import Prelude

import Hertz.Internal (SubscriptionSpec, Subscription, subscribe)
import Weber.Event as Event
import Weber.EventTarget as EventTarget
import Weber.Window as Window
import Unsafe.Coerce (unsafeCoerce)

type Props a = {
  name :: String,
  fn :: Event.Event -> a
}

type State = {
  name :: String,
  handler :: EventTarget.Handler
}

spec :: forall a. SubscriptionSpec (Props a) State a
spec = { initialize, update, destroy }
  where
    initialize {props: {name, fn}, send} = do
      handler <- EventTarget.addEventListener Window.window name (send <<< fn)
      pure { name, handler }
    update {props, state, send} = do
      if props.name /= state.name
        then do
          destroy {props, state, send}
          initialize {props, send}
        else pure state
    destroy {state: {name, handler}} = do
      EventTarget.removeEventListener Window.window name handler

on :: forall a. String -> (Event.Event -> a) -> Subscription a
on name fn = subscribe spec { name, fn }

onAnimationEnd :: forall a. (Event.Animation -> a) -> Subscription a
onAnimationEnd = on "animationend" <<< (_ <<< unsafeCoerce)

onAnimationIteration :: forall a. (Event.Animation -> a) -> Subscription a
onAnimationIteration = on "animationiteration" <<< (_ <<< unsafeCoerce)

onAnimationStart :: forall a. (Event.Animation -> a) -> Subscription a
onAnimationStart = on "animationstart" <<< (_ <<< unsafeCoerce)

onCopy :: forall a. (Event.Clipboard -> a) -> Subscription a
onCopy = on "copy" <<< (_ <<< unsafeCoerce)

onCut :: forall a. (Event.Clipboard -> a) -> Subscription a
onCut = on "cut" <<< (_ <<< unsafeCoerce)

onPaste :: forall a. (Event.Clipboard -> a) -> Subscription a
onPaste = on "paste" <<< (_ <<< unsafeCoerce)

onCompositionEnd :: forall a. (Event.Composition -> a) -> Subscription a
onCompositionEnd = on "compositionend" <<< (_ <<< unsafeCoerce)

onCompositionStart :: forall a. (Event.Composition -> a) -> Subscription a
onCompositionStart = on "compositionstart" <<< (_ <<< unsafeCoerce)

onCompositionUpdate :: forall a. (Event.Composition -> a) -> Subscription a
onCompositionUpdate = on "compositionupdate" <<< (_ <<< unsafeCoerce)

onDrag :: forall a. (Event.Drag -> a) -> Subscription a
onDrag = on "drag" <<< (_ <<< unsafeCoerce)

onDragEnd :: forall a. (Event.Drag -> a) -> Subscription a
onDragEnd = on "dragend" <<< (_ <<< unsafeCoerce)

onDragEnter :: forall a. (Event.Drag -> a) -> Subscription a
onDragEnter = on "dragenter" <<< (_ <<< unsafeCoerce)

onDragExit :: forall a. (Event.Drag -> a) -> Subscription a
onDragExit = on "dragexit" <<< (_ <<< unsafeCoerce)

onDragLeave :: forall a. (Event.Drag -> a) -> Subscription a
onDragLeave = on "dragleave" <<< (_ <<< unsafeCoerce)

onDragOver :: forall a. (Event.Drag -> a) -> Subscription a
onDragOver = on "dragover" <<< (_ <<< unsafeCoerce)

onDragStart :: forall a. (Event.Drag -> a) -> Subscription a
onDragStart = on "dragstart" <<< (_ <<< unsafeCoerce)

onDrop :: forall a. (Event.Drag -> a) -> Subscription a
onDrop = on "drop" <<< (_ <<< unsafeCoerce)

onAbort :: forall a. (Event.Event -> a) -> Subscription a
onAbort = on "abort"

onCanPlay :: forall a. (Event.Event -> a) -> Subscription a
onCanPlay = on "canplay"

onCanPlayThrough :: forall a. (Event.Event -> a) -> Subscription a
onCanPlayThrough = on "canplaythrough"

onChange :: forall a. (Event.Event -> a) -> Subscription a
onChange = on "change"

onDurationChange :: forall a. (Event.Event -> a) -> Subscription a
onDurationChange = on "durationchange"

onEmptied :: forall a. (Event.Event -> a) -> Subscription a
onEmptied = on "emptied"

onEncrypted :: forall a. (Event.Event -> a) -> Subscription a
onEncrypted = on "encrypted"

onEnded :: forall a. (Event.Event -> a) -> Subscription a
onEnded = on "ended"

onError :: forall a. (Event.Event -> a) -> Subscription a
onError = on "error"

onInput :: forall a. (Event.Event -> a) -> Subscription a
onInput = on "input"

onInvalid :: forall a. (Event.Event -> a) -> Subscription a
onInvalid = on "invalid"

onLoad :: forall a. (Event.Event -> a) -> Subscription a
onLoad = on "load"

onLoadStart :: forall a. (Event.Event -> a) -> Subscription a
onLoadStart = on "loadstart"

onLoadedData :: forall a. (Event.Event -> a) -> Subscription a
onLoadedData = on "loadeddata"

onLoadedMetadata :: forall a. (Event.Event -> a) -> Subscription a
onLoadedMetadata = on "loadedmetadata"

onPause :: forall a. (Event.Event -> a) -> Subscription a
onPause = on "pause"

onPlay :: forall a. (Event.Event -> a) -> Subscription a
onPlay = on "play"

onPlaying :: forall a. (Event.Event -> a) -> Subscription a
onPlaying = on "playing"

onProgress :: forall a. (Event.Event -> a) -> Subscription a
onProgress = on "progress"

onRateChange :: forall a. (Event.Event -> a) -> Subscription a
onRateChange = on "ratechange"

onReset :: forall a. (Event.Event -> a) -> Subscription a
onReset = on "reset"

onSeeked :: forall a. (Event.Event -> a) -> Subscription a
onSeeked = on "seeked"

onSeeking :: forall a. (Event.Event -> a) -> Subscription a
onSeeking = on "seeking"

onSelect :: forall a. (Event.Event -> a) -> Subscription a
onSelect = on "select"

onStalled :: forall a. (Event.Event -> a) -> Subscription a
onStalled = on "stalled"

onSubmit :: forall a. (Event.Event -> a) -> Subscription a
onSubmit = on "submit"

onSuspend :: forall a. (Event.Event -> a) -> Subscription a
onSuspend = on "suspend"

onTimeUpdate :: forall a. (Event.Event -> a) -> Subscription a
onTimeUpdate = on "timeupdate"

onVolumeChange :: forall a. (Event.Event -> a) -> Subscription a
onVolumeChange = on "volumechange"

onWaiting :: forall a. (Event.Event -> a) -> Subscription a
onWaiting = on "waiting"

onBlur :: forall a. (Event.Focus -> a) -> Subscription a
onBlur = on "blur" <<< (_ <<< unsafeCoerce)

onFocus :: forall a. (Event.Focus -> a) -> Subscription a
onFocus = on "focus" <<< (_ <<< unsafeCoerce)

onKeyDown :: forall a. (Event.Keyboard -> a) -> Subscription a
onKeyDown = on "keydown" <<< (_ <<< unsafeCoerce)

onKeyPress :: forall a. (Event.Keyboard -> a) -> Subscription a
onKeyPress = on "keypress" <<< (_ <<< unsafeCoerce)

onKeyUp :: forall a. (Event.Keyboard -> a) -> Subscription a
onKeyUp = on "keyup" <<< (_ <<< unsafeCoerce)

onClick :: forall a. (Event.Mouse -> a) -> Subscription a
onClick = on "click" <<< (_ <<< unsafeCoerce)

onContextMenu :: forall a. (Event.Mouse -> a) -> Subscription a
onContextMenu = on "contextmenu" <<< (_ <<< unsafeCoerce)

onDblClick :: forall a. (Event.Mouse -> a) -> Subscription a
onDblClick = on "dblclick" <<< (_ <<< unsafeCoerce)

onMouseDown :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseDown = on "mousedown" <<< (_ <<< unsafeCoerce)

onMouseEnter :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseEnter = on "mouseenter" <<< (_ <<< unsafeCoerce)

onMouseLeave :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseLeave = on "mouseleave" <<< (_ <<< unsafeCoerce)

onMouseMove :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseMove = on "mousemove" <<< (_ <<< unsafeCoerce)

onMouseOut :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseOut = on "mouseout" <<< (_ <<< unsafeCoerce)

onMouseOver :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseOver = on "mouseover" <<< (_ <<< unsafeCoerce)

onMouseUp :: forall a. (Event.Mouse -> a) -> Subscription a
onMouseUp = on "mouseup" <<< (_ <<< unsafeCoerce)

onPointerCancel :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerCancel = on "pointercancel" <<< (_ <<< unsafeCoerce)

onPointerDown :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerDown = on "pointerdown" <<< (_ <<< unsafeCoerce)

onPointerEnter :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerEnter = on "pointerenter" <<< (_ <<< unsafeCoerce)

onPointerLeave :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerLeave = on "pointerleave" <<< (_ <<< unsafeCoerce)

onPointerMove :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerMove = on "pointermove" <<< (_ <<< unsafeCoerce)

onPointerOut :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerOut = on "pointerout" <<< (_ <<< unsafeCoerce)

onPointerOver :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerOver = on "pointerover" <<< (_ <<< unsafeCoerce)

onPointerUp :: forall a. (Event.Pointer -> a) -> Subscription a
onPointerUp = on "pointerup" <<< (_ <<< unsafeCoerce)

onTouchCancel :: forall a. (Event.Touch -> a) -> Subscription a
onTouchCancel = on "touchcancel" <<< (_ <<< unsafeCoerce)

onTouchEnd :: forall a. (Event.Touch -> a) -> Subscription a
onTouchEnd = on "touchend" <<< (_ <<< unsafeCoerce)

onTouchMove :: forall a. (Event.Touch -> a) -> Subscription a
onTouchMove = on "touchmove" <<< (_ <<< unsafeCoerce)

onTouchStart :: forall a. (Event.Touch -> a) -> Subscription a
onTouchStart = on "touchstart" <<< (_ <<< unsafeCoerce)

onTransitionEnd :: forall a. (Event.Transition -> a) -> Subscription a
onTransitionEnd = on "transitionend" <<< (_ <<< unsafeCoerce)

onScroll :: forall a. (Event.Ui -> a) -> Subscription a
onScroll = on "scroll" <<< (_ <<< unsafeCoerce)

onWheel :: forall a. (Event.Wheel -> a) -> Subscription a
onWheel = on "wheel" <<< (_ <<< unsafeCoerce)
