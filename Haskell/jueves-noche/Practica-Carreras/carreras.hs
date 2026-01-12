data Auto = Auto
  { color :: String,
    velocidad :: Int,
    distanciaRecorrida :: Int
  }
  deriving (Eq, Show, Ord)

type Carrera = [Auto]

carrera = [autoRojo]

autoRojo :: Auto
autoRojo = Auto "Rojo" 120 190

-- * 1.a

estaCerca :: Auto -> Auto -> Bool
-- estaCerca unAuto otroAuto = ( (<10) . abs . ( (distanciaRecorrida otroAuto) - ) . distanciaRecorrida) unAuto
estaCerca unAuto otroAuto = unAuto /= otroAuto && (distanciaEntreDosAutos unAuto otroAuto < 10)

distanciaEntreDosAutos :: Auto -> Auto -> Int
distanciaEntreDosAutos unAuto = abs . (distanciaRecorrida unAuto -) . distanciaRecorrida

-- * 1.b

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = lesVaGanandoATodos auto carrera && noTieneNadieCerca auto carrera

lesVaGanandoATodos :: Auto -> Carrera -> Bool
lesVaGanandoATodos auto = all (leEstaGanando auto) . filter (/= auto)

-- ?Para hacerle free point, pongo carrera comosegundo parametro

leEstaGanando :: Auto -> Auto -> Bool
-- !No se aprovecha la composicion ni aplicacion parcial
-- leEstaGanando unAuto otroAuto = distanciaRecorrida unAuto > distanciaRecorrida otroAuto
leEstaGanando unAuto = (< distanciaRecorrida unAuto) . distanciaRecorrida

-- \* Tengo que borrar el argumento

noTieneNadieCerca :: Auto -> Carrera -> Bool
-- noTieneNadieCerca auto carrera = not ( any (estaCerca auto) carrera)
noTieneNadieCerca auto = not . any (estaCerca auto)

-- \* Tengo que borrar el argumento

-- * 1.c

-- Conocer en qué puesto está un auto en una carrera, que es 1 + la cantidad de
-- autos de la carrera que le van ganando.
puesto :: Auto -> Carrera -> Int
puesto auto = (+ 1) . cuantosVaGanando auto

cuantosVaGanando :: Auto -> Carrera -> Int
cuantosVaGanando auto = length . filter (leEstaGanando auto) -- carrera

-- * 2.a

corra :: Int -> Auto -> Auto
corra tiempo auto = auto {distanciaRecorrida = distancia tiempo auto}

distancia :: Int -> Auto -> Int
distancia tiempo auto = ((+) (velocidad auto * tiempo) . distanciaRecorrida) auto

-- * 2.b

type ModificadorDeVelocidad = Int -> Int

-- ?Personalmente me hubiera ido con esta, y no hubiera puesto el type alias
-- alterarVelocidad' :: (Int -> Int) -> Auto -> Auto
-- alterarVelocidad' funcion auto = auto { velocidad = (funcion . velocidad)  auto}

-- ?De esta forma no tenemos ni idea que hace el modificador, pero solo sabemos que le entra un int y le
-- ?el mismo int pero modificado
alterarVelocidad :: ModificadorDeVelocidad -> Auto -> Auto
alterarVelocidad modificador auto = auto {velocidad = (modificador . velocidad) auto}

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad velocidadMenor = alterarVelocidad (max 0 . flip (-) velocidadMenor)

-- 3 - 2 = 1
-- Si no ponia el flip, hacia velocidadMenor - velocidad, que daba siempre negativo
-- ?Por lo tanto con el flip se modifica a un velocidad - velocidadMenor

-- * 3

-- Dada en el enunciado
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista =
  (map efecto . filter criterio) lista ++ filter (not . criterio) lista

type PowerUP = Auto -> Carrera -> Carrera

-- * 3.a

terremoto :: Auto -> Carrera -> Carrera
terremoto autoGatillador = afectarALosQueCumplen (estaCerca autoGatillador) (bajarVelocidad 50)

-- * 3.b

miguelito :: Int -> Auto -> Carrera -> Carrera
miguelito velocidadNueva autoGatillador =
  afectarALosQueCumplen (leEstaGanando autoGatillador) (bajarVelocidad velocidadNueva) . filter (/= autoGatillador)

-- * 3.c

jetPack :: Int -> Auto -> Carrera -> Carrera
jetPack tiempo autoQueGatillo =
  afectarALosQueCumplen (== autoQueGatillo) (alterarVelocidad (\_ -> velocidad autoQueGatillo) . corra tiempo . alterarVelocidad (* 2))

{-
\* La funcion alterarVelocidad va de (int->int) -> Auto ->Auto, pero aca no se le aplica el auto
\* afectarALosQueCumplen se encargar de aplicar a todos los elementos de Carrera (que es un [autos])
\* asi que se completa el Auto -> Auto

\* El corra tiempo, es facil porque usa lo mismo, el map completa la funcion  Int -> Auto -> Auto

\* El Lambda.
\* alterarVelocidad (como se dijo arriba) espera un Int -> Int, que justamente el lambda.
\* No puedo hacer algo del tipo alterarVelocidad (velocidad autoQueGatillo), porque velocidad devuelve un Int, y espero
\* una funcion.
-}

-- data Pepe = Pan | Coca

-- esPan Pan = "es un Pan1!!"
-- esPan Coca = "esto es cocoa"
