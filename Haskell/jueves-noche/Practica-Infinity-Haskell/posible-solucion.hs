import Text.Show.Functions

data Personaje = Personaje {
  nombre        :: String,
  poder         :: Int,
  derrotas      :: [Derrota],
  equipamientos :: [Equipamiento]
} deriving Show

type Derrota = (String, Int)

-- accesores --

mapPoder :: (Int -> Int) -> Personaje -> Personaje
mapPoder    unaFuncion unPersonaje = unPersonaje { poder    = unaFuncion . poder    $ unPersonaje }

mapNombre :: (String -> String) -> Personaje -> Personaje
mapNombre   unaFuncion unPersonaje = unPersonaje { nombre   = unaFuncion . nombre   $ unPersonaje }

mapDerrotas :: ([Derrota] -> [Derrota]) -> Personaje -> Personaje
mapDerrotas unaFuncion unPersonaje = unPersonaje { derrotas = unaFuncion . derrotas $ unPersonaje }

nombreDerrotado :: Derrota -> String
nombreDerrotado = fst

-- accesores --

entrenamiento :: [Personaje] -> [Personaje]
entrenamiento unosPersonajes = map (entrenarDeA $ length unosPersonajes) unosPersonajes
--entrenamiento unosPersonajes = map (entrenarDeA (length unosPersonajes)) unosPersonajes

entrenarDeA :: Int -> Personaje -> Personaje
entrenarDeA cuantos = mapPoder (* cuantos)
--entrenarDeA cuantos unPersonaje = mapPoder (* cuantos) unPersonaje

rivalesDignos :: [Personaje] -> [Personaje]
rivalesDignos = filter esRivalDigno . entrenamiento
--rivalesDignos unosPersonajes = filter esRivalDigno . entrenamiento $ unosPersonajes
--rivalesDignos unosPersonajes = (filter esRivalDigno . entrenamiento) unosPersonajes

esRivalDigno :: Personaje -> Bool
esRivalDigno unPersonaje = esFuerte unPersonaje && derrotoAlHijoDeTanos unPersonaje

esFuerte :: Personaje -> Bool
esFuerte = (> 500) . poder

derrotoAlHijoDeTanos :: Personaje -> Bool
derrotoAlHijoDeTanos = elem "Hijo de Thanos" . map nombreDerrotado . derrotas

guerraCivil :: Int -> [Personaje] -> [Personaje] -> [Personaje]
guerraCivil año = zipWith $ pelear año
--guerraCivil año = zipWith (pelear año)

pelear :: Int -> Personaje -> Personaje -> Personaje
pelear año unPersonaje otroPersonaje
  | leGana unPersonaje otroPersonaje = derrotarA año unPersonaje otroPersonaje
  | otherwise                        = derrotarA año otroPersonaje unPersonaje

leGana :: Personaje -> Personaje -> Bool
leGana unPersonaje otroPersonaje = poder unPersonaje > poder otroPersonaje

derrotarA :: Int -> Personaje -> Personaje -> Personaje
derrotarA año unPersonaje otroPersonaje = mapDerrotas ((nombre otroPersonaje, año) :) unPersonaje

type Equipamiento = Personaje -> Personaje

escudo :: Equipamiento
escudo unPersonaje
  | derrotoAMuchos unPersonaje = mapPoder (subtract 100) unPersonaje
  | otherwise                  = mapPoder (+ 50)         unPersonaje

derrotoAMuchos :: Personaje -> Bool
derrotoAMuchos = (>= 5) . length . derrotas

trajeMecanizado :: Int -> Equipamiento
trajeMecanizado version = mapNombre (\nombre -> "Iron " ++ nombre ++ " V" ++ show version)

stormBreaker :: Equipamiento
stormBreaker = equipamientoExclusivo "Thor" $ mapNombre (++ " dios del trueno") . mapDerrotas (const [])
--stormBreaker = equipamientoExclusivo "Thor" (mapNombre (++ " dios del trueno") . mapDerrotas (const []))
--stormBreaker unPersonaje = equipamientoExclusivo "Thor" (mapNombre (++ " dios del trueno") . mapDerrotas (const [])) unPersonaje

