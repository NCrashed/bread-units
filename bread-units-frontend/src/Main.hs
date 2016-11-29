import Data.Text
import Reflex.Dom

lunchWidget :: MonadWidget t m => Text -> m ()
lunchWidget name = elClass "div" "panel" $ text name

main :: IO ()
main = mainWidget $ elClass "div" "container" $ lunchWidget "Мёд"
