 import Data.Time.Clock
 import Data.Time.LocalTime
 main = do
        now <- getCurrentTime
        timezone <- getCurrentTimeZone
        let (TimeOfDay hour minute second) = localTimeOfDay $ utcToLocalTime timezone now
        putStrLn $ "Hour: " ++ show hour
        putStrLn $ "Minute: " ++ show minute
        -- Note: Second is of type @Pico@: It contains a fractional part.
        -- Use @fromIntegral@ to convert it to a plain integer.
        putStrLn $ "Second: " ++ show second
