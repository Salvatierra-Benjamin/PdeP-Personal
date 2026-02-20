type Hechizo = Mago -> Mago

data Mago = Mago
  { nombre :: String,
    edad :: Int,
    salud :: Int,
    hechizos :: [Hechizo]
  }

modificadorSalud :: (Int -> Int) -> Mago -> Mago
modificadorSalud modificador mago = mago {salud = (modificador . salud) mago}

modificadorHechizos :: ([Hechizo] -> [Hechizo]) -> Mago -> Mago
modificadorHechizos modificador mago = mago {hechizos = (modificador . hechizos) mago}

curar :: Int -> Hechizo
curar cantidadCurada mago = modificadorSalud ((+) cantidadCurada) mago

lanzarRayo :: Hechizo
lanzarRayo mago
  | vidaMayorA10 mago = modificadorSalud (flip (-) 10) mago
  | otherwise = modificadorSalud (flip (-) (div (salud mago) 2)) mago

vidaMayorA10 :: Mago -> Bool
vidaMayorA10 = ((<) 10 . salud)

amnesia :: Int -> Hechizo
amnesia cantidadOlvidados = modificadorHechizos (drop cantidadOlvidados)

confundir :: Mago -> Mago
confundir mago = (primerHechizo mago) mago

primerHechizo :: Mago -> Hechizo
primerHechizo mago = (head . hechizos) mago

-- * Punto 2

poder :: Mago -> Int
poder mago = ((+) (salud mago) . (*) (edad mago) . cantidadHechizos) mago

cantidadHechizos :: Mago -> Int
cantidadHechizos = length . hechizos

danio :: Mago -> Hechizo -> Int
danio mago hechizo = ((-) (salud mago) . salud . hechizo) mago

-- saludVieja - saludNueva

diferenciaDePoder :: Mago -> Mago -> Int
diferenciaDePoder unMago otroMago = (abs . (-) (poder unMago) . poder) otroMago

-- No necesito el flip porque despues se le aplica el absoluto

-- * Punto 3

data Academia = Academia
  { magos :: [Mago],
    examenDeIngreso :: Mago -> Bool
  }

nombreRincenWind :: Academia -> Bool
nombreRincenWind academia = ((any nombreRincenwindSinHechizos) . magos) academia

nombreRincenwindSinHechizos :: Mago -> Bool
nombreRincenwindSinHechizos mago = ((&&) (noTieneHechizos mago) . tieneNombreRincenWind) mago

tieneNombreRincenWind :: Mago -> Bool
tieneNombreRincenWind mago = ((==) "Rincenwind" . nombre) mago

noTieneHechizos :: Mago -> Bool
noTieneHechizos mago = (null . hechizos) mago

todosLosViejosSonNionios :: Academia -> Bool
todosLosViejosSonNionios academia = (all esNionio . filter esViejo . magos) academia

esViejo :: Mago -> Bool
esViejo = (<) 50 . edad

esNionio :: Mago -> Bool
esNionio mago = ((<) (salud mago) . cantidadHechizos) mago

cantidadQueNoPasarian :: Academia -> Int
cantidadQueNoPasarian academia = (length . filter (not . (examenDeIngreso academia)) . magos) academia

sumaEdadesMagosConMuchozHechizos :: Academia -> Int
sumaEdadesMagosConMuchozHechizos academia = (sum . map edad . filter tiene10HechizosOMas . magos) academia

tiene10HechizosOMas :: Mago -> Bool
tiene10HechizosOMas = ((<) 10 . length . hechizos)

-- * Punto 4

-- Retorna la diferencia de salud si sufre un hechizo
-- salud - danioInfringido
-- ?copia comentada del punto 2b
-- danio :: Mago -> Hechizo -> Int
-- danio mago hechizo = ((-) (salud mago) . salud . hechizo) mago

-- (-) saludIicial  saludModificada
-- saludIicial - saludModificada

maximoSegun criterio valor comparables = foldl1 (mayorSegun $ criterio valor) comparables

-- foldl1 :: Foldable t => (a -> a -> a) -> t a -> a
-- ?Con foldl1 la semilla esta dentro de la lista, recibe el primer y segundo elemento de la lista,
-- ?y lo pasa a la funcion reductora.
-- ?mayorSegun queda (danio mago1) (hehizo1) (hechizo2)
-- ? (danio mago1) :: Hechizo -> Int

-- ?Con mejorHechizoContra el primer argumento del foldl1 quedaria ((mayorSegun . danio) mago1)
-- ?al aplicar parcialmente "danio mago1", queda del tipo Hechizo -> Int.
-- ?Esta funcion "Hechizo -> Int" es pasada al mayorSegun y hace las comparaciones
-- ?con el primer hechizo y segundo de la lista.

mayorSegun evaluador comparable1 comparable2
  | evaluador comparable1 >= evaluador comparable2 = comparable1
  | otherwise = comparable2

-- ?Unicamente aplica el evaluador (en 4.i por ej. danio) y devuelve el mayor.

mejorHechizoContra :: Mago -> Mago -> Hechizo
mejorHechizoContra mago1 mago2 = maximoSegun danio mago1 (hechizos mago2)

mejorOponente :: Mago -> Academia -> Mago
mejorOponente unMago unaAcademia = maximoSegun diferenciaDePoder unMago (magos unaAcademia)

-- * Punto 5

noPuedeGanarle :: Mago -> Mago -> Bool
noPuedeGanarle unMago magoVictima = ((==) (salud magoVictima) . salud . foldl (flip ($)) magoVictima) (hechizos unMago)

-- El Hechizo es una funcion, y magoVictima el elemento
-- Se usa flip para que primero espero el mago y despues la funcion hechizo

-- $ :: (a -> b) -> a -> b
-- f $ g $ h x  =  f (g (h x))
