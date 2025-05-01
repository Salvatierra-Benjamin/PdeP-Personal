{-
Definir una función incrementMCuadradoN, que invocándola con 2 números m y n,
incrementa un valor m al cuadrado de n por Ej:
Main> incrementMCuadradoN 3 2
11
Incrementa 2 al cuadrado de 3, da como resultado 11.
Nota: Resolverlo utilizando aplicación parcial y composición.
-}
cuadrado = (** 2)

incrementCuadradoN m = (+) (cuadrado m)

-- se podria sacar m también, pero personalmente me marea como haskell
-- cual es m o n

{-
ghci> :t incrementCuadradoN
incrementCuadradoN :: Double -> Double -> Double
ghci> :t incrementCuadradoN 2
incrementCuadradoN 2 :: Double -> Double
ghci> :t incrementCuadradoN 2 2
incrementCuadradoN 2 2 :: Double
ghci> incrementCuadradoN 2 2
6.0

-}