gemaDelAlma :: Equipamiento
gemaDelAlma = equipamientoExclusivo "Thanos" derrotarATodosLosExtras

derrotarATodosLosExtras :: Personaje -> Personaje
derrotarATodosLosExtras = mapDerrotas (++ derrotasExtras)

derrotasExtras :: [Derrota]
derrotasExtras = zip extras [2018..]

extras :: [String]
extras = map (("extra numero " ++) . show) [1..]

guanteleteInfinito :: Equipamiento
guanteleteInfinito = equipamientoExclusivo "Thanos" usarTodasLasGemasDelInfinito

usarTodasLasGemasDelInfinito :: Personaje -> Personaje
usarTodasLasGemasDelInfinito unPersonaje = foldr ($) unPersonaje $ gemasDelInfinito unPersonaje

gemasDelInfinito :: Personaje -> [Equipamiento]
gemasDelInfinito = filter esGemaDelInfinito . equipamientos

esGemaDelInfinito :: Equipamiento -> Bool
esGemaDelInfinito = undefined

equipamientoExclusivo :: String -> (Personaje -> Personaje) -> Equipamiento
equipamientoExclusivo nombreDueñe loQueHace unPersonaje
  | nombre unPersonaje == nombreDueñe = loQueHace unPersonaje
  | otherwise                         = unPersonaje


{-
  Parte C
  a. Se cuelga porque definí derrotoAMuchos con un length, y el length de una lista infinita no termina de evaluar.
     Se puede definir derrotoAMuchos de forma de que sea lazy y pueda terminar de evaluar, como:
     derrotoAMuchos = not . null . drop 5 . derrotas
  b. Si no es fuerte luego de entrenar con el resto del equipo, termina bien.
     Si es fuerte y el hijo de thanos se encuentra entre sus derrotados, termina bien.
     En caso contrario, no termina.
  c. Si. Porque haskell trabaja con evaluación perezosa, y no es necesario evaluar toda la lista para tomar los primeros 100 elementos.
-}

{-
Sobre `zip`, y `zipWith`:
`zip` es una función que toma dos listas y nos devuelve el resultado de "aparearlas" (va agarrando de a un elemento en cada una y devuelve un par ordenado con ambos valores):
zip :: [a] -> [b] -> [(a, b)]
> zip [1, 2, 3, 4] ["hola", "como", "te", "va?"]
[(1, "hola"), (2, "como"), (3, "te"), (4, "va?")]
En caso de que una de las listas sea más corta que la otra, los elementos que "sobren" de la lista más larga se descartan.
> zip [1, 2, 3, 4] ["hola", "como", "te"]
[(1, "hola"), (2, "como"), (3, "te")]
> zip [1, 2, 3] ["hola", "como", "te", "va?"]
[(1, "hola"), (2, "como"), (3, "te")]
Una definición posible de `zip` sería:
zip :: [a] -> [b] -> [(a, b)]
zip []       _        = []
zip _        []       = []
zip (x : xs) (y : ys) = (x, y) : zip xs ys
`zipWith`, muy similarmente, toma dos listas, pero también toma una función con la que aparear a las listas:
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]     (atención al tipo de la función y de las listas)
> zipWith (*) [1, 2, 3] [4, 5, 6]
[1 * 4, 2 * 5, 3 * 6]
[4, 10, 18]
Se comporta igual que zip en cuanto a que pasa cuando una lista es más larga que la otra.
> zipWith ($) [even, (> 3), odd, (== 4)] [1..]
[even $ 1, (> 3) $ 2, odd $ 3, (== 4) $ 4]
[False, False, True, True]
Una definición posible de `zipWith` sería:
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ []       _        = []
zipWith _ _        []       = []
zipWith f (x : xs) (y : ys) = f x s : zipWith f xs ys
-}