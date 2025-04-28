{-
Definir la función esCapicua/1, si data una lista de listas, me devuelve si la concatenación de las sublistas es una lista capicua..Ej:
Main> esCapicua ["ne", "uqu", "en"]
True
Porque “neuquen” es capicua.
Ayuda: Utilizar concat/1, reverse/1.

-}
listaPrueba = ["ho", "la"]

listaPrueba2 = ["ne", "uqu", "en"]

-- agarramos la lista, la concatenamos, y despues comparamos con su reverse

esCapicua lista = concat lista == (reverse . concat) lista

-- (concat . reverse) lista y (reverse . concat) lista no es lo mismo

{-

(concat . reverse) lista
= concat (reverse lista)
= concat [[5,6], [3,4], [1,2]]
= [5,6,3,4,1,2]

(reverse . concat) lista
= reverse (concat lista)
= reverse [1,2,3,4,5,6]
= [6,5,4,3,2,1]

-}
