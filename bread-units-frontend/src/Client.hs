module Client(
    productCarbs
  ) where

import Bread.API
import Control.Concurrent
import Control.Monad.IO.Class
import Control.Monad.Trans.Either
import Data.Bifunctor
import Data.Monoid
import Data.Text
import Reflex.Dom
import Servant.API
import Servant.Client

-- | Low-level derived method for getting a carbohydrates part of product
productCarbs' :: ProductName -> EitherT ServantError IO CarbPart
productCarbs' = client serverAPI Nothing

-- | Widget that queries product carbohydrates as soon as the widget is constructed
productCarbs :: MonadWidget t m => ProductName -> m (Dynamic t CarbPart)
productCarbs name = do
  e  <- getPostBuild
  e' <- simpleRequest (fmap (const name) e) productCarbs'
  holdDyn 0 e'

-- | Display ajax error
printAjaxErr :: ServantError -> Text
printAjaxErr err = case err of
  FailureResponse {..} -> "Failure: " <> pack (show responseStatus)
  DecodeFailure {..} -> pack decodeError
  UnsupportedContentType {..} -> "Unsupported content type"
  InvalidContentTypeHeader {..} -> "Invalid content type header"

-- | Perform async ajax request
asyncAjax :: MonadWidget t m => (a -> EitherT ServantError IO b) -- ^ Raw ajax requester
  -> Event t a -- ^ Input data
  -> m (Event t (Either Text b)) -- ^ Either an error or result
asyncAjax action e = performEventAsync $ ffor e $ \a cb -> do
  resp <- liftIO newEmptyMVar
  _ <- liftIO $ forkIO $ putMVar resp =<< runEitherT (action a)
  _ <- liftIO $ forkIO $ cb . first printAjaxErr =<< takeMVar resp
  return ()

-- | Helper to request server
--
-- Prints errors in "danger" bootstrap panel.
simpleRequest :: MonadWidget t m
  => Event t a -- ^ Input arguments
  -> (a -> EitherT ServantError IO b) -- ^ Request function
  -> m (Event t b) -- ^ Result
simpleRequest ea req = do
  reqEv <- asyncAjax req ea
  _ <- widgetHold (pure ()) $ ffor reqEv $ \resp -> case resp of
    Left er -> danger er
    Right _ -> return ()
  return $ fforMaybe reqEv $ either (const Nothing) Just
  where
  danger = elClass "div" "alert alert-danger" . text