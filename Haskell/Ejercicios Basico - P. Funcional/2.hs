{-
Definir la función esMultiploDe/2, que devuelve True si el segundo es múltiplo del primero, p.ej.
Main> esMultiploDe 3 12
True
-}

esMultiploDe num num2 = num2 `mod` num == 0