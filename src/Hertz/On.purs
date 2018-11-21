module Hertz.On where

import Prelude

import Effect (Effect)
import Hertz.Internal (Property, on)
import Unsafe.Coerce (unsafeCoerce)
import Weber.Event as Event

onAnimationEnd :: (Event.Animation -> Effect Unit) -> Property
onAnimationEnd = on "animationend" <<< unsafeCoerce

onAnimationIteration :: (Event.Animation -> Effect Unit) -> Property
onAnimationIteration = on "animationiteration" <<< unsafeCoerce

onAnimationStart :: (Event.Animation -> Effect Unit) -> Property
onAnimationStart = on "animationstart" <<< unsafeCoerce

onCopy :: (Event.Clipboard -> Effect Unit) -> Property
onCopy = on "copy" <<< unsafeCoerce

onCut :: (Event.Clipboard -> Effect Unit) -> Property
onCut = on "cut" <<< unsafeCoerce

onPaste :: (Event.Clipboard -> Effect Unit) -> Property
onPaste = on "paste" <<< unsafeCoerce

onCompositionEnd :: (Event.Composition -> Effect Unit) -> Property
onCompositionEnd = on "compositionend" <<< unsafeCoerce

onCompositionStart :: (Event.Composition -> Effect Unit) -> Property
onCompositionStart = on "compositionstart" <<< unsafeCoerce

onCompositionUpdate :: (Event.Composition -> Effect Unit) -> Property
onCompositionUpdate = on "compositionupdate" <<< unsafeCoerce

onDrag :: (Event.Drag -> Effect Unit) -> Property
onDrag = on "drag" <<< unsafeCoerce

onDragEnd :: (Event.Drag -> Effect Unit) -> Property
onDragEnd = on "dragend" <<< unsafeCoerce

onDragEnter :: (Event.Drag -> Effect Unit) -> Property
onDragEnter = on "dragenter" <<< unsafeCoerce

onDragExit :: (Event.Drag -> Effect Unit) -> Property
onDragExit = on "dragexit" <<< unsafeCoerce

onDragLeave :: (Event.Drag -> Effect Unit) -> Property
onDragLeave = on "dragleave" <<< unsafeCoerce

onDragOver :: (Event.Drag -> Effect Unit) -> Property
onDragOver = on "dragover" <<< unsafeCoerce

onDragStart :: (Event.Drag -> Effect Unit) -> Property
onDragStart = on "dragstart" <<< unsafeCoerce

onDrop :: (Event.Drag -> Effect Unit) -> Property
onDrop = on "drop" <<< unsafeCoerce

onAbort :: (Event.Event -> Effect Unit) -> Property
onAbort = on "abort"

onCanPlay :: (Event.Event -> Effect Unit) -> Property
onCanPlay = on "canplay"

onCanPlayThrough :: (Event.Event -> Effect Unit) -> Property
onCanPlayThrough = on "canplaythrough"

onChange :: (Event.Event -> Effect Unit) -> Property
onChange = on "change"

onDurationChange :: (Event.Event -> Effect Unit) -> Property
onDurationChange = on "durationchange"

onEmptied :: (Event.Event -> Effect Unit) -> Property
onEmptied = on "emptied"

onEncrypted :: (Event.Event -> Effect Unit) -> Property
onEncrypted = on "encrypted"

onEnded :: (Event.Event -> Effect Unit) -> Property
onEnded = on "ended"

onError :: (Event.Event -> Effect Unit) -> Property
onError = on "error"

onInput :: (Event.Event -> Effect Unit) -> Property
onInput = on "input"

onInvalid :: (Event.Event -> Effect Unit) -> Property
onInvalid = on "invalid"

onLoad :: (Event.Event -> Effect Unit) -> Property
onLoad = on "load"

onLoadStart :: (Event.Event -> Effect Unit) -> Property
onLoadStart = on "loadstart"

onLoadedData :: (Event.Event -> Effect Unit) -> Property
onLoadedData = on "loadeddata"

onLoadedMetadata :: (Event.Event -> Effect Unit) -> Property
onLoadedMetadata = on "loadedmetadata"

onPause :: (Event.Event -> Effect Unit) -> Property
onPause = on "pause"

onPlay :: (Event.Event -> Effect Unit) -> Property
onPlay = on "play"

onPlaying :: (Event.Event -> Effect Unit) -> Property
onPlaying = on "playing"

onProgress :: (Event.Event -> Effect Unit) -> Property
onProgress = on "progress"

onRateChange :: (Event.Event -> Effect Unit) -> Property
onRateChange = on "ratechange"

onReset :: (Event.Event -> Effect Unit) -> Property
onReset = on "reset"

onSeeked :: (Event.Event -> Effect Unit) -> Property
onSeeked = on "seeked"

onSeeking :: (Event.Event -> Effect Unit) -> Property
onSeeking = on "seeking"

