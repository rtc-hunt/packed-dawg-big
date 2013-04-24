import Criterion.Main
import Criterion.Config
import Data.DAWG
import Paths_dawg

test =  defaultMainWith (defaultConfig  {cfgSamples = ljust 5}) (return())
 
main = do
    dictPath <- getDataFileName "TWL06.txt"
    ws <- fmap lines $ readFile dictPath
    let dawg = fromList ws
    test [
        bench "dawg generation" $ whnf (value . fromList) ws,
        bench "enlist suffixes" $ nf toList dawg,
        bench "serialize"       $ nfIO $ toFile "twl06.dawg" dawg,
        bench "deserialize"     $ nfIO $ fromFile "twl06.dawg"
        ]   