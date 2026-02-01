import Text.Show.Functions

-- PdePerritos
data Perro = UnPerro {
  raza :: String,
  juguetes :: [String],
  tiempoDePermanencia :: Int,
  energia :: Int
} deriving (Show)

mapJuguetes :: ([String] -> [String]) -> Perro -> Perro
mapJuguetes fn perro = perro { juguetes = fn . juguetes $ perro }

agregarJuguete :: String -> Perro -> Perro
agregarJuguete juguete = mapJuguetes (juguete :)

tieneJuguete :: String -> Perro -> Bool
tieneJuguete juguete = elem juguete . juguetes

perderPrimerJuguete :: Perro -> Perro
perderPrimerJuguete = mapJuguetes (drop 1)

mapEnergia :: (Int -> Int) -> Perro -> Perro
mapEnergia fn perro = perro { energia = max 0 . fn . energia $ perro }

-- Guarderías
type Ejercicio = Perro -> Perro

type Actividad = (Ejercicio, Int)

ejercicio :: Actividad -> Ejercicio
ejercicio = fst

duracionActividad :: Actividad -> Int
duracionActividad = snd

data Guarderia = UnaGuarderia {
  nombre :: String,
  rutina :: [Actividad]
} deriving Show

-- Ejercicios
jugar :: Ejercicio
jugar = mapEnergia (subtract 10)

ladrar :: Int -> Ejercicio
ladrar ladridos = mapEnergia (+ ladridos `div` 2)

regalar :: String -> Ejercicio
regalar = agregarJuguete

diaDeSpa :: Ejercicio
diaDeSpa perro
  | puedeHacerSpa perro = mapEnergia (const 100) . regalar "Peine de goma" $ perro
  | otherwise           = perro

diaDeCampo :: Ejercicio
diaDeCampo = perderPrimerJuguete . jugar

-- Auxiliares
permaneceAlMenos :: Int -> Perro -> Bool
permaneceAlMenos minutos = (>= minutos) . tiempoDePermanencia

esPerroExtravagante :: Perro -> Bool
esPerroExtravagante = esRazaExtravagante . raza

esRazaExtravagante :: String -> Bool
esRazaExtravagante "Dálmata"   = True
esRazaExtravagante "Pomerania" = True
esRazaExtravagante _           = False

puedeHacerSpa :: Perro -> Bool
puedeHacerSpa perro = permaneceAlMenos 50 perro || esPerroExtravagante perro

-- Zara
zara = UnPerro {
  raza = "Dálmata",
  juguetes = ["Pelota", "Mantita"],
  tiempoDePermanencia = 90,
  energia = 80
}

-- GuarderíaPdePerritos
guarderia = UnaGuarderia { 
  nombre = "Guardería PdePerritos",
  rutina = [
    (jugar, 30),
    (ladrar 18, 20),
    (regalar "Pelota", 0),
    (diaDeSpa, 0),
    (diaDeCampo, 0)
  ]
}

-- Parte B
puedeEstar :: Perro -> Guarderia -> Bool
puedeEstar perro = flip permaneceAlMenos perro . duracionRutina . rutina

esPerroResponsable :: Perro -> Bool
esPerroResponsable = tieneMasDeNJuguetes 3 . diaDeCampo

hacerRutinaDeGuarderia :: Guarderia -> Perro -> Perro
hacerRutinaDeGuarderia guarderia perro
  | puedeEstar perro guarderia = (componerRutina . rutina $ guarderia) perro
  | otherwise = perro

perrosCansados :: Guarderia -> [Perro] -> [Perro]
perrosCansados guarderia = filter (estaCansado . hacerRutinaDeGuarderia guarderia)

-- Auxiliares
duracionRutina :: [Actividad] -> Int
duracionRutina = sum . map duracionActividad

tieneMasDeNJuguetes :: Int -> Perro -> Bool
tieneMasDeNJuguetes cantidad = (> cantidad) . length . juguetes

-- Opción A: Fold para componer todos los ejercicios en uno
componerRutina :: [Actividad] -> Ejercicio
componerRutina = foldr ((.) . ejercicio) id

-- Opción B: Fold sobre el perro aplicando los ejercicios
aplicarRutina :: [Actividad] -> Perro -> Perro
aplicarRutina rutina perro = foldr ejercicio perro rutina

estaCansado :: Perro -> Bool
estaCansado = (< 5) . energia

-- Parce C
sogasInfinitas :: [String]
sogasInfinitas = map (\n -> "Soguita " ++ show n) [1 ..]

perroPi = UnPerro { 
  raza = "Labrador",
  juguetes = sogasInfinitas,
  tiempoDePermanencia = 314,
  energia = 159
}

-- 1. ghci> esPerroExtravagante pi
-- Devuelve `False`.
-- Se puede porque evalúo solo la raza

-- 2.a ghci> tieneJuguete "Huesito" pi
-- * Depende*

-- No termina nunca porque tiene que trabajar con
-- la lista infinita entera para ver si alguno de
-- los elementos es "Huesito" y tiene infinitos jugutes *antes*.
-- En realidad depende de si le regalamos un huesito
-- antes de consultar porque la función solo puede terminar
-- cuando encuentra "Huesito" como elemento de la lista y al regalar
-- estoy poniendo al nuevo juguete como cabeza.

-- 2.b ghci> tieneJuguete "Pelota" . hacerRutinaDeGuarderia guarderia $ pi
-- Al hacer la rutina de la guardería se le regala una pelota
-- cuando recibe la pelota esta queda como primer elemento de la lista
-- y por eso la función puede terminar.

-- 2.c ghci>

-- ghci> tieneJuguete "Soguita 31112" pi
-- Devuelve `True`.

-- ghci> hacerRutinaDeGuarderia guarderia $ perroPi
-- La puede hacer (le cambia la energía y
-- otras cosas pero al mostrarlo por consola no va a
-- terminar de mostrar nunca).

-- ghci> regalar "Hueso" perroPi
-- Lo podemos hacer pero no se va a terminar de mostrar
-- al perro por consola.