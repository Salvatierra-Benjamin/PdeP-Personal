type Cancion = [Nota]

data Nota = Nota
  { tono :: Int,
    volumen :: Int,
    duracion :: Int
  }
  deriving (Eq, Show)

cambiarVolumen :: (Int -> Int) -> Nota -> Nota
cambiarVolumen delta nota = nota {volumen = delta (volumen nota)}

cambiarTono :: (Int -> Int) -> Nota -> Nota
cambiarTono delta nota = nota {tono = delta (tono nota)}

cambiarDuracion :: (Int -> Int) -> Nota -> Nota
cambiarDuracion delta nota = nota {duracion = delta (duracion nota)}

-- promedo :: [Number] -> Number
-- promedio lista = sum lista / length lista
promedio :: [Int] -> Int
promedio lista = div (sum lista) (length lista)

-- ! Anotar el orden de div, el dividendo y divisor

-- * Punto 1

esAudible :: Nota -> Bool
esAudible nota = volumenAlto 10 nota && frecuenciaMenor 20000 nota && frecuenciaMayor 20 nota

frecuenciaAudible :: Nota -> Bool
frecuenciaAudible nota = tono nota > 20 && tono nota < 20000

volumenAlto :: Int -> Nota -> Bool
volumenAlto volumenAlto nota = ((<) volumenAlto . volumen) nota

frecuenciaMayor :: Int -> Nota -> Bool
-- frecuenciaMayor frecuencia = (> frecuencia) . tono
frecuenciaMayor frecuencia = ((<) frecuencia) . tono

-- 20 < frecuenciaNota

frecuenciaMenor :: Int -> Nota -> Bool
frecuenciaMenor frecuencia = ((>) frecuencia) . tono

-- 2000 < frecuenciaNota

esMolesta :: Nota -> Bool
esMolesta nota = (tonoMenor250VolumenMayor85 nota || tonoMayor250VolumenMenor55 nota) && (not . esAudible) nota

tonoMenor250VolumenMayor85 :: Nota -> Bool
tonoMenor250VolumenMayor85 nota = (esAudible nota) && (frecuenciaMenor 250 nota) && (volumenAlto 85 nota)

tonoMayor250VolumenMenor55 :: Nota -> Bool
tonoMayor250VolumenMenor55 nota = ((&& frecuenciaMayor 250 nota) . volumenAlto 55) nota

-- * Punto 2

silencioTotal :: Cancion -> Int
silencioTotal cancion = (sum . map duracion . filter (not . esAudible)) cancion

sinInterrupciones :: Cancion -> Bool
sinInterrupciones cancion = (all (duracionMayor (div 10 1)) . filter esAudible) cancion

duracionMayor :: Int -> Nota -> Bool
duracionMayor tiempo nota = ((> tiempo) . duracion) nota

peorMomento :: Cancion -> Int
peorMomento cancion = (maximum . map volumen . filter (esMolesta)) cancion

-- * Punto 3

type Filtro = Cancion -> Cancion

trasponer :: Int -> Cancion -> Cancion
-- trasponer escalar cancion = (map (trasponerUnaNota escalar)) cancion
trasponer escalar cancion = (map (cambiarTono ((*) escalar))) cancion

-- trasponerUnaNota :: Int -> Nota -> Nota
-- trasponerUnaNota escalar nota = cambiarTono (2*escalar* )nota

--
acotarVolumen :: Int -> Int -> Cancion -> Cancion
acotarVolumen volumenMaximo volumenMinimo cancion = (map (modificarAVolumenMinimo volumenMinimo . modificarAVolumenMaximo volumenMaximo)) cancion

-- acotarVolumen volumenMaximo volumenMinimo = map (modificarAVolumenMinimo volumenMinimo) . map (modificarAVolumenMaximo volumenMaximo)

setearVolumenNota :: Int -> Nota -> Nota
setearVolumenNota nuevoVolumen nota = cambiarVolumen (\_ -> nuevoVolumen) nota

modificarAVolumenMaximo :: Int -> Nota -> Nota
modificarAVolumenMaximo volumenMaximo nota
  | (((<) volumenMaximo) . volumen) nota = setearVolumenNota volumenMaximo nota
  | otherwise = nota

modificarAVolumenMinimo :: Int -> Nota -> Nota
modificarAVolumenMinimo volumenMinimo nota
  | (((>) volumenMinimo) . volumen) nota = setearVolumenNota volumenMinimo nota
  | otherwise = nota

normalizar :: Cancion -> Cancion
normalizar cancion = (setearVolumenCancion cancion . promedioCancion) cancion

setearVolumenCancion :: Cancion -> Int -> Cancion
setearVolumenCancion cancion nuevoVolumen = map (setearVolumenNota nuevoVolumen) cancion

promedioCancion :: Cancion -> Int
promedioCancion cancion = (promedio . map volumen) cancion

-- * Punto 4

{-
f g [] y z = g y z
f g (x:xs) y z = g (x y) z || f g xs y z
-}

-- !MAL casi f :: ( ( a -> a) -> b -> Bool )-> [a -> a] -> a -> b -> Bool

f :: (a -> b -> Bool) -> [a -> a] -> a -> b -> Bool
f g [] y z = g y z
f g (x : xs) y z = g (x y) z || f g xs y z

{-
g seria la funcion sonIguales.
la lista que recibe f es la lista de filtros
z e y son cancionOriginal y cancionSospechosa

Despues de verificar con todos los filtros, la lista queda vacio, que es igual al caso base,
ahi es cuando se verifica si son iguales sin haberse aplicado filtros.
"sonIguales cancionOriginal cancionSospechosa" algo asi en infringeCopyright es redundante
-}

infringeCopyright :: [Filtro] -> Cancion -> Cancion -> Bool
infringeCopyright filtros cancionOriginal cancionSospechosa = f (==) filtros cancionOriginal cancionSospechosa

-- ! Nota es Eq asi que puedo compararlos.
-- infringeCopyright filtros cancionOriginal cancionSospechosa = f sonIguales filtros cancionOriginal cancionSospechosa
-- sonIguales :: Cancion -> Cancion -> Bool
-- sonIguales unaCancion otraCancion = mismoVolumen unaCancion otraCancion && mismoTono unaCancion otraCancion && mismaDuracion unaCancion otraCancion
-- mismoVolumen :: Cancion -> Cancion -> Bool
-- mismoVolumen unaCancion otraCancion = (==) (map volumen otraCancion) (map volumen unaCancion)
-- mismoTono :: Cancion -> Cancion -> Bool
-- mismoTono unaCancion otraCancion = (==) (map tono otraCancion) (map tono unaCancion)
-- mismaDuracion :: Cancion -> Cancion -> Bool
-- mismaDuracion unaCancion otraCancion = (==) (map duracion otraCancion) (map duracion unaCancion)

{-
f en terminos de expresividad:
es muy poca expresiva, el nombre de la funcion y sus argumentos no reflejan en absoluto
para que se utiliza f. Se puede mejorar su expresividad con nombres descriptivos.

f en terminos de declaratividad:
f con nombres mas expresivos, la puedo considerar declarativa.
Expone bien lo que hace.

-}

-- * Punto 5

tunear :: [Filtro] -> Cancion -> Cancion
-- tunear filtros cancion = (normalizar . foldr ($) cancion) filtros
tunear filtros cancion = (normalizar . foldl (\cancion filtro -> filtro cancion) cancion) filtros

-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- ($) :: (a -> b) -> a -> b
-- ($) f x = f x
