{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}
module Bread.API(
    ServerAPI
  , serverAPI
  , ProductName
  , CarbPart
  ) where

import Data.Proxy
import Data.Text
import Servant.API

-- | Name of product
type ProductName = Text
-- | Carbohydrates part of the product
type CarbPart = Double

-- | Server with single endpoint `/product/{name}` with JSON response containing
-- prart of carbohydrates in percentage of the product.
type ServerAPI = "product" :> Capture "name" ProductName :> Get '[JSON] CarbPart

-- | Value that carry 'ServerAPI' type around
serverAPI :: Proxy ServerAPI
serverAPI = Proxy
