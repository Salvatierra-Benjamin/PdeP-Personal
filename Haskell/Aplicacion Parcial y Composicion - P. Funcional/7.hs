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

esMultiploDe dividendo divisor = mod dividendo divisor == 0

esBisiesto anio = esMultiploDe anio 400 || (not (esMultiploDe anio 100) && esMultiploDe anio 4)

esBisiesto' anio = (|| (not (esMultiploDe anio 100) && esMultiploDe anio 4))

-- esBisiesto'' anio = || (((not . (esMultiploDe anio)) 100) && esMultiploDe anio 4) (esMultiploDe anio 400)
