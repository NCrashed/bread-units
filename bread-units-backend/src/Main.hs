{-# LANGUAGE OverloadedStrings #-}
module Main where

import Bread.API
import Data.Text as T
import Network.Wai
import Network.Wai.Handler.Warp
import Servant.Server

-- | Implement endpoint that returns percent of carbohydrates in food
getCarbohydrates :: Text -> Handler Double
getCarbohydrates s = return $ case T.toLower s of
  "хлеб" -> 0.794
  "курица" -> 0
  "говядина" -> 0
  "свинина" -> 0
  "кешью" -> 0.1183
  "мёд" -> 0.9939
  "брокколи" -> 0.597
  "апельсиновый сок" -> 0.9285
  "яблочный сок" -> 0.98
  "шампиньоны" -> 0.4762
  "молоко" -> 0
  _ -> 0

server :: Application
server = serve serverAPI getCarbohydrates

main :: IO ()
main = run 8081 server