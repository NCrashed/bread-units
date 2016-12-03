{-# LANGUAGE LambdaCase #-}
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
import Servant.Reflex
import Data.Proxy

-- | Low-level derived method for getting a carbohydrates part of product
productCarbs' :: forall t m . MonadWidget t m
  => Dynamic t (Either Text ProductName) -- ^ Value of product name
  -> Event t () -- ^ Trigger of the request
  -> m (Event t (ReqResult CarbPart))
productCarbs' = client serverAPI (Proxy :: Proxy m) (pure (BasePath "/"))

-- | Widget that queries product carbohydrates as soon as the widget is constructed
productCarbs :: MonadWidget t m => ProductName -> m (Dynamic t CarbPart)
productCarbs name = do
  e <- delay (realToFrac (0.1 :: Double)) =<< getPostBuild
  respE <- productCarbs' (pure (Right name)) e
  widgetHold (return ()) $ ffor respE $ \case
    ResponseSuccess _ _ -> return ()
    ResponseFailure msg _ -> danger msg
    RequestFailure msg -> danger msg
  holdDyn 0 $ fforMaybe respE reqSuccess
  where
    danger = elClass "div" "alert alert-danger" . text
