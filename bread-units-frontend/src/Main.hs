import Client
import Control.Lens
import Data.Text
import Reflex.Dom
import Text.Read

showt :: Show a => a -> Text
showt = pack . show

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

lunchWidget :: MonadWidget t m => Text -> m ()
lunchWidget name = elClass "div" "panel" $ elClass "div" "row" $ do
  elClass "div" "col-md-2" $ text name
  elClass "div" "col-md-7" $ intInput 0
  return ()

main :: IO ()
main = mainWidget $ elClass "div" "container" $ lunchWidget "Мёд"
