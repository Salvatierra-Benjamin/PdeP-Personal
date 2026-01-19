import Prelude hiding (elem, length)

-- Listas y Orden Superior

-- * ORDEN SUPERIOR. Ciudadanos de primer orden

data Carta = Carta
  { nombre :: String,
    tags :: [String],
    velocidad :: Int,
    altura :: Int,
    peso :: Int,
    fuerza :: Int,
    peleas :: Int
  }
  deriving (Eq, Show)

-- ganadoraSegunVelocidad :: Carta -> Carta -> Carta
-- ganadoraSegunVelocidad carta1 carta2
--     | velocidad carta1 > velocidad carta2 = carta1
--     | otherwise = carta2

-- Esto seguramente resuelve, pero tendria que hacerlo para todos los
-- atributos. Altura, Peso, Fuerza, Peleas

-- * Decimos que una funcion es de Orden Superior cuando esta funcion recibe

-- * por parametro otra funcion

ganadoraSegun :: (Carta -> Int) -> (Carta -> Carta -> Carta)
ganadoraSegun criterio carta1 carta2
  | criterio carta1 > criterio carta2 = carta1
  | otherwise = carta2

ganadoraSegunAltura :: Carta -> Carta -> Carta
ganadoraSegunAltura = ganadoraSegun altura

ganadoraSegunPeso :: Carta -> Carta -> Carta
ganadoraSegunPeso = ganadoraSegun peso

ganadoraSegunFuerza :: Carta -> Carta -> Carta
ganadoraSegunFuerza = ganadoraSegun fuerza

ganadoraSegunPeleas :: Carta -> Carta -> Carta
ganadoraSegunPeleas = ganadoraSegun peleas

flip :: (a -> b -> c) -> (b -> a -> c)
flip f x y = f y x

ganadoraSegunIMC :: Carta -> Carta -> Carta

-- * En el hipotetico caso que este indiceDeMasaCorporal nunca más se vuelva

-- * a usar, porque hacer una funcion entera para solo eso. Aca aparecen las lambda

-- ganadoraSegunIMC = ganadoraSegun indiceDeMasaCorporal

-- indiceDeMasaCorporal :: Carta -> Int
-- indiceDeMasaCorporal carta = peso carta `div` altura carta ^ 2

ganadoraSegunIMC = ganadoraSegun (\carta -> peso carta `div` altura carta ^ 2)

-- ? el primer carta seria el argumento de la funcion

-- ? EXPRESION LAMBDA
-- (\ <parametros> -> <expresion> )

-- ? ------- LISTAS ---------------------
-- Las listas son siempre de algo comun, no puede tener varios tipos

-- [a] = []     -- Nil :: [a]
-- [a] = (:)    -- Cons :: a-> [a] -> [a]
-- Recibe un elemento del conjunto, y el resto. Cabeza y Cola

-- 1 : 2 : 3 : [] :: [Int]
-- [1, 2, 3] :: [Int]

-- * Listas a baja nivel

head :: [a] -> a
head (x : _) = x

tail :: [a] -> [a]
tail (_ : xs) = xs

-- > tail[] -- * Esto romperia con la implementacion de arriba y es lo correcto

null :: [a] -> Bool
null [] = True
null _ = False

tamanio :: [a] -> Int
tamanio [] = 0
tamanio (_ : xs) = 1 + tamanio xs

contiene :: (Eq a) => a -> [a] -> Bool
contiene _ [] = False
contiene x (y : ys) = y == x || contiene x ys

estaOrdenada :: (Ord a) => [a] -> Bool
estaOrdenada [] = True
-- estaOrdenada (_ : []) = True
estaOrdenada [x] = True
estaOrdenada (x : y : ys) = x < y && estaOrdenada (y : ys)

{-
    1. "Quiero ls nombres de las cartas más rapidas qué flash"
    2. "Quiero la fuerza de las cartas cuyo nombre empieza con 'super'"
    3. "Quiero el peso y la altura de las cartas que nunca ganaron una pelea"
-}

-- * Todas se repite a "Quiero <tal transformacion> de las cartas que cumplen <tal criterio>"

-- Quiero el nombre de cada carta
nombres :: [Carta] -> [String]
nombres cartas = map nombre cartas

-- Quiero la fuerza de cada carta
fuerzas :: [Carta] -> [Int]
fuerzas cartas = map fuerza cartas

-- Quiero la longitud del nombre de cada carta
longitudDeNombre :: [Carta] -> [Int]

-- longitudDeNombre cartas = (length . map . nombre) cartas  -- * Este no funciona porque nombre

-- * retorna un string y map necesita una funcion

longitudDeNombre cartas = map (length . nombre) cartas

-- nombre :: Carta -> String
-- length :: String -> Int
-- length . nombre :: Carta -> Int
-- map (length . nombre) :: [Carta] -> [Int]

-- Todas estas se puede hacer con map

-- * map :: (a -> b) -> [a] ->[b]

-- map :: (a -> b) -> ([a] ->[b]) -- Aplico una funcion a toda una lista

