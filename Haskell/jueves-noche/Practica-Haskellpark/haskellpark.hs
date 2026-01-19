data Atraccion = Atraccion
  { nombre :: String,
    alturaMinima :: Int,
    duracionAtraccion :: Int,
    opiniones :: [String],
    enMantenimiento :: Bool,
    ordenReparacion :: [Reparacion]
  }

data Reparacion = Reparacion
  { diasParaReparar :: Int,
    trabajoReparacion :: Trabajo
  }

type Trabajo = Atraccion -> Atraccion

type Parque = [Atraccion]

-- * Punto 1

queTanBuenaEs :: Atraccion -> Int
queTanBuenaEs atraccion
  | duracionProlongada atraccion = 100
  | cantidadOrdenesDeReperacion atraccion < 3 = (((+) (cantidadOpiniones atraccion)) . (* 10) . puntajePorLargoDeNombre) atraccion
  --   | cantidadOrdenesDeReperacion atraccion < 3 = (+) (cantidadOpiniones atraccion) ((*) 10 (puntajePorLargoDeNombre atraccion))
  | otherwise = ((* 10) . alturaMinima) atraccion

cantidadOpiniones :: Atraccion -> Int
cantidadOpiniones = length . opiniones

puntajePorLargoDeNombre :: Atraccion -> Int
puntajePorLargoDeNombre = length . nombre

duracionProlongada :: Atraccion -> Bool
duracionProlongada = (>) 10 . duracionAtraccion

cantidadOrdenesDeReperacion :: Atraccion -> Int
cantidadOrdenesDeReperacion = length . ordenReparacion

-- * Punto 2

-- ? /*MODIFICADORES

modificadorOrdenReparacion :: ([Reparacion] -> [Reparacion]) -> Atraccion -> Atraccion
modificadorOrdenReparacion modificador atraccion = atraccion {ordenReparacion = (modificador . ordenReparacion) atraccion}

modificadorMantenimiento :: Bool -> Atraccion -> Atraccion
modificadorMantenimiento estaEnMantenimiento atraccion = atraccion {enMantenimiento = estaEnMantenimiento}

modificadorDuracionAtraccion :: (Int -> Int) -> Atraccion -> Atraccion
modificadorDuracionAtraccion modificador atraccion = atraccion {duracionAtraccion = (modificador . duracionAtraccion) atraccion}

modificadorAlturaMinima :: (Int -> Int) -> Atraccion -> Atraccion
modificadorAlturaMinima modificador atraccion = atraccion {alturaMinima = (modificador . alturaMinima) atraccion}

modificadorOpiniones :: ([String] -> [String]) -> Atraccion -> Atraccion
modificadorOpiniones modificador atraccion = atraccion {opiniones = (modificador . opiniones) atraccion}

-- ?MODIFICADORES */

efectosDeReperacion :: Atraccion -> Atraccion
efectosDeReperacion = tieneReparacionesPendientes . eliminarUltimaReperacion

eliminarUltimaReperacion :: Atraccion -> Atraccion
eliminarUltimaReperacion = modificadorOrdenReparacion (sacarUltimoElemento)

sacarUltimoElemento :: [a] -> [a]
sacarUltimoElemento lista = take ((length lista) - 1) lista

-- Drop te saca una N cantidad de la lista
-- Take te saca la posicion N de la lista

tieneReparacionesPendientes :: Atraccion -> Atraccion
tieneReparacionesPendientes atraccion
  | cantidadOrdenesDeReperacion atraccion > 0 = modificadorMantenimiento True atraccion
  | otherwise = modificadorMantenimiento False atraccion

ajusteDeTornilleria :: Int -> Trabajo
ajusteDeTornilleria cantTornillos atraccion = modificadorDuracionAtraccion ((+) (maximaDuracionAtraccion atraccion cantTornillos)) atraccion

maximaDuracionAtraccion :: Atraccion -> Int -> Int
maximaDuracionAtraccion atraccion cantTornillo = min (10) (cantTornillo * duracionAtraccion atraccion)

