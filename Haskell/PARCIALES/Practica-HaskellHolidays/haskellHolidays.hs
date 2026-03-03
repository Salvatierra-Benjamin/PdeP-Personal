data Persona = Persona
  { stress :: Int,
    nombre :: String,
    preferencias :: [String],
    cantidadAmigues :: Int
  }
  deriving (Show)

type Contingente = [Persona]

-- * Punto 1

totalStress :: Contingente -> Int
totalStress contingentes = (sum . map stress . filter (elem "gastronomia" . preferencias)) contingentes

-- totalStress contingentes = (  sum . map stress . filter (leGusta "gastronomia") ) contingentes

-- leGusta :: String -> Persona -> Bool
-- leGusta actividad  = elem actividad . preferencias

contingenteRaro :: Contingente -> Bool
contingenteRaro contingente = all (even . cantidadAmigues) contingente

-- contingenteRaro contingente = all cantidadAmigosPar contingente
-- cantidadAmigosPar :: Persona -> Bool
-- cantidadAmigosPar persona = (even . cantidadAmigues) persona

-- * Punto 2

-- Los destinos son transformaciones a personas

modificadorStress :: (Int -> Int) -> Persona -> Persona
modificadorStress modificador persona = persona {stress = (modificador . stress) persona}

modificadorAmigues :: (Int -> Int) -> Persona -> Persona
modificadorAmigues modificador persona = persona {cantidadAmigues = (modificador . cantidadAmigues) persona}

villaGesell :: Int -> Persona -> Persona
villaGesell mes persona
  | mes == 1 || mes == 2 = modificadorStress (+ 10) persona
  | otherwise = disminuirMitadStress persona

disminuirMitadStress :: Persona -> Persona
disminuirMitadStress persona = modificadorStress (flip div 2) persona

lasToninas :: Bool -> Persona -> Persona
lasToninas plata persona
  | plata = disminuirMitadStress persona
  | otherwise = modificadorStress (+ (10 * cantidadAmigues persona)) persona

puertoMadryn :: Persona -> Persona
puertoMadryn = modificadorAmigues (+ 1)

laAdela :: Persona -> Persona
laAdela = id

-- * a)

type PlanTuristico = (Persona -> Persona)

planesPiola :: [PlanTuristico] -> Persona -> Bool
planesPiola planes persona = any (esPlanPiola persona) planes

esPlanPiola :: Persona -> PlanTuristico -> Bool
esPlanPiola persona plan = ((>) (stress persona) . stress . plan) persona

-- * b)

ejemploPlanes :: [PlanTuristico]
ejemploPlanes = [villaGesell 1, lasToninas True, puertoMadryn, laAdela]

pepe :: Persona
pepe = Persona 20 "Pepe" ["laCosta"] 5

-- planesPiola ejemploPlanes pepe

-- * c)

otroEjemploDePlanes :: [PlanTuristico]
otroEjemploDePlanes = [villaGesell 12, lasToninas False] -- Podria dejar en el mismo nivel de estres

tercerEjemploDePlanes :: [PlanTuristico]
tercerEjemploDePlanes = [puertoMadryn, laAdela] -- Podria dejar en el mismo nivel de estres

-- planesPiola tercerEjemploDePlanes pepe
