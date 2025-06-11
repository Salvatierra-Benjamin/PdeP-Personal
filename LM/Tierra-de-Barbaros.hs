import Data.Char (isUpper, toUpper)
import Text.Show.Functions

-- Punto 1
type Objeto = UnBarbaro -> UnBarbaro

data UnBarbaro = Barbaro
  { nombre :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objeto]
  }
  deriving (Show)

pepito = Barbaro "pepito" 20 ["dormir"] []

-- accessors --

mapNombre :: (String -> String) -> UnBarbaro -> UnBarbaro
mapNombre f unBarbaro = unBarbaro {nombre = f (nombre unBarbaro)}

mapFuerza :: (Int -> Int) -> UnBarbaro -> UnBarbaro
mapFuerza f unBarbaro = unBarbaro {fuerza = f . fuerza $ unBarbaro}

mapHabilidades :: ([String] -> [String]) -> UnBarbaro -> UnBarbaro
mapHabilidades f unBarbaro = unBarbaro {habilidades = f . habilidades $ unBarbaro}

-- (f . g) x = f(g(x))

mapObjetos :: ([Objeto] -> [Objeto]) -> UnBarbaro -> UnBarbaro
mapObjetos f unBarbaro = unBarbaro {objetos = f (objetos unBarbaro)}

-- accessors --

-- PUNTO 1 --
espada :: Int -> Objeto
espada pesoEspada unBarbaro = mapFuerza (+ pesoEspada * 2) unBarbaro

agregarHabilidad :: String -> UnBarbaro -> UnBarbaro
agregarHabilidad unaHabilidad unBarbaro = mapHabilidades (++ [unaHabilidad]) unBarbaro

amuletoMistico :: String -> Objeto -- Osea me devuelve una funcion que modifica UnBarbaro, pues asi es como esta declarado con alias
amuletoMistico habilidad unBarbaro = mapHabilidades (++ ["habilidad"]) unBarbaro

varitaDefectuosa :: Objeto
varitaDefectuosa unBarbaro = (mapHabilidades (++ ["hacerMagia"]) . borrarObjetos) unBarbaro

borrarObjetos :: Objeto
borrarObjetos unBarbado = unBarbado {objetos = [varitaDefectuosa]}

pjPrueba = Barbaro "Faffy" 2 ["Dormi", "comer"] []

pjPrueba2 = Barbaro "Faffy2" 200 ["Dormire", "Comera"] []

ardilla :: Objeto
ardilla = id

cuerda :: Objeto -> Objeto -> Objeto
cuerda x y unBarbaro = (x . y) unBarbaro

cuerda2 = (.)

-- cualquierCosa unBarbudo = unBarbudo {nombre = "jeje"}

-- PUNTO 1 --

-- PUNTO 2 --

megafono :: Objeto
megafono unBarbaro = mapHabilidades (ponerEnMayusculas . concatenar) unBarbaro

concatenar :: [String] -> [String] -- En el ejemplo dado, la lista de habilidades queda como una
-- lista de un elemento que tiene concatenado todo
concatenar unasHabilidades = [concat unasHabilidades] -- debo poner en una lista, pues concat devuelve una lista, no un String

ponerEnMayusculas :: [String] -> [String]
ponerEnMayusculas unasHabilidades = map (map toUpper) unasHabilidades

-- PUNTO 2 --

-- PUNTO 3 --

type Aventura = [Evento]

type Evento = UnBarbaro -> Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = elem "Escribir Poesía Atroz" (habilidades unBarbaro) -- habilidades es de las funciones
-- que te da haskell al crear el data

invasionDeSuciosDuendes2 unBarbaro = (elem "Escribir Poesía Atroz" . habilidades) unBarbaro

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = (tienePulgares . nombre) unBarbaro

tienePulgares :: String -> Bool
-- tienePulgares (UnBarbaro nombre _ _ _) = nombre == "Faffy" || nombre == "Astro"
tienePulgares "Faffy" = False
tienePulgares "Astro" = False
tienePulgares _ = True

saqueo :: Evento
saqueo unBarbaro = tieneHabilidad "robar" unBarbaro && esFuerte unBarbaro

tieneHabilidad :: String -> UnBarbaro -> Bool
tieneHabilidad habilidad unBarbaro = (elem habilidad . habilidades) unBarbaro

esFuerte :: UnBarbaro -> Bool
esFuerte unBarbaro = fuerza unBarbaro > 80

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = cantidadDeLetrasDeHabilidades unBarbaro > poderCantidadObjetos unBarbaro

cantidadDeLetrasDeHabilidades :: UnBarbaro -> Int
cantidadDeLetrasDeHabilidades unBarbaro = length (concat (habilidades unBarbaro))

cantidadDeLetrasDeHabilidades2 :: UnBarbaro -> Int
cantidadDeLetrasDeHabilidades2 unBarbaro = (length . concat . habilidades) unBarbaro

poderCantidadObjetos :: UnBarbaro -> Int
poderCantidadObjetos unBarbaro = 4 * length (objetos unBarbaro)

caligrafia :: Evento
caligrafia unBarbaro = (all laHabilidadTieneAlmenos3Vocales . habilidades) unBarbaro && (all habilidadEmpiezaConMayuscula . habilidades) unBarbaro

laHabilidadTieneAlmenos3Vocales :: String -> Bool
laHabilidadTieneAlmenos3Vocales habilidad = ((length . filter esVocal) habilidad) > 3

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'A' = True
esVocal 'e' = True
esVocal 'E' = True
esVocal 'i' = True
esVocal 'I' = True
esVocal 'o' = True
esVocal 'O' = True
esVocal 'u' = True
esVocal 'U' = True
esVocal _ = False

habilidadEmpiezaConMayuscula :: String -> Bool
habilidadEmpiezaConMayuscula habilidad = (isUpper . head) habilidad

ritualDeFechorias :: UnBarbaro -> Bool
ritualDeFechorias unBarbaro = saqueo unBarbaro || gritoDeGuerra unBarbaro || caligrafia unBarbaro

sobrevivientes :: [UnBarbaro] -> Aventura -> [UnBarbaro]
sobrevivientes listaBarbaros = filter concat3Pruebas listaBarbaros

concat3Pruebas :: UnBarbaro -> Bool
concat3Pruebas unBarbaro = invasionDeSuciosDuendes unBarbaro && cremalleraDelTiempo unBarbaro && ritualDeFechorias unBarbaro

-- min 37