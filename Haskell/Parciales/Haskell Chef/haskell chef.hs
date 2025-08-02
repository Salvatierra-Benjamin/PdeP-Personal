-------------- PARTE A --------------

data Cocinero = Cocinero {
    nombre          :: String,
    trucos          :: [Truco],
    especialidad    :: Plato
} 

type Truco = Plato -> Plato

data Plato = Plato {
    nombrePlato     :: String,
    dificultad      :: Int,
    componentes     :: [Componente] 
} deriving  Show

type Componente = (Ingrediente, Int)
type Ingrediente = String

-- dave :: Cocinero
-- dave = Cocinero "Dave" [(endulzar 2)] platinum

platinum :: Plato
platinum = Plato "platinum" 420 [("SALSA", 3), ("CEBOLLSA", 50), ("2CEBOLLSA", 50), ("3CEBOLLSA", 50), ("4CEBOLLSA", 50), ("5CEBOLLSA", 50)]


mapComponentes :: (Componente -> Componente) -> Plato -> Plato -- me transforma los componentes
mapComponentes f unPlato = unPlato { componentes =  map f (componentes unPlato) }

agregarComponente :: Componente -> Plato -> Plato
agregarComponente componente unPlato = unPlato {componentes = componente : componentes unPlato }

endulzar :: Int -> Truco
endulzar cantidad unPlato = agregarComponente ("Azucar", cantidad) unPlato

salar :: Int -> Truco
salar cantidad unPlato = agregarComponente ("Sal", cantidad) unPlato


duplicarPorcion :: Plato -> Plato
-- duplicarPorcion unPlato = map (2*) (map snd (componentes unPlato))
duplicarPorcion unPlato = mapComponentes duplicarComponente unPlato 

duplicarComponente :: Componente -> Componente
duplicarComponente (ingrediente, cantida) = (ingrediente, 2* cantida)


simplificar :: Truco
simplificar unPlato 
    | esComplejo unPlato = platoSimplificado unPlato
    | otherwise = unPlato

esComplejo :: Plato -> Bool
esComplejo unPlato = tieneMenorComponentes (5) unPlato && esDificil unPlato

tieneMenorComponentes :: Int -> Plato -> Bool 
tieneMenorComponentes cantidaComponentes unPlato = ((>cantidaComponentes) . length .componentes) unPlato

esDificil :: Plato -> Bool
esDificil unPlato = ((>7) . dificultad) unPlato

platoSimplificado :: Plato -> Plato 
platoSimplificado unPlato =  unPlato {dificultad = 5 , componentes = filter ((<10).snd) (componentes unPlato)}


-------------- PARTE B --------------

darleSabor :: Truco 
darleSabor = id

pepe :: Cocinero
-- ghci> :t  (endulzar 5)
-- (endulzar 5) :: Truco
pepe = Cocinero "Pepe"  [(endulzar 5), (salar 2)] platinum