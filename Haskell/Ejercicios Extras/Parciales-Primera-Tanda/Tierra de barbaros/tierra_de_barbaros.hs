--asdads 
import Text.Show.Functions
import Data.Char (toUpper)


data Barbaro = Barbaro {
    nombre :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objeto]
} deriving  Show

type Objeto = Barbaro -> Barbaro

dave :: Barbaro

dave = Barbaro "Dave" 100 [ "tejer", "escribirPoesia", "Escribir Poesia Atroz"] [ardilla, varitasDefectuosas]

faffy :: Barbaro

faffy = Barbaro "Faffy" 10 ["AEAI"] [ardilla]

-- ardilla :: Objeto
-- ardilla x = x  -- hace nada, solo para que compile
-- varitasDefectuosas :: Objeto
-- varitasDefectuosas x = x
-- accesorios --

mapNombre :: (String -> String) -> Barbaro -> Barbaro
mapNombre f unBarbaro = unBarbaro { nombre = f . nombre $ unBarbaro}

mapFuerza :: (Int -> Int) -> Barbaro -> Barbaro
mapFuerza f unBarbaro = unBarbaro { fuerza = f . fuerza $ unBarbaro}

mapHabilidades :: ([String] -> [String]) -> Barbaro -> Barbaro
mapHabilidades f unBarbaro = unBarbaro { habilidades = f . habilidades $ unBarbaro}

mapObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
mapObjetos f unBarbaro = unBarbaro { objetos = f . objetos $ unBarbaro}

-- accesorios --


espada :: Int -> Barbaro -> Barbaro
-- espada :: Int -> Objeto
espada pesoEspada = mapFuerza (+ pesoEspada * 2) 

agregarHabilidad :: String -> Barbaro -> Barbaro
agregarHabilidad unaHabilidad unBarbaro = mapHabilidades (++ [unaHabilidad]) unBarbaro

amuletosMisticos :: String -> Objeto
amuletosMisticos = agregarHabilidad


varitasDefectuosas :: Objeto
varitasDefectuosas  unBarbaro = (agregarHabilidad "hacerMagia" .desaparecerObjetos) unBarbaro

desaparecerObjetos :: Objeto
desaparecerObjetos unBarbaro = unBarbaro { objetos = []}
-- desaparecerObjetos unBarbaro = unBarbaro { objetos = [varitasDefectuosas]}

ardilla :: Objeto
ardilla = id

cuerda :: Objeto -> Objeto -> Objeto
cuerda  = (.)


-- ghci> habilidades dave
-- ["tejer","escribirPoesia"]


------------- PUNTO 2

concatenarEnMayusculas :: [String] -> String
concatenarEnMayusculas lista = (map(toUpper) . (concat)) lista

megafono :: Objeto 
megafono unBarbaro = unBarbaro {habilidades = [concatenarEnMayusculas (habilidades unBarbaro)]}

megafonoBarbarico :: Objeto 
megafonoBarbarico = cuerda ardilla megafono 


type Aventura = [Evento]
type Evento = Barbaro -> Bool

invasiondeSuciosDuende :: Evento
invasiondeSuciosDuende unBarbaro = (elem "Escribir Poesia Atroz" . habilidades) unBarbaro
-- primero se eaplica lo de la derecha, y despues izquierda
    -- primero con habilidades se saca la lista de habilidades [] y despues se verifica si elem "" esta en esa lista
  --elem("Escribir Poesia Atroz") (habilidades unBarbaro)


cremalleraDeItem :: Evento
cremalleraDeItem unBarbaro = (not.esFaffyOAStro.nombre) unBarbaro
-- De derecha a izquierda
-- primero saca el NOMBRE, después compara el nombre con faffy o astro, ultimo, niega el bool

esFaffyOAStro :: String -> Bool
esFaffyOAStro "Faffy" = True
esFaffyOAStro "Astro" = True
esFaffyOAStro _ = False 
-- cremalleraDeItem (Barbaro nombre _ _ _ ) = not(nombre == "Faffy" || nombre == "Astro")
-- todos sobreviven, excepto faffy y astro



-- nombrePrueba :: a->a

-- nombrePrueba string
--     | string == "hola" = "ambos de tesaludan"
--     | string == "chau" = "se despide"
--     | otherwise = "ni idea que dijo"


------------- PUNTO 3

saqueo :: Evento --Barbaro -> Bool
saqueo unBarbaro = tieneHabilidad "robar" unBarbaro && fuerzaMayorA80 unBarbaro
-- Si borro el unBarbaro (aunque en las otras funciones lo saque, aca LLORA si lo saco)
--elem("robar") (habilidades unBarbaro) || (fuerza unBarbaro) > 80