-- * filter :: (a -> Bool) -> [a] -> [a]

-- * Quiero las cartas de superheores nuevos

nuevos :: [Carta] -> [Carta]
nuevos cartas = filter ((== 0) . peleas) cartas

-- * Quiero las cartas cuyos nombres tiene 'X'

conX :: [Carta] -> [Carta]
conX cartas = filter (elem 'X' . nombre) cartas

-- * Quiero las cartas con más peso que altura

pesadas :: [Carta] -> [Carta]
pesadas cartas = filter (\c -> peso c > altura c) cartas

-- * Aca usamos lambda

-- ?all :: (a -> Bool) -> [a] -> Bool -- Si todos cumplen
-- ?any :: (a -> Bool) -> [a] -> Bool -- Si almenos 1 existe

-- * Quiero saber si hay cartas de superheores nuevos

hayNuevos :: [Carta] -> Bool
hayNuevos cartas = any ((== 0) . peleas) cartas

-- * Quiero saber si todos los nombres tinen 'X'

todosConX :: [Carta] -> Bool
todosConX cartas = any (elem 'X' . nombre) cartas

-- * Quiero saber si existen cartas con más peso que altura

hayPesadas :: [Carta] -> Bool
hayPesadas cartas = any (\c -> peso c > altura c) cartas

-- ?Estas operaciones se necesitan en base a todos el conjunto. Foldeo
-- ?foldr :: (a -> b -> b) -> b -> [a] -> b
-- ? (a -> b -> b) = funcion reductora
-- ? b  (la primer b) = semilla

-- ? foldr (+) 0 [1 , 2, 3]
-- ? 3 + 0 = 3 -> 3 + 2 = 5 -> 5 + 1 = 6

-- * Quiero saber el total de peleas ganadas

peleasTotales :: [Carta] -> Int
peleasTotales cartas = foldr (\carta acum -> acum + peleas carta) 0 cartas

-- peleasTotales cartas = (sum . map peleas) cartas

-- * Quiero todos los nombres en un string intercalados con ";"

nombresSeperados :: [Carta] -> String
nombresSeperados cartas = foldr (\carta acum -> nombre carta ++ ";" ++ acum) "" cartas

nombresSeparados cartas = (concat . map ((++ ";") . nombre)) cartas

-- * Quiero la carta que tenga la mayor fuerza

masFuerte :: [Carta] -> Carta
-- \* Aca es mas tricki por la semilla, no puedo poner un cero

-- masFuerte cartas = foldr (ganadoraSegun fuerza) (head cartas) (tail cartas)
masFuerte cartas = foldr1 (ganadoraSegun fuerza) cartas

-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- foldl :: (b -> b -> b) -> b -> [a] -> b

-- * Estas de abajo se espera que el primer elemento sea la semilla

-- foldr1 :: (a -> a -> a) -> [a] -> a
-- foldl1 :: (a -> a -> a) -> [a] -> a

-- * Otras funciones utiles:

-- sum :: Num a => [a] -> a
-- maximum :: Ord a => [a] -> a
-- minimum :: Ord a => [a] -> a
-- concat :: [[a]] -> [a]

-- ? ---------------- PRACTICA -------------------

{-
1. Extender las cartas para incluir tags y definir funciones para cambiarlos

2. Dada un mazo de cartas:
    a. Obtener las nombres de las cartas que empiecen con "bat"
    b. Averiguar si hay cartas con todos los tags demasiados largos
    c. Corregir las cartas a las que le ue pusieron el tag #alguien en lugar de #alien
-}

-- * Esta arriba

-- data Carta = Carta {
--     nombre :: String,
--     tags :: [String],
--     velocidad :: Int,
--     altura :: Int,
--     peso :: Int,
--     fuerza :: Int,
--     peleas :: Int
-- } deriving(Eq, Show)

ponerTag :: String -> Carta -> Carta
ponerTag tag carta = carta {tags = tag : tags carta} -- El : no es concatenear.
-- Concatenar es agarrar dos listas y juntar, aca mete un String dentro de una lista

quitarTag :: String -> Carta -> Carta
quitarTag tag carta = carta {tags = filter (/= tag) (tags carta)}

batiNombre :: [Carta] -> [String]
-- batiNombre cartas = ( filtrarLosBati. obtenerNombre) cartas

batiNombre cartas = (filter ((== "bat") . take 3) . map (nombre)) cartas

-- Saco las primeras 3 letras, y despues comparo con "bat"

hayCartasContodosLosTagsMuyLargos :: [Carta] -> Bool
hayCartasContodosLosTagsMuyLargos cartas = (any (all ((> 10) . length) . tags)) cartas

algienCorregidos :: [Carta] -> [Carta]
algienCorregidos cartas =
  (map (ponerTag "alien" . quitarTag "alguien") . filter (elem "alguien" . tags)) cartas

-- desafio: implementar las siguientes funciones usando fold
--     - length
--     - sum
--     - any
--     - all
--     - map
--     - filter