import Bread.API
import Client
import Control.Lens
import Control.Monad
import Data.Foldable
import Data.Monoid
import Data.Text
import Reflex.Dom
import Text.Read
import qualified Data.Map.Strict as M

showt :: Show a => a -> Text
showt = pack . show

-- | Special formated input for ints
intInput :: MonadWidget t m => Int -> m (Dynamic t Int)
intInput initVal = el "fieldset" $ do
  ti <- elClass "div" "form-group" $ do
    elClass "label" "col-md-5 control-label" $ text "Грамм: "
    elClass "div" "col-md-4" $
      textInput $ def & textInputConfig_inputType    .~ "number"
                      & textInputConfig_initialValue .~ showt initVal
                      & textInputConfig_attributes   .~ pure [("class", "form-control")]

  let parse = either (const initVal) id . readEither . unpack
  return $ fmap parse (ti ^. textInput_value)

-- | Text input that returns text on enter
enterInput :: MonadWidget t m => m (Event t Text)
enterInput = do
  ti <- textInput def
  let enterE = textInputGetEnter ti
  return $ tagPromptlyDyn (ti ^. textInput_value) enterE

-- | Helper wrapper around 'listWithKey'
collection :: (MonadWidget t m, Ord a) => Event t a -> (a -> m b) -> m (Dynamic t [b])
collection e w = do
  let mapE = (fmap (\n -> [(n, Just ())]) e)
  resMapDyn <- listHoldWithKey mempty mapE (\k _ -> w k)
  return $ fmap M.elems resMapDyn

type Gramms = Int

lunchWidget :: MonadWidget t m => m (Dynamic t Gramms)
lunchWidget = do
  rec
    grammsDyn :: Dynamic t [Dynamic t Gramms] <- collection nameE lunchItem
    nameE <- elClass "div" "name-input" $ enterInput
  return $ do
    gramms <- grammsDyn
    fmap sum $ sequence gramms

lunchItem :: MonadWidget t m => Text -> m (Dynamic t Gramms)
lunchItem name = elClass "div" "panel" $ elClass "div" "row" $ do
  elClass "div" "col-md-4" $ text name
  grammsDyn <- elClass "div" "col-md-5" $ intInput 0

  carbPartDyn <- productCarbs name
  elClass "div" "col-md-2" $ do
    dynText $ fmap (\v -> showt v <> "%") carbPartDyn

  return $ do
    p <- carbPartDyn
    gramms <- grammsDyn
    return $ round (fromIntegral gramms * p)

main :: IO ()
main = mainWidget $ elClass "div" "container" $ do
  gramms <- lunchWidget
  dynText (fmap (\v -> showt v <> " г") gramms)
  return ()
