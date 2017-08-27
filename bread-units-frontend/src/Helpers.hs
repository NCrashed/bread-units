module Helpers(
    showt
  , intInput
  , enterInput
  , collection
  , container
  , panel
  , row
  , md2
  , md3
  , md4
  , md5
  , md6
  , md7
  ) where

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

container :: MonadWidget t m => m a -> m a
container = elClass "div" "container"

panel :: MonadWidget t m => m a -> m a
panel = elClass "div" "panel"

row :: MonadWidget t m => m a -> m a
row = elClass "div" "row"

md2 :: MonadWidget t m => m a -> m a
md2 = elClass "div" "col-md-2"

md3 :: MonadWidget t m => m a -> m a
md3 = elClass "div" "col-md-3"

md4 :: MonadWidget t m => m a -> m a
md4 = elClass "div" "col-md-4"

md5 :: MonadWidget t m => m a -> m a
md5 = elClass "div" "col-md-5"

md6 :: MonadWidget t m => m a -> m a
md6 = elClass "div" "col-md-6"

md7 :: MonadWidget t m => m a -> m a
md7 = elClass "div" "col-md-7"

-- | Special formated input for ints
intInput :: MonadWidget t m => Text -> Int -> m (Dynamic t Int)
intInput label initVal = el "fieldset" $ do
  ti <- elClass "div" "form-group" $ do
    elClass "label" "col-md-5 control-label" $ text (label <> ": ")
    elClass "div" "col-md-4" $
      textInput $ def & textInputConfig_inputType    .~ "number"
                      & textInputConfig_initialValue .~ showt initVal
                      & textInputConfig_attributes   .~ pure [("class", "form-control")]

  let parse = either (const initVal) id . readEither . unpack
  return $ fmap parse (ti ^. textInput_value)

-- | Text input that returns text on enter
enterInput :: MonadWidget t m => m (Event t Text)
enterInput = elClass "div" "name-input" $ do
  ti <- textInput def
  let enterE = keypress Enter ti
  return $ tagPromptlyDyn (ti ^. textInput_value) enterE

-- | Helper wrapper around 'listWithKey'
collection :: (MonadWidget t m, Ord a) => Event t a -> (a -> m b) -> m (Dynamic t [b])
collection e w = do
  let mapE = (fmap (\n -> [(n, Just ())]) e)
  resMapDyn <- listHoldWithKey mempty mapE (\k _ -> w k)
  return $ fmap M.elems resMapDyn
