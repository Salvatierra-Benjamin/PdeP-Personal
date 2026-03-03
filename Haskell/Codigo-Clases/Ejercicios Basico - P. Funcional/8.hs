{-
Definir la función haceFrioF/1, indica si una temperatura expresada en grados Fahrenheit es fría.
Decimos que hace frío si la temperatura es menor a 8 grados Celsius.
-}

fahrToCelsius num = (5 / 9) * (num - 32)

haceFrioF num = fahrToCelsius num < 8