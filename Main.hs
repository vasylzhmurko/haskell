import Data.Char

to_lower_case = \char -> return $ toLower char
underline_spaces = \char -> if char == ' ' then return '_' else return char

main :: IO ()
main = do
  name <- getLine
  print $ name >>= to_lower_case >>= underline_spaces
 
