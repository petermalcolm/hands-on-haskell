-- Create a poor man's canvas out of a series of Char's

data CharCanvas = CharCanvas { width :: Int
                             , height :: Int 
                             } deriving (Show)

data Point = Point Float Float deriving (Show)
data Shape = Circle { center :: Point
                    , radius :: Float } | 
             Rectangle { topLeft :: Point
                       , bottomRight :: Point
                       } deriving (Show)

paintCanvas :: CharCanvas -> String
paintCanvas (CharCanvas { width = w, height = h }) =
  topBtmBorder ++
  (take (h * (w + 3)) (cycle $ "#" ++ (take w $ cycle " ") ++ "#\n") ) ++
  topBtmBorder
    where topBtmBorder = (take (w + 2) $ cycle "#") ++ "\n"