engrase :: Int -> Trabajo
engrase grasa atraccion = (modificadorOpiniones (++ ["para valientes"]) . modificadorAlturaMinima ((+) (div (alturaMinima atraccion) 10))) atraccion

-- multiplicar por 0.1  = dividir entre 10
-- 0.1 * = div 10

mantenimientoElectrico :: Trabajo
mantenimientoElectrico = modificadorOpiniones (take 2)

mantenimientoBasico :: Trabajo
mantenimientoBasico = (engrase 10) . (ajusteDeTornilleria 8)

-- * Punto 3

meDaMiedito :: Atraccion -> Bool
meDaMiedito atraccion = ((any (mantenimientoLargo 4)) . ordenReparacion) atraccion

mantenimientoLargo :: Int -> Reparacion -> Bool
mantenimientoLargo dias = (>) dias . diasParaReparar

-- Supongo que con "cerrar" se refiere a poner el atributo enMantenimiento = True
-- y no devolver un falso desde la funcion cerramos
cerramos :: Atraccion -> Atraccion
cerramos atraccion
  | muchaReparacion (ordenReparacion atraccion) = modificadorMantenimiento True atraccion
  | otherwise = atraccion

muchaReparacion :: [Reparacion] -> Bool
muchaReparacion listaReparaciones = (((>) 7) . sum . map diasParaReparar) listaReparaciones

disneyNoEsistis :: Parque -> Bool
disneyNoEsistis parque = all (\atraccion -> (null . ordenReparacion) atraccion) ((filter (\atraccion -> ((> 5) . length . nombre) atraccion)) parque)

-- Con pura composición, ilegible
-- disneyNoEsistis parque = ((all (\atraccion -> (null . ordenReparacion) atraccion)) . (filter (\atraccion -> ((> 5) . length . nombre) atraccion))) parque

-- tieneNombreLargo :: Atraccion -> Bool
-- tieneNombreLargo  = (>) 5 . length . nombre

-- noTieneReparacion :: Atraccion -> Bool
-- noTieneReparacion = null . ordenReparacion

-- * Punto 4

aplicarUnaReparacion :: Reparacion -> Atraccion -> Atraccion
aplicarUnaReparacion reparacion atraccion = (efectosDeReperacion . (trabajoReparacion reparacion)) atraccion

reparacionPeola :: Atraccion -> Bool
reparacionPeola atraccion = (sonPeolas atraccion . ordenReparacion) atraccion

sonPeolas :: Atraccion -> [Reparacion] -> Bool
sonPeolas _ [] = True
sonPeolas _ [trabajo] = True
sonPeolas atraccion (primerReparacion : reparaciones) =
  (queTanBuenaEs . (aplicarUnaReparacion primerReparacion)) atraccion < queTanBuenaEs atraccion
    && sonPeolas (aplicarUnaReparacion primerReparacion atraccion) reparaciones

-- !Hay que tener cuidado en mantener el efecto de la cabeza, para que se "propage" el efecto.

-- * Punto 5

-- Aplicamos todas las reparaciones pendientes una por una sobre la atracción inicial
realizarProcesoDeReparacion :: Atraccion -> Atraccion
realizarProcesoDeReparacion atraccion =
  foldr aplicarUnaReparacion atraccion (ordenReparacion atraccion)

-- La funcion dentro del foldr debe recibir un parametro de del tipo de la lista y de la semilla
--   Rep1 (lambda) (Rep2 (lambda) (Rep3 (lambda) semilla))

{-
   Ejemplo de evaluación por consola[cite: 40]:

   Supongamos una montaña rusa con 2 reparaciones:
   montaniaRusa :: Atraccion
   montaniaRusa = Atraccion "Montaña Rusa" 140 5 ["embole"] True [Reparacion 2 (ajusteDeTornilleria 5), Reparacion 1 mantenimientoElectrico]
   realizarProcesoDeReparacion (montaniaRusa)

-}
