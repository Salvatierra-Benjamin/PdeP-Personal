-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b

-- * foldr recibe tres parametros, el primero siendo una funcion que espera 2 parametros

-- * el segundo parametro es la "semilla" el valor inicial en caso de que la lista este vacia

-- * y el tercer parametro es una lista la cual se va a recorrer

productoria :: [Int] -> Int
productoria = foldr (*) 1

-- productoria numero = foldr (*) 1 numero

-- productoria' :: [Int] -> Int
-- productoria' [] = 1
-- productoria' (x : xs) = x * productoria xs

-- foldr (*) 7 []
-- -> 7

-- ? 7*3 = 21 -> 21 * 2 = 42 -> 42 * 1 = 42
-- foldr (*) 7 [1, 2, 3]
-- -> 42

-- foldr (++) "" ["hola", "chau", "nahue"]
-- -> "holachaunahue"

-- * foldr1 utiliza un elemento de la lista como semilla