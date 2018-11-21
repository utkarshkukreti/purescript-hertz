module Hertz.Timer (
  every
) where

import Prelude

import Effect (Effect)
import Hertz.Internal as H

foreign import data SetIntervalId :: Type

foreign import setInterval_ :: Int -> (Effect Unit -> Effect Unit) -> Effect SetIntervalId
foreign import clearInterval_ :: SetIntervalId -> Effect Unit

every' :: forall action. H.SubscriptionSpec { ms :: Int, action :: action } { ms :: Int, id :: SetIntervalId } action
every' = { initialize, update, destroy }
  where
    initialize {props: {ms, action}, send} = do
      id <- setInterval_ ms \_ -> send action
      pure { ms, id }
    update {props, state, send} =
      if props.ms /= state.ms
        then do
          destroy {props, state, send}
          initialize {props, send}
        else
          pure state
    destroy {state: {id}} = clearInterval_ id

every :: forall action. Int -> action -> H.Subscription action
every ms action = H.subscribe every' { ms, action }
