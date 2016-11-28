{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}
module Bread.API(
    ServerAPI
  , serverAPI
  ) where

import Data.Proxy
import Data.Text
import Servant.API

-- | Server with single endpoint `/product/{name}` with JSON response containing
-- prart of carbohydrates in percentage of the product.
type ServerAPI = "product" :> Capture "name" Text :> Get '[JSON] Double

-- | Value that carry 'ServerAPI' type around
serverAPI :: Proxy ServerAPI
serverAPI = Proxy