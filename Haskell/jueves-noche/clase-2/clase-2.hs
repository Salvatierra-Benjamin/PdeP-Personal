-- * Existencia, todo el conjunto del que parto tiene que 
-- * tener algun valor asociado en el conjunto asociado

{-
* Me tengo que preocupar por nada, solo porque algo recibe y escupe

* Mis programas son series de transformaciones
-}

-- Las funciones son un puente

-- Primer ejemplo

nombreCompleto nombre apellido = apellido ++ ", " ++ nombre
-- ? El igual, en Haskell, NO es la asignacion, solo te dice que la izquierda es igual
-- ? a la derecha

 
{-
* multiplicar 85 12, ?Prefija 
multiplicar seria la funcion (que esta a la izquierda) y los argumentos a la derecha

Lo mismo que hacer=  85 `multiplicar` 12  
INFIJa



* 85 * 12   Infija
La funcion esta en el medio

Lo mismo que hacer= (*) 85 12
-}

-- PATTERN MATCHING
-- Mira de arriba para abajo, si le paso un 0 => entra en 0 = 1
-- Si le paso un n (otro numero) entra en la segunda

-- Si le paso un número negativo, 
-- Es una funcion parcial, no esta definida para todos los parametro
factorial 0 = 1

factorial n = factorial (n - 1) * n

-- toda funcion recursividad tiene que tener un corte





-- TIPADO = el input y salida
-- (!!) te accede por indice a una palabra

enesimoCaracter :: Int -> String -> Char 
enesimoCaracter n palabra = palabra !! n


-- Inferencia

-- f :: ? -> ? -> ? -- Dos flechas porque tengo 2 argumentos
-- El not recibe un booleano y retorna un booleano, not :: Bool -> Bool
-- Misma logica para el && y el primer argumento, (&&) :: Bool -> Bool
f :: Bool -> Bool -> Bool
f x y = x && not y 

-- Puedo poner cosas diferentes a las que Haskell infiere? 
-- Si, puedo hacer mas fina la definicion (Que sea un float, y no un entero)


-- id :: ? -> ? -- Como se tiene muy poca informacion, se usa una variable
id :: a -> a -- Comodin
id x = x


ignorarElPrimero :: a -> b -> b -- El segundo parametro no necesariamente es igual al primer arg.
ignorarElPrimero x y = y


-- doble :: int -> int 
-- Quiero usar para algo que no necesariamente sea un entero
-- lo quiero para decimales
-- doble :: a -> a -- Tampoco es razonable porque podria meterle strings

-- TYPE CLASSES 
-- Con el Num restringimos a que 'a' sea un numero

doble :: Num a => a -> a -- Familia de tipos, numerico de a, tiene que ser numerico
doble x = x * 2

-- Eq = (==) o por (/=) 
-- Cosas que son Eq: Char, String, Float, Int, Complex

-- LAS FUNCIONES NO SON EQUIPARABLE


-- Ord = (<), (>), (>=), (<=)
-- Cosas que son Ord: Char, String, Float, Int


-- Num = (*), (-), (+)
-- Cosas que son Num: Int, Float, Complex


-- Practica !!!!!!!!!!!!!!!

elMayorDeLosTres :: Ord a => a -> a -> a -> a 

elMayorDeLosTres  a b c = max (max a b) c 

-- max :: Ord a => a -> a -> a



xor :: Bool -> Bool -> Bool

xor True True = False
-- Este es el unico Caso diferente a un Or convencional
-- Este caso particular debe estar arriba para que entre primero
xor  x y = x || y 

fibonacci :: Int -> Int

fibonacci 0 = 0
fibonacci 1 = 1 
fibonacci n = fibonacci(n - 1) + fibonacci(n - 2)

-- Inferencia

-- a.
-- esMuchoMayor :: Int -> Int -> Bool
esMuchoMayor :: (Num a, Ord a) => a -> a -> Bool
esMuchoMayor n m = n - m > 10

-- b.
-- funcionRara :: Int -> Int -> Bool
-- funcionRara :: (Num a, Ord a) => a -> b -> Bool
-- !! No tipa
-- funcionRara n m = esMuchoMayor n (not m)

-- -- c.

-- -- f :: Bool -> [Char] -> Bool
-- f :: Bool -> String -> Bool --Siempre que tipe, siempre que 'y' respete
-- f x y = g (h y (i x y) x ) y 
-- f False " " = True

