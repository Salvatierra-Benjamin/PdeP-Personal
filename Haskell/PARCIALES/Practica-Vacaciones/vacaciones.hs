type Idiomas = String

data Turista = Turista
  { cansancio :: Int,
    estres :: Int,
    estaSolo :: Bool,
    idiomasQueHabla :: [Idiomas]
  }
  deriving (Show)

-- * 1.

ana :: Turista
ana = Turista 0 21 True ["espanol"]

beto :: Turista
beto = Turista 15 15 True ["aleman"]

cathi :: Turista
cathi = Turista 15 15 True ["almenan", "catalan"]

-- * 2.

type Excursion = Turista -> Turista

modificarCansancio :: (Int -> Int) -> Turista -> Turista
modificarCansancio modificador turista = turista {cansancio = (modificador . cansancio) turista}

modificarEstres :: (Int -> Int) -> Turista -> Turista
modificarEstres modificador turista = turista {estres = (modificador . estres) turista}

modificarIdiomas :: ([String] -> [String]) -> Turista -> Turista
modificarIdiomas modificador turista = turista {idiomasQueHabla = (modificador . idiomasQueHabla) turista}

modificarSoledad :: Bool -> Turista -> Turista
modificarSoledad soledad turista = turista {estaSolo = soledad}

irAPlaya :: Excursion
irAPlaya turista
  | estaSolo turista = modificarCansancio (5 -) turista
  | otherwise = modificarEstres (1 -) turista

apreciarMomento :: String -> Excursion
apreciarMomento momento turista = (flip modificarEstres turista . (flip (-) . length)) momento

-- apreciarMomento momento turista = (flip (modificarEstres) turista (-) . length) momento
-- apreciarMomento momento turista = (flip modificarEstres (-) turista . length) momento

salirHablarIdioma :: String -> Excursion
salirHablarIdioma idioma = estaAcompaniado . modificarIdiomas (++ [idioma])

estaAcompaniado :: Turista -> Turista
estaAcompaniado turista = turista {estaSolo = False}

caminar :: Int -> Excursion
caminar tiempo = modificarCansancio (+ intensidad tiempo) . modificarEstres (intensidad tiempo -)

intensidad :: Int -> Int
intensidad = flip div 4

data Marea = Fuerte | Moderada | Tranquila

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Fuerte = modificarCansancio (+ 10) . modificarEstres (+ 6)
paseoEnBarco Moderada = id
paseoEnBarco Tranquila = estaAcompaniado . caminar 10

-- * 2a

-- Hacer turimo

hacerExcursion :: Excursion -> Turista -> Turista
hacerExcursion excursion = modificarEstres (`div` 100) . excursion

-- * 2b

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Int) -> Excursion -> Turista -> Int
deltaExcursionSegun indice excursion turista = deltaSegun indice (hacerExcursion excursion turista) turista

-- ?Es importante aca diferenciar como hacerExcursion excursion turista
-- ?no tiene el mismo turista, el de los corchetes es el modificado,
-- ?el que esta solo es el que viene por argumento y ese no tiene nada nuevo

-- * 3

educativa :: Excursion -> Turista -> Bool
educativa excursion = (> 0) . deltaExcursionSegun (cantidadDeIdiomas) excursion

cantidadDeIdiomas :: Turista -> Int
cantidadDeIdiomas = length . idiomasQueHabla

excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes turista = filter (esEstresante turista)

-- \*Aca iria excursiones

esEstresante :: Turista -> Excursion -> Bool
esEstresante turista excursion = ((> 3) . deltaExcursionSegun estres excursion) turista

type Tour = [Excursion]

completo :: Tour
completo = [caminar 20, apreciarMomento "Cascada", caminar 40, salirHablarIdioma "melmacquiano"]

ladoB :: Excursion -> Tour
ladoB excursion = [paseoEnBarco Tranquila, excursion, caminar 120]

islaVecina :: Marea -> Excursion
islaVecina Fuerte = apreciarMomento "algo"
islaVecina _ = irAPlaya

-- ! AUN FALTA VER EL PUNTO 3. INCLUYE FOLD Y OTRAS COSAS
-- type Tour = [Excursion]

-- completo :: Tour
-- completo = [caminar 20, apreciar "cascada", caminar 40, playa, salidaLocal]

-- ladoB :: Excursion -> Tour
-- ladoB excursion = [paseoEnBarco Tranquila, excursion, caminar 120]

-- islaVecina :: Marea -> Tour
-- islaVecina mareaVecina = [paseoEnBarco mareaVecina, excursionEnIslaVecina mareaVecina, paseoEnBarco mareaVecina]

-- --
-- excursionEnIslaVecina :: Marea -> Excursion
-- excursionEnIslaVecina Fuerte = apreciar "lago"
-- excursionEnIslaVecina _  = playa

-- salidaLocal :: Excursion
-- salidaLocal = salirConGente "melmacquiano"

-- -- a)
-- hacerTour :: Turista -> Tour -> Turista
-- hacerTour turista tour =
--   foldl (flip hacerExcursion) (cambiarStress (length tour) turista) tour

-- -- b)
-- propuestaConvincente :: Turista -> [Tour] -> Bool
-- propuestaConvincente turista = any (esConvincente turista)

-- esConvincente :: Turista -> Tour -> Bool
-- esConvincente turista = any (dejaAcompaniado turista) . excursionesDesestresantes turista

-- dejaAcompaniado :: Turista -> Excursion -> Bool
-- dejaAcompaniado turista = not . solitario . flip hacerExcursion turista

-- -- c)
-- efectividad :: Tour -> [Turista] -> Int
-- efectividad tour = sum . map (espiritualidadAportada tour) . filter (flip esConvincente tour)

-- espiritualidadAportada :: Tour -> Turista -> Int
-- espiritualidadAportada tour = negate . deltaRutina tour

-- deltaRutina :: Tour -> Turista -> Int
-- deltaRutina tour turista =
--   deltaSegun nivelDeRutina (hacerTour turista tour) turista

-- nivelDeRutina :: Turista -> Int
-- nivelDeRutina turista = cansancio turista + stress turista

-- -- 4)
-- -- a)
-- playasEternas :: Tour
-- playasEternas = salidaLocal : repeat playa