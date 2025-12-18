{-
Definir la función existsAny/2, que dadas una función booleana y una tupla de tres
elementos devuelve True si existe algún elemento de la tupla que haga verdadera la función.

Main> existsAny even (1,3,5)
False

Main> existsAny even (1,4,7)
True
porque even 4 da True

Main> existsAny (0>) (1,-3,7)
True
porque even -3 es negativo
-}


tuplaEjemplo = (1,2,3)

-- existsAny fBool tupla = 