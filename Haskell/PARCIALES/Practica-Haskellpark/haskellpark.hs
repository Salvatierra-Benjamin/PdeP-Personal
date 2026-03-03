data Atraccion = Atraccion
  { nombre :: String,
    alturaMinima :: Int,
    duracionAtraccion :: Int,
    opiniones :: [String],
    enMantenimiento :: Bool,
    ordenReparacion :: [Reparacion]
    -- ordenReparacion :: [[20, ajustartornillo], [15, engrasar]]
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
  | cantidadOrdenesDeReperacion atraccion < 3 = (((+) (2 * cantidadOpiniones atraccion)) . (* 10) . puntajePorLargoDeNombre) atraccion
  --   | cantidadOrdenesDeReperacion atraccion < 3 = (+) (cantidadOpiniones atraccion) ((*) 10 (puntajePorLargoDeNombre atraccion))
  | otherwise = ((* 10) . alturaMinima) atraccion

cantidadOpiniones :: Atraccion -> Int
cantidadOpiniones = length . opiniones

puntajePorLargoDeNombre :: Atraccion -> Int
puntajePorLargoDeNombre = length . nombre

duracionProlongada :: Atraccion -> Bool
duracionProlongada = (<) 10 . duracionAtraccion

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

-- Este efectosDeReperacion se utilizara solo al aplicar una Reperacion
efectosDeReperacion :: Atraccion -> Atraccion
efectosDeReperacion = tieneReparacionesPendientes . eliminarUltimaReperacion

eliminarUltimaReperacion :: Atraccion -> Atraccion
eliminarUltimaReperacion = modificadorOrdenReparacion (sacarUltimoElemento)

sacarUltimoElemento :: [a] -> [a]
sacarUltimoElemento lista = take ((length lista) - 1) lista

-- Take te devuelve los primeros N elementos
-- ghci> take 3 [10,20,30,40,50]
-- [10,20,30]

tieneReparacionesPendientes :: Atraccion -> Atraccion
tieneReparacionesPendientes atraccion
  | cantidadOrdenesDeReperacion atraccion > 0 = modificadorMantenimiento True atraccion
  | otherwise = modificadorMantenimiento False atraccion

ajusteDeTornilleria :: Int -> Trabajo
-- ajusteDeTornilleria cantTornillos atraccion = modificadorDuracionAtraccion ((+) (maximaDuracionAtraccion atraccion cantTornillos)) atraccion
ajusteDeTornilleria cantTornillos atraccion = setearDuracion (maximaDuracionAtraccion atraccion cantTornillos) atraccion

maximaDuracionAtraccion :: Atraccion -> Int -> Int
maximaDuracionAtraccion atraccion cantTornillo = min (10) (cantTornillo + (duracionAtraccion atraccion))

setearDuracion :: Int -> Atraccion -> Atraccion
setearDuracion nuevaDuracion atraccion = modificadorDuracionAtraccion (\_ -> nuevaDuracion) atraccion

engrase :: Int -> Trabajo
engrase cantGrasa atraccion = (modificadorOpiniones (++ ["para valientes"]) . modificadorAlturaMinima ((+) (div (cantGrasa) 10))) atraccion

-- Aumenta en 0,1 por cada cant. de grasa -> grasaAtraccion + (cantGrasa * 0,1)

-- multiplicar por 0.1  = dividir entre 10
-- 0.1 * = div 10

mantenimientoElectrico :: Trabajo
mantenimientoElectrico = modificadorOpiniones (take 2)

mantenimientoBasico :: Trabajo
mantenimientoBasico = (engrase 10) . (ajusteDeTornilleria 8)

-- * Punto 3

meDaMiedito :: Atraccion -> Bool
meDaMiedito atraccion = ((any (mantenimientoMasLargoQueN 4)) . ordenReparacion) atraccion

mantenimientoMasLargoQueN :: Int -> Reparacion -> Bool
mantenimientoMasLargoQueN dias reparacion = ((<) dias . diasParaReparar) reparacion

-- dias < diasParaReparar

-- Supongo que con "cerrar" se refiere a poner el atributo enMantenimiento = True
-- y no devolver un falso desde la funcion cerramos
cerramos :: Atraccion -> Atraccion
cerramos atraccion
  | muchaReparacion (ordenReparacion atraccion) = modificadorMantenimiento True atraccion
  | otherwise = atraccion

muchaReparacion :: [Reparacion] -> Bool
muchaReparacion listaReparaciones = (((==) 7) . sum . map diasParaReparar) listaReparaciones

cerramos_2 :: Atraccion -> Bool
cerramos_2 atraccion = (muchaReparacion . ordenReparacion) atraccion

disneyNoEsistis :: Parque -> Bool
disneyNoEsistis parque = ((all (null . ordenReparacion)) . filter ((<) 5 . length . nombre)) parque

-- ! MAL disneyNoEsistis parque = all (\atraccion -> (null . ordenReparacion) atraccion) ((filter (\atraccion -> ((> 5) . length . nombre) atraccion)) parque)
-- ! MAL  disneyNoEsistis parque = all ((null . ordenReparacion) ) ((filter ((> 5) . length . nombre)) parque)

-- Con pura composición, ilegible
-- disneyNoEsistis parque = ((all (\atraccion -> (null . ordenReparacion) atraccion)) . (filter (\atraccion -> ((> 5) . length . nombre) atraccion))) parque

-- tieneNombreLargo :: Atraccion -> Bool
-- tieneNombreLargo  = (>) 5 . length . nombre

-- noTieneReparacion :: Atraccion -> Bool
-- noTieneReparacion = null . ordenReparacion

-- * Punto 4

aplicarUnaReparacion :: Reparacion -> Atraccion -> Atraccion
aplicarUnaReparacion reparacion atraccion = (efectosDeReperacion . (trabajoReparacion reparacion)) atraccion

-- (trabajoReparacion reparacion) me trae el trabajo (una funcion) que es aplicada a atraccion

reparacionPeola :: Atraccion -> Bool
reparacionPeola atraccion = ((sonPeolas atraccion) . ordenReparacion) atraccion

sonPeolas :: Atraccion -> [Reparacion] -> Bool
sonPeolas _ [] = True
-- sonPeolas _ [trabajo] = True -- !No es necesario porque agarra la cola vacia y te da true
sonPeolas atraccion (primerReparacion : reparaciones) =
  (queTanBuenaEs . (aplicarUnaReparacion primerReparacion)) atraccion > queTanBuenaEs atraccion
    && sonPeolas (aplicarUnaReparacion primerReparacion atraccion) reparaciones

-- !Hay que tener cuidado en mantener el efecto de la cabeza, para que se "propage" el efecto.

-- * Punto 5

-- Aplicamos todas las reparaciones pendientes una por una sobre la atracción inicial
realizarProcesoDeReparacion :: Atraccion -> Atraccion
realizarProcesoDeReparacion atraccion =
  foldr aplicarUnaReparacion atraccion (ordenReparacion atraccion)

-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b

-- La funcion dentro del foldr debe recibir un parametro del tipo de la lista y de la semilla
--   Rep1 (lambda) (Rep2 (lambda) (Rep3 (lambda) semilla))

{-
   Ejemplo de evaluación por consola:

   Supongamos una montaña rusa con 2 reparaciones:
   montaniaRusa :: Atraccion
   montaniaRusa = Atraccion "Montaña Rusa" 140 5 ["embole"] True [Reparacion 2 (ajusteDeTornilleria 5), Reparacion 1 mantenimientoElectrico]
   realizarProcesoDeReparacion (montaniaRusa)
-}

-- * Punto 6

{-
? Punto 5: Manny a la obra (El proceso de trabajo)

No es posible obtener un valor computable.
¿Por qué? Para que Haskell te pueda mostrar el resultado de la Atracción (su
nueva duración, altura o nombre), primero tiene que terminar de aplicar todas
las funciones de la lista.
Si la lista de trabajos es infinita, el programa se queda "trabajando" para siempre
y nunca llega a escupir el resultado final por consola.

? Punto 4: Reparaciones peolas (La comparación)
Sí es posible obtener un resultado en un caso específico.
El "atajo": Como esta función devuelve un Bool usando el operador &&, Haskell usa
algo llamado cortocircuito.

La lógica: Si la función encuentra una sola reparación que no sea "peola" (que no
mejore el puntaje), el resultado automáticamente es False.
Gracias a la Evaluación Diferida, Haskell deja de mirar el resto de la lista infinita
en cuanto encuentra ese primer False y te da la respuesta al toque.
Si todas fueran "peolas", ahí sí se colgaría buscando el final.
-}
