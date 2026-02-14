($) :: (a->b) -> a -> b
$ :: (a -> b) -> a -> b
f $ g $ h x  =  f (g (h x))
peso funcionX elementoY = funcionX elementoY

(.) :: (b->c) -> (a->b) -> (a->c)
flip :: (a->b->c) -> b -> a -> c

-- Para tuplas
ghci> :t fst
fst :: (a, b) -> a
ghci> :t snd
snd :: (a, b) -> b


ghci> :t (-)
(-) :: Num a => a -> a -> a
ghci> (-) 4 3 
1
ghci> (-) 3 4 
-1




-- div dividendo divisor
ghci> :t div
div :: Integral a => a -> a -> a
ghci> div 2 3
0
ghci> div 3 2
1



ghci> :t (/)
(/) :: Fractional a => a -> a -> a
ghci> 10 / 2
5.0
ghci> 7 / 2
3.5
ghci> (-9) / 3
-3.0
ghci> 1 / 4
0.25



ghci> :t (*)
(*) :: Num a => a -> a -> a

-- EL (:) PONE EL ELEMENTO COMO CABEZA DE LA LISTA
ghci> :t (:)
(:) :: a -> [a] -> [a]
ghci> 1 : [2,3]
[1,2,3]
ghci> 'H' : "ola"
"Hola"



-- EL (++) RECIBE DOS LISTAS Y LAS UNE. ¡RECIBE 2 LISTAS!
ghci> :t (++)
ghci> [1,2] ++ [2,3,4]
[1,2,2,3,4]
ghci> "Ho" ++ "la!"
"Hola!"


-- EL (concat) RECIBE UNA LISTA DE LISTAS y devuelve una unica lista
ghci> :t concat
concat :: Foldable t => t [a] -> [a]
ghci> concat [[1,2],[3],[4,5]]
[1,2,3,4,5]
ghci> concat ["Ho","la","!"]
"Hola!"



-- DEVUELVE LOS PRIMEROS N ELEMENTOS
ghci> :t take 
take :: Int -> [a] -> [a]
ghci> take 3 [10,20,30,40,50] 
[10,20,30]
ghci> take 4 "Haskell"   
"Hask"




-- BORRA LOS N ELEMENTOS DE LA LISTA, Y DEVUELVE ESA LISTA SIN LOS N ELEMENTOS
ghci> :t drop 
drop :: Int -> [a] -> [a]
ghci> drop 3 [10,20,30,40,50]
[40,50]
ghci> drop 4 "Haskell"
"ell"

ghci> :t (>)
(>) :: Ord a => a -> a -> Bool
ghci> (>) 50 3 -- 50 > 3
True
ghci> (>) 3 50
False




ghci> :t (<)
(<) :: Ord a => a -> a -> Bool
ghci> (<) 10 20 -- 10 < 20
True
ghci> (<) 20 10 
False




-- *Para calcular porcentajes

20% -> 20/100

( flip div 100 . (*) 20)numero

o simplemente, como como 20/100 = 5
flip div 5



-- * Para ver cuando es menor 
a) Determinar si existe algún aventurero cuyo nombre contenga más de 5 letras.

tieneNombreLargo :: Aventurero -> Bool
tieneNombreLargo = (<) 5 . length . nombre
-- 5 < longitudNombre

-- "le descarga 1 kilo de su carga"
ofrecerSouvenir aventurero = aventurero {carga = (flip (-) 1 . carga) aventurero}
ghci> :t (-)
(-) :: Num a => a -> a -> a
ghci> :t (-) 2
(-) :: Num a => a -> a -> a
ghci> :t (-) 2
ghci> :t (-) 2
(-) 2 :: Num a => a -> a
ghci> (-) 2 3
-1
ghci> flip (-) 2 3
1