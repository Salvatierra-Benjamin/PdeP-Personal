-- type Gema = Personaje -> Personaje -- *Esta definido más abajo

data Guantelete = Guantelete
  { material :: String,
    -- gemas :: Int
    gemas :: [Gema]
  }

type Habilidades = String

data Personaje = Personaje
  { nombre :: String,
    edad :: Int,
    energia :: Int,
    habilidades :: [Habilidades],
    planeta :: String
  }
  deriving (Eq, Show)

type Universo = [Personaje]

-- ghci> div 9 4
-- 2
-- ghci> :t div
-- div :: Integral a => a -> a -> a

chasquido :: Guantelete -> Universo -> Universo
chasquido guantelete universo
  -- \| ((== 6) . gemas) guantelete && ((== "uru") . material) guantelete = (flip take universo . mitadUniverso) universo
  | estaCompleto guantelete = reducirALaMitadHabitantes universo
  | otherwise = universo

mitadUniverso :: Universo -> Int
mitadUniverso = flip div 2 . length

estaCompleto :: Guantelete -> Bool
estaCompleto guantelete = ((&&) (tieneTodasLasGemas guantelete) . estaHechoDeUru) guantelete

estaHechoDeUru :: Guantelete -> Bool
estaHechoDeUru guantelete = ((==) "uru" . material) guantelete

tieneTodasLasGemas :: Guantelete -> Bool
tieneTodasLasGemas guantelete = ((==) 6 . length . gemas) guantelete

reducirALaMitadHabitantes :: Universo -> Universo
reducirALaMitadHabitantes universo = (flip take universo . div 2 . length) universo

-- * 2.

paraPendex :: Universo -> Bool
paraPendex universo = (any esPendex) universo

esPendex :: Personaje -> Bool
esPendex personaje = ((>) 45 . edad) personaje

energiaTotal :: Universo -> Int
energiaTotal universo = (sum . map energia . filter (tieneMasDexCantidad 2)) universo

tieneMasDexCantidad :: Int -> Personaje -> Bool
tieneMasDexCantidad cantidad personaje = ((<=) cantidad . length . habilidades) personaje

-- * Tengo entendido que es lo mismo pero no lo vi asi en la cursada

-- tieneMasDeUnaHabilidad = not. null . habilidades -- !No es lo mismoa,este indica que almenos tiene uno

-- ?Segunda parte ---------------

-- * Punto 3

type Gema = Personaje -> Personaje

modificarHabilidades :: ([String] -> [String]) -> Personaje -> Personaje
modificarHabilidades modificador personaje = personaje {habilidades = (modificador . habilidades) personaje}

setearPlaneta :: String -> Personaje -> Personaje
setearPlaneta planetaNuevo personaje = personaje {planeta = planetaNuevo}

modificarEnergia :: (Int -> Int) -> Personaje -> Personaje
modificarEnergia modificador personaje = personaje {energia = (modificador . energia) personaje}

setearEnergia :: Int -> Personaje -> Personaje
setearEnergia nuevaEnergia personaje = modificarEnergia (\_ -> nuevaEnergia) personaje

modificarEdad :: (Int -> Int) -> Personaje -> Personaje
modificarEdad modificador personaje = personaje {edad = (modificador . edad) personaje}

-- Gema = Personaje -> Personaje
-- laMente :: Int -> Gema
-- laMente nuevaEnergia = setearEnergia nuevaEnergia
laMente :: Int -> Gema
-- \*Solo hara efecto si el nuevo valor es menor. "reduce"
laMente nuevaEnergia personaje
  | nuevaEnergia < (energia personaje) = setearEnergia nuevaEnergia personaje
  | otherwise = personaje

elAlma :: String -> Gema
elAlma habilidadEliminada personaje
  | tieneEstaHabilidad habilidadEliminada personaje = (modificarEnergia (flip (-) 10) . modificarHabilidades (quitarHabilidad habilidadEliminada)) personaje
  | otherwise = modificarEnergia (flip (-) 10) personaje

