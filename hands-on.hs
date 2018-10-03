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
paintCanvas (CharCanvas w h) =
  topBtmBorder ++
  (take (h * (w + 3)) (cycle $ "#" ++ (replicate w ' ') ++ "#\n") ) ++
  -- unlines $ overlayShape CharCanvas (Rectangle {topLeft = Point 1.0 2.0, bottomRight = Point 3.0 4.0})
  topBtmBorder
    where topBtmBorder = (replicate (w + 2) '#') ++ "\n"

-- Usage: putStr $ unlines $ overlayShape (CharCanvas 20 20) myRect
overlayShape :: CharCanvas -> Shape -> [String]
overlayShape (CharCanvas w h) (Circle c r)      = ["circle!"]
overlayShape (CharCanvas w h) (Rectangle tl br) = ["rectangle!"]


-- Usage: putStr $ unlines $ overlayCheckers $ CharCanvas 10 5
overlayCheckers :: CharCanvas -> [String]
overlayCheckers (CharCanvas { width = w, height = h }) =
  let m = map (zip [1..w] . replicate w) [1..h] -- Create a column-major [[(1,1),(2,1),(3,1)],[(1,2),(2,2),(3,2) ...
      onesZeroes = map (map $ \(x,y) -> ((x + y) `mod` 2)) m -- Convert m to [[0,1,0],[1,0,1],[0,1,0],[1,0,1]]
  in map (map $ \(x) -> if x == 1 then ' ' else '#') onesZeroes -- Convert onesZeroes to ["# #"," # ","# #"," # "]
