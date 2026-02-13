data Aventurero = Aventurero
  { nombre :: String,
    carga :: Int,
    salud :: Int,
    coraje :: Bool,
    criterio :: CriterioEleccion
    -- el criterio Recibe un aventurero ya modificado, y con ese resultado
    -- de la transformacion verifica si esta conforme o no.
  }

type CriterioEleccion = Aventurero -> Bool

type Encuentro = Aventurero -> Aventurero

conformista :: CriterioEleccion
conformista _ = True

-- ?Probable refactor para que sea con composicion.
valiente :: CriterioEleccion
valiente aventurero = ((<) 50 . salud) aventurero || coraje aventurero

-- valiente = tieneCorajeOSaludMayor50

-- tieneCorajeOSaludMayor50 :: Aventurero -> Bool
-- tieneCorajeOSaludMayor50 aventurero = ((<) 50 . salud) aventurero || coraje aventurero

lightPacker :: Int -> CriterioEleccion
lightPacker umbral = (>) umbral . carga

-- * Punto 2

algunoTieneNombreLargo :: [Aventurero] -> Bool
algunoTieneNombreLargo = any tieneNombreLargo

tieneNombreLargo :: Aventurero -> Bool
tieneNombreLargo = (<) 5 . length . nombre

cargaTotalDeNumerosPares :: [Aventurero] -> Int
cargaTotalDeNumerosPares = sum . map carga . filter (tieneCargaPar)

tieneCargaPar :: Aventurero -> Bool
tieneCargaPar = even . carga

-- * Punto 3

ofrecerSouvenir :: Aventurero -> Aventurero
-- ofrecerSouvenir aventurero = aventurero {carga = (flip (-) 1 . carga) aventurero}
ofrecerSouvenir = modificadorCarga (flip (-) 1)

modificadorSalud :: (Int -> Int) -> Aventurero -> Aventurero
modificadorSalud modificador aventurero = aventurero {salud = (modificador . salud) aventurero}

modificadorCarga :: (Int -> Int) -> Aventurero -> Aventurero
modificadorCarga modificador aventurero = aventurero {carga = (modificador . carga) aventurero}

modificadorCoraje :: Bool -> Aventurero -> Aventurero
modificadorCoraje nuevoCoraje aventurero = aventurero {coraje = nuevoCoraje}

setearCriterio :: CriterioEleccion -> Aventurero -> Aventurero
setearCriterio criterioNuevo aventurero = aventurero {criterio = criterioNuevo}

-- como el orden del div es "div dividendo divisor"
-- utilizo para cambiar "flip div divisor dividendo"

-- porcentaje :: Int -> (Aventurero -> Int) -> Aventurero -> Int
-- porcentaje cantidadPorcentaje

curandero :: Aventurero -> Aventurero
curandero aventurero = (ofrecerSouvenir . modificadorSalud ((+) (div (salud aventurero) 5)) . modificadorCarga (flip div 2)) aventurero

inspirador :: Aventurero -> Aventurero
inspirador aventurero = (ofrecerSouvenir . modificadorSalud ((+) (div (salud aventurero) 10)) . modificadorCoraje True) aventurero

embaucador :: Aventurero -> Aventurero
embaucador = (ofrecerSouvenir . setearCriterio (lightPacker 10) . modificadorSalud (flip div 2) . modificadorCarga ((+) 10) . modificadorCoraje False)

-- * Punto 4

encuentrosEnfrentables :: Aventurero -> [Encuentro] -> [Encuentro]
encuentrosEnfrentables _ [] = []
encuentrosEnfrentables aventurero (primerEncuentro : resto)
  -- (criterio aventurero) me trae el criterio (en el enunciado como ej. Valiente) y es
  -- aplicado al aventurero modificado por primerEncuentro
  -- \| (criterio aventurero) (primerEncuentro aventurero) =
  | (criterio (primerEncuentro aventurero) . primerEncuentro) aventurero =
      primerEncuentro : encuentrosEnfrentables (primerEncuentro aventurero) resto
  | otherwise = []