tieneHabilidad :: String -> Barbaro -> Bool
tieneHabilidad habilidad = elem(habilidad) . habilidades
-- primero saca las habilidadesm y despues verifica el elem(habilidades)

fuerzaMayorA80 :: Barbaro -> Bool
fuerzaMayorA80 = ((>80). fuerza) 

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = cantidadLetrasHabilidades unBarbaro > (4 * cantidadObjetos unBarbaro)

-- [poder = (cantidad de letras habilidades)] > 4 veces la cantidad de objetos

cantidadLetrasHabilidades :: Barbaro -> Int
cantidadLetrasHabilidades unBarbaro = (length.concat.habilidades) unBarbaro


-- cantidadLetrasHabilidades = sum.map length.habilidades

cantidadObjetos :: Barbaro -> Int
cantidadObjetos unBarbaro = (length.objetos) unBarbaro

caligrafia ::  Evento
caligrafia unBarbaro = all (tieneMasDe3VocalesYEmpeizaConMayuscula) (habilidades unBarbaro)

tieneMasDe3VocalesYEmpeizaConMayuscula :: String -> Bool
tieneMasDe3VocalesYEmpeizaConMayuscula habilidad = tieneMasDe3Vocales habilidad && empiezaConMayuscula habilidad

tieneMasDe3Vocales :: String -> Bool
tieneMasDe3Vocales habilidad = ((>3).length.filter esVocal) habilidad

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal 'A' = True
esVocal 'E' = True
esVocal 'I' = True
esVocal 'O' = True
esVocal 'U' = True
esVocal _ = False

empiezaConMayuscula :: String -> Bool
empiezaConMayuscula habilidad = (head habilidad) == (toUpper (head habilidad))
-- empiezaConMayuscula habilidad = (isUpper . head) --habilidad
      -- isUpper es una función que se debe importar previamente, sino se puede con toUpper que se usa 
      -- previamente.

ritualDeFechorias :: Barbaro -> Bool
ritualDeFechorias unBarbaro = saqueo unBarbaro || gritoDeGuerra unBarbaro || caligrafia unBarbaro

-- ritualDeFechorias :: [Evento] -> Evento
-- ritualDeFechorias eventos unBarbaro = any (\evento -> evento unBarbaro) eventos
    -- esta segunda solución no depende se ciertamente 3 eventos, solo le pasas una lista de eventos 



------------- PUNTO 4 A

sinRepetidos :: (Eq a) => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (cabeza : cola)
    | elem cabeza cola = sinRepetidos cola
    | otherwise = (cabeza: sinRepetidos cola)



-- -- ghci> elem "hola" ["hola"]
-- -- True
-- pruebaRecursion (cabeza:cola) = elem cabeza cola 


------------- PUNTO 4 B


-- descendientes :: Barbaro -> Barbaro
-- descendientes unBarbaro 

sumaLista :: [Int] -> Int
sumaLista [] = 0
sumaLista (cabeza:cola) = cabeza + sumaLista (cola)

longitud :: [a] -> Int
longitud [] = 0
longitud (cabeza:cola) = (longitud cola) +1

reverso :: [a] -> [a]
reverso [] =[]
-- reverso (cabeza : cola) = cola ++ (reverso [cabeza])
reverso (cabeza : cola) = (reverso cola) ++ [cabeza]
-- --  reverso "hola" -- "aloh"
--     reverso "ola" ++ ["h"] --           -- [aloh]
--         reverso "la" ++ ["o"]           -- [alo]
--             reverso "a" ++ ["l"]        -- [al]
--                 reverso "a" ++ []       -- [a]
--                     reverso []          -- []



-- pertenece :: Eq a => a -> [a] -> Bool
-- pertenece _ [] = False
-- pertenece  (cabeza:cola) : elem cabeza (pertenece head(cola))

pertenece :: Eq a => a -> [a] -> Bool
pertenece elemento (x:xs)
  | elemento == x = True
  | otherwise     = pertenece elemento xs
pertenece _ [] = False

-- pertenece "a" ["hola" ,"a"]     -- otherwise porque "a" =\ "hola"
--                                 pertenece elemento "a"  -- TRUEE porque "a" = "a"
--                                 -- entonces sale true 


duplicar :: [Int] -> [Int]
duplicar [] = []
duplicar (cabeza : cola) = (2*cabeza) : duplicar (cola)

-- duplicar [1,2,3] = 2*1 : (duplicar [2,3])    -- [2,4,6]
-- duplicar [2,3]   = 2*2 : duplicar [3]        -- [4,6]
-- duplicar [3]     = 2*3 : duplicar []         -- [6]
-- duplicar []                                  -- []


productoria :: [Int] -> Int
productoria [] = 1
productoria (cabeza : cola) = (cabeza * (productoria cola)) 