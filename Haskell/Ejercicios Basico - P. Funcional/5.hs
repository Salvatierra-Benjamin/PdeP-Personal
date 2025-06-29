{-
Definir la función esBisiesto/1, indica si un año es bisiesto. (Un año es bisiesto si es divisible por 400 o es
divisible por 4 pero no es divisible por 100) Nota: Resolverlo reutilizando la función esMultiploDe/2
-}

-- seguir con esto

esMultiploDe num1 num2 = mod num1 num2 == 0

esBisiesto anio = esMultiploDe anio 400 || (not (esMultiploDe anio 100) && esMultiploDe anio 4)