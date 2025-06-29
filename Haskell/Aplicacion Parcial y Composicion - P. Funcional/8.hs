{-
Resolver la función inversaRaizCuadrada/1, que da un número n devolver
la inversa su raíz cuadrada.
Main> inversaRaizCuadrada 4
0.5
Nota: Resolverlo utilizando la función inversa Ej. 2.3, sqrt y composición.

-}

mitadPro = (/ 2)

inversa = (** (-1))

-- si pongo 4, me deberia dar 1/2
inversaRaizCuadrada = inversa . sqrt