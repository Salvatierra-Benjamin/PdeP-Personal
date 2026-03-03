-- type Condicion = Chofer -> Viaje -> Bool -- Por ahora

type Condicion = Viaje -> Bool -- Por ahora

type Dia = Int

type Mes = Int

type Anio = Int

type Fecha = (Dia, Mes, Anio)

data Chofer = Chofer
  { nombreChofer :: String,
    kilometrajeAuto :: Int,
    viajesTomados :: [Viaje],
    -- \*O un int por cantidad?
    condicion :: Condicion
  }

data Viaje = Viaje
  { fecha :: Fecha,
    costo :: Int,
    cliente :: Cliente
  }

data Cliente = Cliente
  { nombreCliente :: String,
    domicilio :: String
  }

-- * Punto 2

viajeCualquiera :: Viaje -> Bool
viajeCualquiera _ = True

viajeCaro :: Viaje -> Bool
viajeCaro = (> 200) . costo

viajeConLargoNombreDeCliente :: Int -> Viaje -> Bool
viajeConLargoNombreDeCliente cantidadLetras = (> cantidadLetras) . length . nombreCliente . cliente

viajeZonaProhibida :: String -> Viaje -> Bool
viajeZonaProhibida zona = (== zona) . domicilio . cliente

-- * Punto 3

lucas :: Cliente
lucas = Cliente "Lucas" "Victoria"

viajeLucas :: Viaje
viajeLucas = Viaje (20, 04, 2017) 150 lucas

daniel :: Chofer
daniel = Chofer "daniel" 23500 [viajeLucas] (viajeZonaProhibida "Olivos")

-- dani = Chofer "Daniel" 23500 [Viaje (20, 4, 2017) lucas 150] (clienteNoViveEn "Olivos") -- ? Version de dodino

alejandra :: Chofer
alejandra = Chofer "Alejandra" 180000 [] viajeCualquiera

-- * Punto 4

-- !lazy evaluation o curryficacion/aplicacion parcial
puedeTomarViaje :: Chofer -> Viaje -> Bool
puedeTomarViaje chofer = (condicion chofer)

-- puedeTomarViaje chofer viaje = (condicion chofer) viaje

-- ? Primero se aplica el (condicion chofer), que devuelve Viaje -> Bool

-- ?Ahi, se aplica el viaje

-- * Punto 5

liquidacion :: Chofer -> Int
liquidacion = sum . (map costo) . viajesTomados

-- ? Alternativas de dodino: Usando foldr y foldl:
-- liquidacionChofer :: Chofer -> Number
-- liquidacionChofer chofer = foldr ((+) . costo) 0 (viajes chofer)

-- liquidacionChofer3 chofer = foldl (\acum viaje -> acum + costo viaje) 0 (viajes chofer)

-- * Punto 6

-- Parece ser que todo el punto 6 es hacer que se aniden las 3 funciones

realizarViaje :: Viaje -> [Chofer] -> Chofer
realizarViaje viaje choferes = (incorporarViaje viaje . elQueMenosViajeTenga . choferesInteresados viaje) choferes

choferesInteresados :: Viaje -> [Chofer] -> [Chofer]
choferesInteresados viaje = filter (flip puedeTomarViaje viaje)

elQueMenosViajeTenga :: [Chofer] -> Chofer
elQueMenosViajeTenga [chofer] = chofer
elQueMenosViajeTenga (choferUno : choferDos : choferes)
  | cantidaDeViajes choferUno > cantidaDeViajes choferDos = elQueMenosViajeTenga (choferUno : choferes)
  | cantidaDeViajes choferUno < cantidaDeViajes choferDos = elQueMenosViajeTenga (choferDos : choferes)

cantidaDeViajes :: Chofer -> Int
cantidaDeViajes = length . viajesTomados

efectuarViaje :: Viaje -> [Chofer] -> [Chofer]
-- efectuarViaje viaje choferes = foldr (incorporarViaje viaje) [] choferes
efectuarViaje viaje = map (incorporarViaje viaje)

incorporarViaje :: Viaje -> Chofer -> Chofer
incorporarViaje viaje chofer = chofer {viajesTomados = ((++ [viaje]) . viajesTomados) chofer}

-- ? como viajesTomados es una lista [], viaje tiene que concatenarse como lista [viaje]

-- * Punto 7

viajeConLucas :: Viaje
viajeConLucas = Viaje (11, 03, 2017) 50 lucas

nitoInfy :: Chofer
nitoInfy = Chofer "Nito Infy" 70000 (repetirViaje viajeConLucas) (viajeConLargoNombreDeCliente 3)

repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

-- ? 7.b
-- No se podria calcular la liquidacion de nito porque la liquidacion necesita sumar el costo de cada viaje,
-- pero con infinitos viajes, esto es imposible.

-- ? 7.c
-- Si se puede saber si lo puede tomar o no. Y de hecho, Nito no lo puede tomar, porque Lucas tiene más de 3 letras
-- en su nombre.

-- * Punto 8

-- gongNeng :: (Num a) => a -> ([a] -> Bool) -> ([a] -> [a]) -> a -- !MAL
-- gongNeng :: (Ord a) => a -> (a -> Bool) -> (b -> a) -> [b] -> a





gongNeng :: (Ord a) => a -> (a -> Bool) -> (b-> a) -> [b] -> a
-- gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3
gongNeng arg1 arg2 arg3 lista = (max arg1 . head . filter arg2 . map arg3) lista

-- ? El map tiene que esperar una lista, pero esta lista fue aplicada point free, 
-- ? por eso aparece un cuarto parametro en el tipado

-- map :: (a->b)-> [a] -> [b]
-- map arg3 :: [b] -> [a]
-- ⇒ arg3 :: b -> a

-- filter :: (a->Bool) -> [a] -> [a]
-- filter arg2 :: [a] -> [a]
-- => arg2 :: (a -> Bool)



-- max :: Ord a => a -> a -> a
-- max arg1 :: Ord a => a -> a
-- => arg1 :: Ord a => a










-- arg3 es una funcion (a -> a) que transforme una lista
-- arg2 es una funciton que filtra ([a] -> Bool)
-- Se utiliza head, y despues max, asumo que es una lista de enteros
-- arg1, como se utiliza con un max, debe ser de tipo Int