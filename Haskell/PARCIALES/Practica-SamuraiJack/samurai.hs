-- !Parcial queda obsoleto desde el punto 3 en adelante. 
-- ? Consejo: Ataque fue declarado, en el enunciado, como Personaje -> Personaje
-- ? lo que complico hacer los siguientes tiempo, generando confusion. 
-- ? Aconsejable hacer un type alias para remplazarlo: type Ataque = Personaje -> Personaje 


type Ataque = Personaje -> Personaje 
type Defensa = Personaje -> Personaje
 
data Elemento = UnElemento
  { tipo :: String,
    ataque :: Ataque,
    defensa :: Defensa
  }


data Personaje = UnPersonaje
  { nombre :: String,
    salud :: Float,
    elementos :: [Elemento],
    anioPresente :: Int
  }


-- ?Ataque para un rivel
-- ?Defensa para un el mismo


-- * Punto 1
mandarAlAnio :: Int -> Personaje -> Personaje 
mandarAlAnio anio personaje = personaje {anioPresente = anio}

modificadorSalud :: (Float -> Float) -> Personaje -> Personaje
modificadorSalud modificador personaje = personaje { salud = (modificador . salud) personaje}


meditar :: Personaje -> Personaje
meditar = modificadorSalud (*1.5) 

causarDanio :: Float -> Personaje -> Personaje
causarDanio danio personaje = modificadorSalud  (max 0 (danio - salud personaje) -) personaje

-- * Punto 2
esMalvado ::  Personaje -> Bool
esMalvado  = (elem "Maldad"). map tipo . elementos

danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce personaje elemento = ( ((salud personaje) -) . salud. usarElemento personaje ) elemento


usarElemento :: Personaje -> Elemento -> Personaje
usarElemento personaje elemento = ( flip  ataque personaje) elemento






-- !Mirarlo porque me costo representar las listas
-- Saber si un una lista de enemigos mata un personaje, con un solo elemento
enemigosMortales :: [Personaje] -> Personaje -> [Personaje]
enemigosMortales enemigos personaje = filter ( enemigoMortal personaje) enemigos

enemigoMortal :: Personaje -> Personaje -> Bool
enemigoMortal personaje enemigo = ( algunAtaqueAsesino personaje . (map ataque) . elementos ) enemigo


algunAtaqueAsesino :: Personaje -> [Ataque] -> Bool
algunAtaqueAsesino personaje ataques = any (ataqueAsesino personaje) ataques 

ataqueAsesino :: Personaje -> Ataque -> Bool
ataqueAsesino personaje ataque = ((==0). salud . ataque) personaje 



-- * Punto 3

-- !Quedo obsoleto, no se enseño el iterate 
-- concentracion :: Elemento
-- concentracion = UnElemento "Magia" id meditar