onSelect :: (Event.Event -> Effect Unit) -> Property
onSelect = on "select"

onStalled :: (Event.Event -> Effect Unit) -> Property
onStalled = on "stalled"

onSubmit :: (Event.Event -> Effect Unit) -> Property
onSubmit = on "submit"

onSuspend :: (Event.Event -> Effect Unit) -> Property
onSuspend = on "suspend"

onTimeUpdate :: (Event.Event -> Effect Unit) -> Property
onTimeUpdate = on "timeupdate"

onVolumeChange :: (Event.Event -> Effect Unit) -> Property
onVolumeChange = on "volumechange"

onWaiting :: (Event.Event -> Effect Unit) -> Property
onWaiting = on "waiting"

onBlur :: (Event.Focus -> Effect Unit) -> Property
onBlur = on "blur" <<< unsafeCoerce

onFocus :: (Event.Focus -> Effect Unit) -> Property
onFocus = on "focus" <<< unsafeCoerce

onKeyDown :: (Event.Keyboard -> Effect Unit) -> Property
onKeyDown = on "keydown" <<< unsafeCoerce

onKeyPress :: (Event.Keyboard -> Effect Unit) -> Property
onKeyPress = on "keypress" <<< unsafeCoerce

onKeyUp :: (Event.Keyboard -> Effect Unit) -> Property
onKeyUp = on "keyup" <<< unsafeCoerce

onClick :: (Event.Mouse -> Effect Unit) -> Property
onClick = on "click" <<< unsafeCoerce

onContextMenu :: (Event.Mouse -> Effect Unit) -> Property
onContextMenu = on "contextmenu" <<< unsafeCoerce

onDblClick :: (Event.Mouse -> Effect Unit) -> Property
onDblClick = on "dblclick" <<< unsafeCoerce

onMouseDown :: (Event.Mouse -> Effect Unit) -> Property
onMouseDown = on "mousedown" <<< unsafeCoerce

onMouseEnter :: (Event.Mouse -> Effect Unit) -> Property
onMouseEnter = on "mouseenter" <<< unsafeCoerce

onMouseLeave :: (Event.Mouse -> Effect Unit) -> Property
onMouseLeave = on "mouseleave" <<< unsafeCoerce

onMouseMove :: (Event.Mouse -> Effect Unit) -> Property
onMouseMove = on "mousemove" <<< unsafeCoerce

onMouseOut :: (Event.Mouse -> Effect Unit) -> Property
onMouseOut = on "mouseout" <<< unsafeCoerce

onMouseOver :: (Event.Mouse -> Effect Unit) -> Property
onMouseOver = on "mouseover" <<< unsafeCoerce

onMouseUp :: (Event.Mouse -> Effect Unit) -> Property
onMouseUp = on "mouseup" <<< unsafeCoerce

onPointerCancel :: (Event.Pointer -> Effect Unit) -> Property
onPointerCancel = on "pointercancel" <<< unsafeCoerce

onPointerDown :: (Event.Pointer -> Effect Unit) -> Property
onPointerDown = on "pointerdown" <<< unsafeCoerce

onPointerEnter :: (Event.Pointer -> Effect Unit) -> Property
onPointerEnter = on "pointerenter" <<< unsafeCoerce

onPointerLeave :: (Event.Pointer -> Effect Unit) -> Property
onPointerLeave = on "pointerleave" <<< unsafeCoerce

onPointerMove :: (Event.Pointer -> Effect Unit) -> Property
onPointerMove = on "pointermove" <<< unsafeCoerce

onPointerOut :: (Event.Pointer -> Effect Unit) -> Property
onPointerOut = on "pointerout" <<< unsafeCoerce

onPointerOver :: (Event.Pointer -> Effect Unit) -> Property
onPointerOver = on "pointerover" <<< unsafeCoerce

onPointerUp :: (Event.Pointer -> Effect Unit) -> Property
onPointerUp = on "pointerup" <<< unsafeCoerce

onTouchCancel :: (Event.Touch -> Effect Unit) -> Property
onTouchCancel = on "touchcancel" <<< unsafeCoerce

onTouchEnd :: (Event.Touch -> Effect Unit) -> Property
onTouchEnd = on "touchend" <<< unsafeCoerce

onTouchMove :: (Event.Touch -> Effect Unit) -> Property
onTouchMove = on "touchmove" <<< unsafeCoerce

onTouchStart :: (Event.Touch -> Effect Unit) -> Property
onTouchStart = on "touchstart" <<< unsafeCoerce

onTransitionEnd :: (Event.Transition -> Effect Unit) -> Property
onTransitionEnd = on "transitionend" <<< unsafeCoerce

onScroll :: (Event.Ui -> Effect Unit) -> Property
onScroll = on "scroll" <<< unsafeCoerce

onWheel :: (Event.Wheel -> Effect Unit) -> Property
onWheel = on "wheel" <<< unsafeCoerce
