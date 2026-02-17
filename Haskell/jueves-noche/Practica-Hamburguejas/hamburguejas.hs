type Ingrediente = String

data Hamburguesa = Hamburguesa
  { nombreHamburguesa :: String,
    ingredientes :: [Ingrediente]
  }

data Bebida = Bebida
  { nombreBebida :: String,
    tamanioBebida :: Int,
    light :: Bool
  }

type Acompaniamiento = String

type Combo = (Hamburguesa, Bebida, Acompaniamiento)

hamburguesa (h, _, _) = h

bebida (_, b, _) = b

acompaniamiento (_, _, a) = a

informacionNutricional =
  [ ("Carne", 250),
    ("Queso", 50),
    ("Pan", 20),
    ("Panceta", 541),
    ("Lechuga", 5),
    ("Tomate", 6)
  ]

condimentos = ["Barbacoa", "Mostaza", "Mayonesa", "Salsa big mac", "Ketchup"]

comboQyB = (qyb, cocaCola, "Papas")

cocaCola = Bebida "Coca Cola" 2 False

qyb = Hamburguesa "QyB" ["Pan", "Carne", "Queso", "Panceta", "Mayonesa", "Ketchup", "Pan"]

-- * Punto 1

calorias :: Ingrediente -> Int
calorias componente
  | esCondimento componente = 10
  | otherwise = caloriasIngrediente componente

esCondimento :: String -> Bool
esCondimento condimento = elem condimento condimentos

caloriasIngrediente :: String -> Int
caloriasIngrediente ingrediente = (snd . head . filter (tieneElIngrediente ingrediente)) informacionNutricional

tieneElIngrediente :: String -> (String, Int) -> Bool
tieneElIngrediente cadena (otraCadena, _) = cadena == otraCadena

-- * Punto 2

-- Considero que el light :: Bool de bebida representa si es dietetica
esMortal :: Combo -> Bool
esMortal combo =
  ( (&&) (acompaniamientoNoEsEnsalada combo)
      . noEsDietetica
  )
    combo
    || esUnaBomba combo

esUnaBomba :: Combo -> Bool
esUnaBomba combo = ((||) (algunIngredienteMayorA300 combo) . caloriasMayorA1000) combo

listaDeCaloriasDeUnaHamburguesaDeCombo :: Combo -> [Int]
listaDeCaloriasDeUnaHamburguesaDeCombo combo = (map calorias . ingredientes . hamburguesa) combo

algunIngredienteMayorA300 :: Combo -> Bool
-- 300 < x
algunIngredienteMayorA300 combo = (any ((<) 300) . listaDeCaloriasDeUnaHamburguesaDeCombo) combo

caloriasMayorA1000 :: Combo -> Bool
-- 1000 < sum lista
caloriasMayorA1000 combo = ((<) 1000 . sum . listaDeCaloriasDeUnaHamburguesaDeCombo) combo

noEsDietetica :: Combo -> Bool
noEsDietetica combo = (not . light . bebida) combo

acompaniamientoNoEsEnsalada :: Combo -> Bool
acompaniamientoNoEsEnsalada combo = (not . (==) "ensalada" . acompaniamiento) combo

-- * Punto 3

modificarTamanioBebida :: (Int -> Int) -> Bebida -> Bebida
modificarTamanioBebida modificador bebida = bebida {tamanioBebida = (modificador . tamanioBebida) bebida}

agrandarBebida :: Combo -> Combo
agrandarBebida (hamburguesa, bebida, acompaniamiento) = (hamburguesa, modificarTamanioBebida ((+) 1) bebida, acompaniamiento)

cambiarAcompaniamientoPor :: String -> Combo -> Combo
cambiarAcompaniamientoPor nuevoAcompaniamiento (hamburguesa, bebida, _) = (hamburguesa, bebida, nuevoAcompaniamiento)

peroSin :: (Ingrediente -> Bool) -> Combo -> Combo
peroSin condicionIngredientes (hamburguesa, bebida, acompaniamiento) =
  (hamburguesaConCondicion hamburguesa condicionIngredientes, bebida, acompaniamiento)

hamburguesaConCondicion :: Hamburguesa -> (Ingrediente -> Bool) -> Hamburguesa
hamburguesaConCondicion hamburguesa condicionIngredientes = hamburguesa {ingredientes = (filter (not . condicionIngredientes) . ingredientes) hamburguesa}

-- Ya estaba definido arriba
-- esCondimento :: String -> Bool
-- esCondimento condimento = elem condimento condimentos

masCaloricoQue :: Int -> Ingrediente -> Bool
masCaloricoQue valor ingrediente = ((<) valor . caloriasIngrediente) ingrediente

-- -- * Punto 4

alteraciones :: [(Combo -> Combo)]
alteraciones =
  [ agrandarBebida,
    cambiarAcompaniamientoPor "ensalada",
    peroSin esCondimento,
    peroSin (masCaloricoQue 400),
    peroSin (== "Queso")
  ]

consultaPunto4 = filter (not . esMortal . ($ comboQyB)) alteraciones