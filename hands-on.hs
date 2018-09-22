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
  (take (h * (w + 3)) (cycle $ "#" ++ (replicate w ' ') ++ "#\n") ) ++
  -- unlines $ overlayShape CharCanvas (Rectangle {topLeft = Point 1.0 2.0, bottomRight = Point 3.0 4.0})
  topBtmBorder
    where topBtmBorder = (replicate (w + 2) '#') ++ "\n"

overlayShape :: CharCanvas -> Shape -> [String]
overlayShape (CharCanvas { width = w, height = h }) sh =
  ["Hello", "World", "!"]

