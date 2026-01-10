type Recurso = String

data Pais = Pais
  { ingresoPerCapita :: Int,
    poblacionActivaPrivado :: Int,
    poblacionActivaPublico :: Int,
    recursos :: [Recurso],
    deuda :: Int
    -- deuda :: Float -- Int -- * Se queja el compilador al hacer 0.2 ... a la deuda
  }

-- * Modificadores

-- * Los modificadores los dejo que se setee con un valor directo, pues hay un error al como paso a porcentaje

-- * los valores. Complicacion de tipo Int y Float

modificarIngresoPerCapita :: (Int -> Int) -> Pais -> Pais
modificarIngresoPerCapita modificador pais = pais {ingresoPerCapita = (modificador . ingresoPerCapita) pais}

modificadorPoblacionActivaPrivado :: (Int -> Int) -> Pais -> Pais
modificadorPoblacionActivaPrivado modificador pais = pais {poblacionActivaPrivado = (modificador . poblacionActivaPrivado) pais}

modificadorPoblacionActivaPublico :: (Int -> Int) -> Pais -> Pais
modificadorPoblacionActivaPublico modificador pais = pais {poblacionActivaPublico = (modificador . poblacionActivaPublico) pais}

modificadorRecursos :: ([String] -> [String]) -> Pais -> Pais
modificadorRecursos modificador pais = pais {recursos = (modificador . recursos) pais}

modificadorDeuda :: (Int -> Int) -> Pais -> Pais
modificadorDeuda modificador pais = pais {deuda = (modificador . deuda) pais}

-- * 1

porcentaje :: Int -> Int -> Int
porcentaje porcentaje total = div (total * porcentaje) 100

prestar :: Int -> Pais -> Pais
-- prestar cantidad = modificadorDeuda (+ (1.5 * cantidad))
prestar cantidad = modificadorDeuda (+ (porcentaje 150 cantidad))

reducir :: Int -> Pais -> Pais
reducir cantidad pais
  | poblacionActiva pais > 100 = (modificarIngresoPerCapita (flip (-) (porcentaje 20 cantidad)) . modificadorPoblacionActivaPublico (flip (-) cantidad)) pais
  | otherwise = (modificarIngresoPerCapita (flip (-) (porcentaje 15 cantidad)) . modificadorPoblacionActivaPublico (flip (-) cantidad)) pais

poblacionActiva :: Pais -> Int
poblacionActiva pais = ((+) (poblacionActivaPrivado pais) . poblacionActivaPublico) pais

explotacion :: String -> Pais -> Pais
explotacion recurso = modificadorRecursos (sacarRecurso recurso) . modificadorDeuda (flip (-) 2000000)

sacarRecurso :: String -> [String] -> [String]
sacarRecurso recurso = filter (/= recurso)

blindaje :: Pais -> Pais
blindaje pais = (modificadorPoblacionActivaPublico (flip (-) 500) . flip prestar pais . calcularPBI) pais

calcularPBI :: Pais -> Int
calcularPBI pais = poblacionActiva pais * ingresoPerCapita pais

-- * 2

namibia :: Pais
namibia = Pais 4140 400000 650000 ["mineria", "ecoturismo"] 50000000

-- * 3

type Receta = [Pais -> Pais]

receta = [prestar 20000000, explotacion "Mineria"]

-- 3b
aplicarRecetas :: Pais -> Receta -> Pais
aplicarRecetas = foldr (\receta pais -> receta pais)

-- El lambda reduce. Recibe receta de recetas y pais es el acumulador, que no esta aca por point free

-- * 4

puedeZafar :: [Pais] -> [Pais]
puedeZafar = filter (tieneMaterial "Petroleo")

-- Aca utilizo aplicacion parcial, tieneMaterial espera un string y un pais, para regresar un Bool
-- Le aplico "Petroleo" en puedeZafar, de esta forma ahora solo espera un pais

tieneMaterial :: String -> Pais -> Bool
tieneMaterial material = elem material . recursos

totalDeuda :: [Pais] -> Int
totalDeuda = sum . map deuda

-- Orden superior porque map es una funcion de orden superior, de otra forma tendria que haberla creado por mi cuenta
-- Composicion, porque a la lista transformada que devuelve el map, la paso como parametro al sum

-- * 5 RECURSIVIDAD :(

estaOrdenado :: Pais -> Receta -> Bool
estaOrdenado _ [receta] = True
estaOrdenado _ [] = True
estaOrdenado pais (primerReceta : segundaReceta : recetas)
  | calcularPBI (primerReceta pais) < calcularPBI (segundaReceta pais) = estaOrdenado pais (segundaReceta : recetas)
  | otherwise = False

-- * 6

recursosNaturalesInfinitos :: [String]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

-- La funcion del 4a, se podria evaluar, pero nunca terminaria, pues verifica si hay algun elemento en la lista de recursos
-- infinitos

-- En cambio, la funcion 4b si se puede pues para calcular el total de deuda al fmi, no le interesa cuantos recursos tiene.