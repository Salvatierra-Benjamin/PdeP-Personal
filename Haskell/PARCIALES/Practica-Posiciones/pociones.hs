data Persona = Persona {
  nombrePersona :: String,
  suerte :: Int,
  inteligencia :: Int,
  fuerza :: Int
} deriving (Show, Eq)

data Pocion = Pocion {
  nombrePocion :: String,
  ingredientes :: [Ingrediente]
}

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
  nombreIngrediente :: String,
  efectos :: [Efecto]
}

nombresDeIngredientesProhibidos = [
 "sangre de unicornio",
 "veneno de basilisco",
 "patas de cabra",
 "efedrina"]

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun  f ( x : y : xs)
  | f x > f y = maximoSegun f (x:xs)
  | otherwise = maximoSegun f (y:xs)



--  1. 
niveles :: Persona -> [Int]
niveles persona = [fuerza persona , suerte persona , inteligencia persona]

--  Dada una persona definir las siguientes funciones para cuantificar sus 
--  niveles de suerte, inteligencia y fuerza sin repetir código:

--  1.a  sumaDeNiveles que suma todos sus niveles.
--  1.b  diferenciaDeNiveles es la diferencia entre el nivel más alto y más bajo.
--  1.c  nivelesMayoresA n, que indica la cantidad de niveles de la persona que están por encima del valor dado.

--  1.a 
-- Persona {nombrePersona = "pepe", suerte = 2, inteligencia = 3, fuerza = 4}
sumaDeNiveles :: Persona -> Int
-- sumaDeNiveles persona = inteligencia persona + fuerza persona + suerte persona 
-- sumaDeNiveles persona = (sum . niveles) persona
sumaDeNiveles = sum . niveles

--  1.b 
diferenciaDeNiveles :: Persona -> Int
diferenciaDeNiveles persona = maximoNivel persona - minimoNivel persona

maximoNivel = maximum . niveles
minimoNivel = minimum .niveles


-- 1.c 
-- nivelesMayoresA :: Persona -> Int -> Int
nivelesMayoresA :: Int -> (Persona -> Int)

-- nivelesMayoresA n persona = (length . filter (>n) . niveles) persona 
nivelesMayoresA n  = length . filter (>n) . niveles


-- ?--------------------------------------------------------
--  2.
--  Definir la función efectosDePocion que dada una poción devuelve una lista con los
--  efectos de todos sus ingredientes.
-- pocion = [[nombreINgredinte, efecto1] , [otroIngrediente, efecto2] , [otroIngrediente, efecto3]]

efectosDePocion :: Pocion -> [Efecto] 
-- efectosDePocion pocion = (map . take 2) pocion
efectosDePocion = concat . map efectos . ingredientes 
-- efectosDePocion pocion = (concat . map efectos . ingredientes) pocion 

-- map :: (a -> b) -> [a] -> [b]



-- ? ----------------------------------------
--  3.
--  Dada una lista de pociones, consultar:
--    a. Los nombres de las pociones hardcore, que son las que tienen al menos 4
--  efectos.
--    b. La cantidad de pociones prohibidas,  que  son  aquellas  que  tienen  algún
--  ingrediente cuyo nombre figura en la lista de ingredientes prohibidos.
--    c. Si son todas dulces, lo cual ocurre cuando todas las pociones de la lista
-- tienen algún ingrediente llamado “azúcar”


--  3.a 
pocionesHardcore :: [Pocion] -> [String]

pocionesHardcore pociones = (map (nombrePocion) . filter ( (>= 4) . length . efectosDePocion )) pociones

--  3.b 

-- nombresDeIngredientesProhibidos = [
--  "sangre de unicornio",
--  "veneno de basilisco"]

cantPocionesProhibidas :: [Pocion] -> Int
cantPocionesProhibidas  = length . filter esProhibida 

esProhibida :: Pocion -> Bool
esProhibida  = any (flip elem nombresDeIngredientesProhibidos . nombreIngrediente) . ingredientes -- pocion
-- ! ANY ES EL QUE SE ENCARGA DE RECORRER 
-- any :: (a -> Bool) -> [a] -> Bool -- [a] seria ingredientes
-- y (a -> Bool es el elem)



--    c. Si son todas dulces, lo cual ocurre cuando todas las pociones de la lista
-- tienen algún ingrediente llamado “azúcar”

sonTodasDulces :: [Pocion] -> Bool
sonTodasDulces pociones = all (any ( ("azucar" == ). nombreIngrediente) . ingredientes)  pociones
-- all :: (a->Bool) -> [a] -> Bool
-- ! Aca recorre dos veces, una por el all y otra pore el any


-- ? --------------------------------------------------------------------

--  4
--  Definir la función tomarPocion que recibe una poción y una persona, 
--  y devuelve como quedaría la persona después de tomar la poción. Cuando 
--  una persona toma una poción, se aplican todos los efectos de esta última, en orden.
-- ! ES IMPORTANTE QUE NOS GUSTE EL FOLD
tomarPocion :: Pocion -> Persona -> Persona
tomarPocion pocion  personaInicial =  
  ( foldl (\persona efecto -> efecto persona ) personaInicial . efectosDePocion) pocion

-- ? --------------------------------------------------------------------

--  5.
--  Definir la función esAntidotoDe que recibe dos pociones y una persona, y dice si
--  tomar  la  segunda  poción  revierte  los  cambios  que  se  producen  en  la  persona  al
--  tomar la primera.


esAntidotoDe :: Pocion -> Pocion -> Persona -> Bool

esAntidotoDe pocion antidoto persona = 
  ( (== persona) . tomarPocion antidoto .  tomarPocion pocion ) persona



-- ? --------------------------------------------------------------------

--  6.
--  Definir  la  función  personaMasAfectada  que  recibe  una  poción,  una  función
--  cuantificadora (es decir, una función que dada una persona retorna un número) y
--  una lista de personas, y devuelve a la persona de la lista que hace máxima el valor
--  del cuantificador. Mostrar un ejemplo de uso utilizando los cuantificadores definidos
--  en el punto 1.


-- maximoSegun
personaMasAfectada :: Pocion -> (Persona -> Int) -> ([Persona] -> Persona)

personaMasAfectada pocion criterio = maximoSegun ( criterio . tomarPocion pocion)