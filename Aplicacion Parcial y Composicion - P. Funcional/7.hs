{-
Resolver la función del ejercicio 5 de la guía anterior esBisiesto/1, utilizando aplicación parcial y composición.
-}

{-
Definir la función esBisiesto/1, indica si un año es bisiesto. (Un año es bisiesto si es divisible por 400 o es
divisible por 4 pero no es divisible por 100) Nota: Resolverlo reutilizando la función esMultiploDe/2

-}

{-
Jerarquia de operadores:
- parentesis
- aplicacion prefija (ej: siguiente 300)
- compisición
- ** (exponente)
- * , / multiplicacion y division
- + y -
- > , >= , < , <= , == , /=
- && , ||
- ($)
-}

esMultiploDe :: (Integral a) => a -> a -> Bool
esMultiploDe num1 num2 = num1 `mod` num2 == 0

esBisiesto :: (Integral a) => a -> Bool
esBisiesto anio = (esMultiploDe anio 400) || (esMultiploDe anio 100)

-- esBisiesto2 anio = (|| . esMultiploDe 400)  anio

-- osea la disyuncion tiene que tomar dos valores, ambos booleanos
