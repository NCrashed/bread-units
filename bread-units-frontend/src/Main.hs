import Bread.API
import Client
import Control.Lens
import Control.Monad
import Data.Foldable
import Data.Monoid
import Data.Text
import Helpers
import Reflex.Dom
import Text.Read

type Gramms = Int

lunchItem :: MonadWidget t m => ProductName -> m (Dynamic t Gramms)
lunchItem name = panel $ row $ do
  md4 $ text name
  grammsDyn <- md5 $ intInput "Грамм" 0

  carbPartDyn <- productCarbs name
  md2 $ dynText $ fmap (\v -> showt v <> "%") carbPartDyn

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
    gramms <- lunchWidget
    let toBU v = round $ fromIntegral v / 10
    dynText (fmap (\v -> showt v <> " г углеводов, " <> showt (toBU v) <> " ХЕ") gramms)
    return ()
