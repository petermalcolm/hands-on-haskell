-- Create a poor man's canvas out of a series of Char's

data CharCanvas = CharCanvas { width :: Int
                             , height :: Int 
                             } deriving (Show)

paintCanvas :: CharCanvas -> String
paintCanvas (CharCanvas { width = w, height = h }) =
  (take (w + 2) $ cycle "#") ++ "\n" ++
  (take (h * (w + 3)) (cycle $ "#" ++ (take w $ cycle " ") ++ "#\n") ) ++
  (take (w + 2) $ cycle "#") ++ "\n"
