# Hands on Haskell

Because I want to _see_ something resulting from my code, for the love of God.

Many thanks to [Learn You a Haskell](http://learnyouahaskell.com/) which was the source of some starter code and ideas!

Start by downloading (ghci)[https://www.haskell.org/ghc/download.html]

## Usage:
```
$ ghci
λ> :l hands-on.hs 
λ> let myRect = Rectangle {topLeft = Point 1.0 2.0, bottomRight = Point 3.0 4.0}
λ> let myCanvas = CharCanvas 8 4
λ> putStr $ paintCanvas myCanvas
##########
#        #
#        #
#        #
#        #
##########
```
