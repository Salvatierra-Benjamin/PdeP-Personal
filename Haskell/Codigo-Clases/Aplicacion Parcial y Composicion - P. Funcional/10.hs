{-
Definir una función esResultadoPar/2, que invocándola con número n y otro m,
devuelve true si el resultado de elevar n a m es par.
Main> esResultadoPar 2 5
True
Main> esResultadoPar 3 2
False
Nota Obvia: Resolverlo utilizando aplicación parcial y composición.
-}

-- no puedo usar ** para la potencia, pues even recibe números enteros
esResultadoPar m n = even (m ^ n)

esResultadoPar' m = even . (^ m)
