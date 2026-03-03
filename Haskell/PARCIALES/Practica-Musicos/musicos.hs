-- type Fecha = (Int, Int, Int)
-- type Actuacion = (Int, Fecha)

data Musico = Musico
  { nombre :: String,
    gradoExp :: Int,
    instrumentoFavorito :: String,
    historialActuacion :: [Actuacion]
  }

data Actuacion = Actuacion
  { fecha :: (Int, Int, Int),
    publico :: Int
  }

-- * Punto 1

actuacionMayor500 :: Musico -> Bool
actuacionMayor500 musico = (any (> 500) . map publico . historialActuacion) musico

-- :t snd
-- snd :: (a, b ) -> b
-- ? Hay que sacarlo con patternMatching al tercer elemento
-- tercerElementoTupla :: (a , b , c) -> c
-- tercerElementoTupla (_ , _ , x) = x
publicoPorAnio :: Int -> Musico -> Int
publicoPorAnio anio musico = (length . filter ((==) anio . (\(_, _, a) -> a) . fecha) . historialActuacion) musico

-- !No se permitia funciones auxiliares
-- publicoPorAnio anio musico = (length . filter (coincideFechaConActuacion anio) . historialActuacion) musico

-- anioGetter :: (a, b, c) -> c
-- anioGetter (_, _, c) = c

-- coincideFechaConActuacion :: Int -> Actuacion -> Bool
-- coincideFechaConActuacion anioBuscado actuacion = ((==) anioBuscado . anioGetter . fecha) actuacion

-- * Punto 2

type Actividad = Musico -> Musico

tocarInstrumento :: String -> Actividad
tocarInstrumento nuevoInstrumento musico = (sumarExperienciaPorInstrumento . setearInstrumento nuevoInstrumento) musico

-- Es una forma diferente. Seteo el nuevo instrumento como favorito (el que vino por parametro)
-- Si el nuevo instrumento favorito es "oboe faggot cello" entonce sumo 1 de Exp
setearInstrumento :: String -> Musico -> Musico
setearInstrumento nuevoInstrumento musico = musico {instrumentoFavorito = nuevoInstrumento}

sumarExperienciaPorInstrumento :: Musico -> Musico
sumarExperienciaPorInstrumento musico
  | (tocaOboeFagotoOCello . instrumentoFavorito) musico = sumar1DeExperiencia musico
  | otherwise = musico

sumar1DeExperiencia :: Musico -> Musico
sumar1DeExperiencia musico = musico {gradoExp = min 10 (gradoExp musico + 1)}

-- modificadorExperiencia :: (Int -> Int) -> Musico -> Musico
-- modificadorExperiencia modificador musico = musico { gradoExp = (modificador . gradoExp) musico}

tocaOboeFagotoOCello :: String -> Bool
tocaOboeFagotoOCello "oboe" = True
tocaOboeFagotoOCello "faggot" = True
tocaOboeFagotoOCello "cello" = True
tocaOboeFagotoOCello _ = False

modificarInstrumentoFavorito :: (String -> String) -> Musico -> Musico
modificarInstrumentoFavorito modificador musico = musico {instrumentoFavorito = (modificador . instrumentoFavorito) musico}

cantar :: Actividad
cantar = modificarInstrumentoFavorito ((++) "Lalala")

presentarPro :: Actuacion -> Actividad
presentarPro actuacion musico = (sumarExperienciaPorInstrumento . sumar1DeExperiencia . modificarHistorial (flip (++) [actuacion])) musico

-- (++) nuevaCabeza cola
-- flip (++) cola  nuevaCabeza
-- ghci> (++) "hola" "chau"
-- "holachau"
-- ghci> flip (++) "hola" "chau"
-- "chauhola"

presentar :: Int -> (Int, Int, Int) -> Actividad
presentar publico fecha musico = (sumarExperienciaPorInstrumento . agregarPresentacion publico fecha) musico

construirActuacion :: Int -> (Int, Int, Int) -> Actuacion
construirActuacion publico fecha = Actuacion fecha publico

agregarPresentacion :: Int -> (Int, Int, Int) -> Musico -> Musico
agregarPresentacion publico fecha musico = (sumar1DeExperiencia . modificarHistorial (flip (++) [construirActuacion publico fecha])) musico

modificarHistorial :: ([Actuacion] -> [Actuacion]) -> Musico -> Musico
modificarHistorial modificador musico = musico {historialActuacion = (modificador . historialActuacion) musico}

pensar :: Actividad
pensar = id

pepe :: Musico
pepe = Musico "pepe" 5 "piano" []

prueba :: Musico -> Musico
prueba musico = (pensar . presentar 300 (2, 8, 2025) . cantar . tocarInstrumento "faggot") musico

prueba2 :: Musico -> Musico
prueba2 musico = (pensar . presentarPro (Actuacion (2, 8, 2025) 300) . cantar . tocarInstrumento "faggot") musico

-- * Punto 3

cuantaExperiencia :: Musico -> [Actividad] -> Int
cuantaExperiencia musico actividades = (gradoExp . hacerActividades actividades) musico

hacerActividades :: [Actividad] -> Musico -> Musico
-- hacerActividades actividades musico = foldr ($) musico actividades
hacerActividades actividades musico = foldl (\musico actividad -> actividad musico) musico actividades

-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b

-- * Punto 4

-- No es necesario verificar que la posicion UNO es una posicion Par...
-- La paridad de las posiciones siempre es la misma y es conocida.
-- Solo hay que verificar verificar la paridad de lo que hay en cada indice.

presentacionesCorrectas :: Musico -> Bool
presentacionesCorrectas musico = (correspondeParidad . map publico . historialActuacion) musico

correspondeParidad :: [Int] -> Bool
correspondeParidad [] = True
correspondeParidad [soloUnNumero] = odd soloUnNumero -- si solo hay un numero en la lista, debe ser impar
correspondeParidad (primerNumero : segundoNumero : numeros) =
  odd primerNumero && even segundoNumero && correspondeParidad (numeros)
