{-
Definir la función mcm/2 que devuelva el mínimo común múltiplo entre dos números, de acuerdo a esta fórmula.
-}

mcm num1 num2 = div (num1 * num2) (gcd num1 num2)

-- el div es una función, que es la de division pero va de entero a entero (a diferencia del /)
-- div al ser una funcion, lleva sus dos argumentos a su derecha