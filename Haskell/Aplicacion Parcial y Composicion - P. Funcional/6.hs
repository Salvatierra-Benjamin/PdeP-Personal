{-
Resolver la función del ejercicio 2 de la guía anterior esMultiploDe/2,
utilizando aplicación parcial y composición.
-}

{-
Definir la función esMultiploDe/2, que devuelve True si el segundo es múltiplo del primero, p.ej.
Main> esMultiploDe 3 12
True
-}

division num = (/ 2)

esMultiploDe num num2 = num2 `mod` num == 0

hola x = (== 0) x

-- (==0) es una funcion, y recibe un parametro. devuelve un booleano.

-- em num num2 = (== 0) . (mod num2) num

em num num2 = ((== 0) . mod num2) num
