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
  | ((== 6) . length . gemas) guantelete && ((== "uru") . material) guantelete = (flip take universo . mitadUniverso) universo
  | otherwise = universo

mitadUniverso :: Universo -> Int
mitadUniverso = flip div 2 . length

-- * 2.

paraPendex :: Universo -> Bool
paraPendex = any esPendex

esPendex :: Personaje -> Bool
esPendex = (< 45) . edad

energiaTotal :: Universo -> Int
energiaTotal = sum . map energia . filter (tieneMasDexCantidad 2)

tieneMasDexCantidad :: Int -> Personaje -> Bool
tieneMasDexCantidad cantidad = (>= cantidad) . length . habilidades

-- * Tengo entendido que es lo mismo pero no lo vi asi en la cursada

-- tieneMasDeUnaHabilidad = not. null . habilidades -- !No es lo mismoa,este indica que almenos tiene uno

-- ?Segunda parte ---------------

-- * Punto 3

type Gema = Personaje -> Personaje

modificarHabilidades :: ([String] -> [String]) -> Personaje -> Personaje
modificarHabilidades modificador personaje = personaje {habilidades = (modificador . habilidades) personaje}

modificarPlaneta :: String -> Personaje -> Personaje
modificarPlaneta planetaNuevo personaje = personaje {planeta = planetaNuevo}

modificarEnergia :: (Int -> Int) -> Personaje -> Personaje
modificarEnergia modificador personaje = personaje {energia = (modificador . energia) personaje}

modificarEdad :: (Int -> Int) -> Personaje -> Personaje
modificarEdad modificador personaje = personaje {edad = (modificador . edad) personaje}

laMente :: Int -> Gema
laMente nuevaEnergia = modificarEnergia (\_ -> nuevaEnergia)

tieneEstaHabilidad :: String -> Personaje -> Bool
tieneEstaHabilidad habilidad = elem habilidad . habilidades

sacarHabilidad :: String -> [String] -> [String]
sacarHabilidad habilidad = filter (/= habilidad)

elAlma :: String -> Gema
elAlma habilidad personaje
  | tieneEstaHabilidad habilidad personaje = modificarHabilidades (filter (/= habilidad)) personaje
  | otherwise = personaje

elEspacio :: String -> Gema
elEspacio planetaNuevo = modificarEnergia (flip (-) 20) . modificarPlaneta planetaNuevo

tieneDosHabilidadesOMenos :: Personaje -> Bool
tieneDosHabilidadesOMenos = (<= 2) . length . habilidades

-- !TAKE NO TE SACA DE TU LISTA N ELEMENTOS, TE DEVUELVE UNA LISTA CON ESOS PRIMEROS N ELEMENTOS
elPoder :: Gema
elPoder personaje
  | tieneDosHabilidadesOMenos personaje = (modificarHabilidades (\_ -> []) . modificarEnergia (\_ -> 0)) personaje
  | otherwise = modificarEnergia (\_ -> 0) personaje

elTiempo :: Gema
elTiempo = modificarEnergia (flip (-) 50) . modificarEdad (numeroMaximoA18)

numeroMaximoA18 :: Int -> Int
numeroMaximoA18 = max 18 . flip div 2

laGemaLoca :: Gema -> Gema
laGemaLoca gema = gema . gema

-- * Punto 4

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = Guantelete "" [elTiempo, elAlma "usar Mjolnir", laGemaLoca (elAlma "programacion en haskell")]

-- * Punto 5

-- (a -> b -> b) -> b -> t a -> b
utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas personaje = foldr (\gema personaje -> gema personaje) personaje gemas

-- * Punto 6

-- Punto 6: (2 puntos). Resolver utilizando recursividad. Definir la función
-- gemaMasPoderosa que dado un guantelete y una persona obtiene la gema del infinito que
-- produce la pérdida más grande de energía sobre la víctima.

-- !Mi intento. No me sale.
-- gemaMasPodesora :: Guantelete -> Personaje -> Gema
-- gemaMasPodesora guantelete personaje = (gemaPodesora personaje . gemas) guantelete

-- gemaPodesora :: Personaje -> [Gema] -> Gema
-- gemaPodesora personaje [gema] = gema
-- -- gemaPodesora personaje (x:xs)
-- --   |  (energia . x) personaje

gemaMasPoderosa :: Personaje -> Guantelete -> Gema
-- gemaMasPoderosa personaje guantelte = gemaMasPoderosaDe personaje $ gemas guantelte
gemaMasPoderosa personaje = gemaMasPoderosaDe personaje . gemas

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema
-- * Si hay solo una gema, esa es la mas podesora
gemaMasPoderosaDe personaje (gema1 : gema2 : gemas) 
-- * Se toma dos gemas, se evaluan, la que reduce mas es la que se evaluara
-- * en la siguiente tanda junto con las demas gemas
  | (energia . gema1) personaje < (energia . gema2) personaje = gemaMasPoderosaDe personaje (gema1 : gemas)
  | otherwise = gemaMasPoderosaDe personaje (gema2 : gemas)

-- * Este podria romper si una gema sube la energia


-- ?Punto 7

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

-- *La gracia de este punto es la lazy evaluation, y la lista infinita

-- *El primero no se puede ejecutar, no termina, porque gemaMasPoderosa es recursivo aplicada en una lista infita
-- *asi que nunca terminaria. 

-- *El segundo si se puede ejecutar porque, aunque sea una lista infinita, se saca solo los primeros 3 elementos, y las 
-- *evalua.

-- * No se puede ejecutar. Recursivo en lista infinita|
-- gemaMasPoderosa punisher guanteleteDeLocos  


-- * Si se puede utilizar porque utilizar espera una lista de gemas, que es justo lo que devuelve take 3.
-- usoLasTresPrimerasGemas guanteleteDeLocos punisher


