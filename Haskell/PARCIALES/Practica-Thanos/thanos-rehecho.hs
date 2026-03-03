-- * Punto 1

type Habilidad = String

data Personaje = Personaje
  { edad :: Int,
    energia :: Int,
    habilidades :: [Habilidad],
    nombre :: String,
    planetaEnElQueVive :: String
  }

-- Si tiene 6 gemas y esta hecho de uru, puede charquear
data Guantelete = Guantelete
  { material :: String,
    gemas :: [Gema]
    -- cantidadGemas :: Int
  }

type Universo = [Personaje]

chasquido :: Universo -> Guantelete -> Universo
chasquido universo guantelete
  | estaCompleto guantelete = reducirALaMitadHabitantes universo
  | otherwise = universo

estaCompleto :: Guantelete -> Bool
estaCompleto guantelete = ((&&) (tieneTodasLasGemas guantelete) . estaHechoDeUru) guantelete

estaHechoDeUru :: Guantelete -> Bool
estaHechoDeUru guantelete = ((==) "uru" . material) guantelete

-- ?Se modifica cantidadGemas por una lista de gemas
-- tieneTodasLasGemas :: Guantelete -> Bool
-- tieneTodasLasGemas guantelete = ((<) 6 . cantidadGemas) guantelete
tieneTodasLasGemas :: Guantelete -> Bool
tieneTodasLasGemas guantelete = ((<) 6 . length . gemas) guantelete

reducirALaMitadHabitantes :: Universo -> Universo
reducirALaMitadHabitantes universo = (flip drop universo . div 2 . length) universo

-- * Punto 2

aptoParaPendex :: Universo -> Bool
aptoParaPendex universo = (any ((>) 45 . edad)) universo

sumaTotalEnergia :: Universo -> Int
sumaTotalEnergia universo = (sum . map energia . filter (tieneMasDeNHabilidad 1)) universo

-- !Fue actualizado por tieneMasDeNHabilidad, definida en el punto 3
-- tieneMasDeUnaHabilidad :: Personaje -> Bool
-- tieneMasDeUnaHabilidad personaje = ( (<) 1. length . habilidades) personaje

tieneMasDeNHabilidad :: Int -> Personaje -> Bool
tieneMasDeNHabilidad cantMinima personaje = ((<) cantMinima . length . habilidades) personaje

-- * Punto 3

type Gema = Personaje -> Personaje

modificarEnergia :: (Int -> Int) -> Personaje -> Personaje
modificarEnergia modificador personaje = personaje {energia = (modificador . energia) personaje}

modificarHabilidades :: ([String] -> [String]) -> Personaje -> Personaje
modificarHabilidades modificador personaje = personaje {habilidades = (modificador . habilidades) personaje}

modificarEdad :: (Int -> Int) -> Personaje -> Personaje
modificarEdad modificador personaje = personaje {edad = (modificador . edad) personaje}

setearEnergia :: Int -> Personaje -> Personaje
setearEnergia nuevaEnergia personaje = modificarEnergia (\_ -> nuevaEnergia) personaje

setearEdad :: Int -> Personaje -> Personaje
setearEdad nuevaEdad personaje = personaje {edad = nuevaEdad}

setearPlaneta :: String -> Personaje -> Personaje
setearPlaneta planetaNuevo personaje = personaje {planetaEnElQueVive = planetaNuevo}

laMente :: Int -> Gema
laMente nuevaEnergia personaje
  | nuevaEnergia < (energia personaje) = setearEnergia nuevaEnergia personaje
  | otherwise = personaje

-- ! setear fue abstraida porque se repetia dos veces

-- | nuevaEnergia < (energia personaje) = modificarEnergia (\_ -> nuevaEnergia) personaje
elAlma :: String -> Gema
elAlma habilidadEliminada personaje
  | tieneLaHabilidad habilidadEliminada personaje = (modificarEnergia (flip (-) 10) . modificarHabilidades (quitarHabilidad habilidadEliminada)) personaje
  | otherwise = modificarEnergia (flip (-) 10) personaje

tieneLaHabilidad :: String -> Personaje -> Bool
tieneLaHabilidad habilidadBuscada personaje = (elem habilidadBuscada . habilidades) personaje

quitarHabilidad :: String -> [String] -> [String]
quitarHabilidad habilidadParaRemover habilidades = (filter ((/=) habilidadParaRemover)) habilidades

-- En este caso filter te trae los que son distintos

-- elEspacio :: String -> Gema
-- elEspacio nuevoPlaneta personaje = personaje {planetaEnElQueVive = nuevoPlaneta}
elEspacio :: String -> Gema
elEspacio planetaNuevo = modificarEnergia (flip (-) 20) . setearPlaneta planetaNuevo

elPoder :: Gema
elPoder personaje
  | tieneAlmenosNHabilidades 2 personaje = (setearEnergia 0 . modificarHabilidades (\_ -> [])) personaje
  | otherwise = setearEnergia 0 personaje

-- Creo rotundamente que se podria simplicar en una solo funcion, solo modificando el valor de verdad
-- de tieneMasDeNHabilidad.
-- ?Pero en mi opinion de esta forma queda mas facil de leer.
tieneAlmenosNHabilidades :: Int -> Personaje -> Bool
tieneAlmenosNHabilidades cantMaxima personaje = ((>=) cantMaxima . length . habilidades) personaje

elTiempo :: Gema
-- elTiempo personaje = (modificarEnergia (flip (-) 50) . setearEdad (max 18 (div (edad personaje) 2))) personaje
elTiempo = modificarEnergia (flip (-) 50) . modificarEdad (numeroMaximoA18)

numeroMaximoA18 :: Int -> Int
numeroMaximoA18 = max 18 . flip div 2

laGemaLoca :: Gema -> Personaje -> Personaje
laGemaLoca gemaManipulada personaje = (gemaManipulada . gemaManipulada) personaje

-- * Punto 4

guanteleteGoma :: Guantelete
guanteleteGoma = Guantelete "goma" [elTiempo, elAlma "usar Mjolnir", laGemaLoca (elAlma "programacion en Haskell")]

-- * Punto 5

utilizar :: [Gema] -> Personaje -> Personaje
-- utilizar listaDeGemas personajeEnemigo = foldr ($) personajeEnemigo listaDeGemas -- !No amigable
utilizar gemas personaje = foldl (\personaje gema -> gema personaje) personaje gemas

-- No hay "efecto de lado " si no que se genera un nuevo personaje con nuevos valores,
-- y este es devuelto

-- * Punto 6

gemaMasPoderosa :: [Gema] -> Personaje -> Gema
gemaMasPoderosa [x] _ = x
gemaMasPoderosa (primerGema : segundaGema : gemas) personaje
  | (energia . primerGema) personaje > (energia . segundaGema) personaje = gemaMasPoderosa (segundaGema : gemas) personaje
  | otherwise = gemaMasPoderosa (primerGema : gemas) personaje

-- * Punto 7

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema : (infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3 . gemas) guantelete

{-
gemaMasPoderosa punisher guanteleteDeLocos

usoLasTresPrimerasGemas guanteleteDeLocos punisher
-}
-- Son posible?

{-
-}
