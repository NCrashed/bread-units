{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
module Main where

import Bread.API
import Data.Proxy
import Data.Text as T
import Network.Wai
import Network.Wai.Handler.Warp
import Servant.API
import Servant.Server
import Servant.Utils.StaticFiles                  (serveDirectory)

-- | Implement endpoint that returns percent of carbohydrates in food
getCarbohydrates :: Text -> Handler Double
getCarbohydrates s = return $ case T.toLower s of
  "хлеб" -> 0.794
  "курица" -> 0
  "говядина" -> 0
  "свинина" -> 0
  "кешью" -> 0.1183
  "мёд" -> 0.9939
  "брокколи" -> 0.6
  "апельсиновый сок" -> 0.9285
  "яблочный сок" -> 0.98
  "шампиньоны" -> 0.4762
  "молоко" -> 0
  "гречка" -> 0.3831
  "рис" -> 0.875
  "геркулес" -> 0.7816
  "пшенка" -> 0.2414
  "манка" -> 0.2254
  _ -> 0

type FullAPI = ServerAPI :<|> Raw

fullAPI :: Proxy FullAPI
fullAPI = Proxy

server :: Application
server = serve fullAPI (getCarbohydrates :<|> serveDirectory "./static")

main :: IO ()
main = run 8081 server