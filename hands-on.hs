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


-- Given canvas dimensions, return a nested array of coordinates:    
--   [ Rows ] == [ [ Row1Col1, Row1Col2, ... ], ... ] = [ [ (1,1), (2,1), ... ], [ [1,2), (2,2), ... ], ... ]
-- Note that the tuples are arranged as (Column #, Row #).
--
coordinatizer :: CharCanvas -> [[(Int, Int)]]
coordinatizer (CharCanvas { width = w, height = h }) = map (zip [1..w] . replicate w) [1..h]


-- Return an array of strings, one for each row,
-- given canvas dimensions and a function that translates a (column, row) tuple into a Char.
--
-- Usage: overlayArbitrary (CharCanvas 10 5) (\(col, row) -> if col `mod` 2 == 0 then 'X' else '*')
overlayArbitrary :: CharCanvas -> ( (Int,Int) -> Char ) -> [String]
overlayArbitrary canvas f  = map rowOperator coords
  where
    rowOperator :: [(Int, Int)] -> String  -- wrap f so we can use it in an row = array of tuples for the row
    rowOperator = map f

    coords = coordinatizer canvas -- get the canvas as a coordinate stream


-- Usage: putStr $ unlines $ overlayCheckers $ CharCanvas 10 5
overlayCheckers_UPDATE :: CharCanvas -> [String]
overlayCheckers_UPDATE canvas = overlayArbitrary canvas onesZeroes
  where onesZeroes (col, row) = if (col + row) `mod` 2 == 0 then '#' else ' ' 