tieneEstaHabilidad :: String -> Personaje -> Bool
tieneEstaHabilidad habilidad personaje = (elem habilidad . habilidades) personaje

quitarHabilidad :: String -> [String] -> [String]
quitarHabilidad habilidadParaRemover habilidades = (filter (/= habilidadParaRemover)) habilidades

-- En este caso filter te trae los que son distintos

elEspacio :: String -> Gema
elEspacio planetaNuevo = modificarEnergia (flip (-) 20) . setearPlaneta planetaNuevo

-- !TAKE NO TE SACA DE TU LISTA N ELEMENTOS, TE DEVUELVE UNA LISTA CON ESOS PRIMEROS N ELEMENTOS
elPoder :: Gema
elPoder personaje
  | tieneDosHabilidadesOMenos personaje = (modificarHabilidades (\_ -> []) . setearEnergia 0) personaje
  | otherwise = setearEnergia 0 personaje

tieneDosHabilidadesOMenos :: Personaje -> Bool
tieneDosHabilidadesOMenos personaje = ((>=) 2 . length . habilidades) personaje

elTiempo :: Gema
elTiempo = modificarEnergia (flip (-) 50) . modificarEdad (numeroMaximoA18)

numeroMaximoA18 :: Int -> Int
numeroMaximoA18 = max 18 . flip div 2

laGemaLoca :: Gema -> Personaje -> Personaje
laGemaLoca gemaManipulada personaje = (gemaManipulada . gemaManipulada) personaje

-- * Punto 4

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = Guantelete "goma" [elTiempo, elAlma "usar Mjolnir", laGemaLoca (elAlma "programacion en haskell")]

-- * Punto 5

-- (a -> b -> b) -> b -> t a -> b
utilizar :: [Gema] -> Personaje -> Personaje
utilizar listaDeGemas personaje = foldr (\gema personaje -> gema personaje) personaje listaDeGemas

-- utilizar listaDeGemas personajeEnemigo = foldr ($) personajeEnemigo listaDeGemas -- !No amigable

-- No hay "efecto de lado " si no que se genera un nuevo personaje con nuevos valores,
-- y este es devuelto

-- * Punto 6

gemaMasPoderosa :: Personaje -> Guantelete -> Gema
-- gemaMasPoderosa personaje guantelte = gemaMasPoderosaDe personaje $ gemas guantelte
gemaMasPoderosa personaje guantelete = (gemaMasPoderosaDe personaje . gemas) guantelete

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema -- ?Si hay solo una gema, esa es la mas podesora
gemaMasPoderosaDe personaje (gema1 : gema2 : gemas)
  -- ? Se toma dos gemas, se evaluan, la que reduce mas es la que se evaluara
  -- ? en la siguiente tanda junto con las demas gemas
  | (energia . gema1) personaje > (energia . gema2) personaje = gemaMasPoderosaDe personaje (gema2 : gemas)
  -- Si la gema2 deja con menos vida, esta sigue en la lista
  | otherwise = gemaMasPoderosaDe personaje (gema1 : gemas)

-- * Este podria romper si una gema sube la energia

-- ?Punto 7

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema : (infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3 . gemas) guantelete

-- * La gracia de este punto es la lazy evaluation, y la lista infinita

{-
gemaMasPoderosa punisher guanteleteDeLocos
? El primero se puede ejecutar pero no termina, porque gemaMasPoderosa es recursivo aplicada en una lista infita
? asi que nunca terminaria. NO CONVERGE a una gema.
-}
{-
-- usoLasTresPrimerasGemas guanteleteDeLocos punisher
? Si se puede utilizar porque la funcion utilizar espera una lista de gemas, que es justo lo que devuelve take 3.
? Ademas, el segundo, aunque sea una lista infinita, se le saca solo los primeros 3 elementos, y las
? evalua.
-}
