import Bread.API
import Client
import Control.Lens
import Control.Monad
import Control.Monad.IO.Class
import Data.Foldable
import Data.Monoid
import Data.Text
import Helpers
import Reflex.Dom
import Text.Read
import Data.Time

type Gramms = Int

lunchItem :: MonadWidget t m => ProductName -> m (Dynamic t Gramms)
lunchItem name = panel $ row $ do
  md4 $ text name
  grammsDyn <- md5 $ intInput "Грамм" 0

  carbPartDyn <- productCarbs name
  md2 $ dynText $ fmap (\v -> showt (100 * v) <> "%") carbPartDyn

  return $ do
    p <- carbPartDyn
    gramms <- grammsDyn
    return $ round (fromIntegral gramms * p)

lunchWidget :: MonadWidget t m => m (Dynamic t Gramms)
lunchWidget = do
  rec
    grammsDyn :: Dynamic t [Dynamic t Gramms] <- collection nameE lunchItem
    nameE <- enterInput
  return $ do
    gramms <- grammsDyn
    fmap sum $ sequence gramms

main :: IO ()
main = do
  mainWidget $ container $ do
    -- gramms <- lunchItem "Мёд"
    gramms <- lunchWidget
    let toBU v = round $ fromIntegral v / 10
    dynText (fmap (\v -> showt v <> " г углеводов, " <> showt (toBU v) <> " ХЕ") gramms)
    -- mmoWidget
    return ()

mmoWidget :: MonadWidget t m => m ()
mmoWidget = do
  clickE <- button "Кликни!"
  t <- liftIO getCurrentTime
  timerE <- tickLossy (realToFrac (5 :: Double)) t
  let updateE = leftmost [const (`div` 2) <$> timerE, const (+1) <$> clickE]
  scoreDyn <- foldDyn ($) (0 :: Int) updateE
  elClass "span" "leftpad" $ dynText $ (\v -> "Кол-во очков: " <> showt v) <$> scoreDyn