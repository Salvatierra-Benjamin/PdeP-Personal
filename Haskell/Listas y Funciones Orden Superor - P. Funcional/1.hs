{-
 Definir una función que sume una lista de números.
Nota: Investigar sum

-}

-- diferencia entre int e integer es que int tiene un limite (dependiendo de la arquitectura, 32 o 64 bits, -2^63 - 2^63 -1)

-- Mientras que integer no tiene limite

lista = [1, 2, 3, 4, 20]

lista2 = [3, 3, 3]

-- sum :: (Foldable t, Num a) => t a -> a

-- Foldable t (t estructura que se puede recorer por ej: una lista []) y Num a es que debe ser un número

-- t a significa que la estructura t tiene elemenentos del tipo Num a

totalListaV1 lista = sum lista

{-
ACA ME DICE REDUNDANTE, PERO SI SACO lista, HASKELL NO SABE QUE TIPO SUMAR
-}

totalListaV2 :: (Foldable t, Num a) => t a -> a
totalListaV2 = sum

-- Aca me ahorro escribir dos veces lista (recibir y pasarlo como parametro) pero debo aclarar que tipo va a usar sum