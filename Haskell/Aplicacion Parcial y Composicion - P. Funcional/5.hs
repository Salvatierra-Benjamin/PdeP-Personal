{-
Definir una función esNumeroPositivo, que invocando a la función con un número cualquiera me devuelva
true si el número es positivo y false en caso contrario.
Main> esNumeroPositivo (-5)
False
Main> esNumeroPositivo 0.99
True
-}

esNumeroPositivo = (> 0)

-- Esto esta bien, pero si escribo por terminal esNumeroPositov -1 , haskell me tomará como
-- (esNumeroPositivo) - (1), una resta. Pues haskell toma el - como una resta y no un signo menos