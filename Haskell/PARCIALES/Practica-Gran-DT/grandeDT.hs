type Goles = Int

type MinutosJugados = Int

type RegistroPartido = (Goles, MinutosJugados)

-- data RegistroPartido = RegistroPartido
--   { goles :: Goles,
--     minutosJugados :: MinutosJugados
--   }

type Posicion = String

data Jugador = Jugador
  { nombre :: String,
    velocidad :: Int,
    habilidad :: Int,
    posicion :: Posicion,
    registro :: [RegistroPartido]
  }
  deriving (Show)

type Equipo = [Jugador]

-- * Punto 1

-- ? Conviene primero hacerse en otra hoja una funcion auxiliar y despues pasar la logica
-- ? a la funcion principal, sino se complicara hacer todo de una y en una sola linea.

cuantosMinutosJugaron :: Int -> Equipo -> [String]
cuantosMinutosJugaron minutos equipo = ((map nombre) . filter (all (((<=) minutos) . snd) . registro)) equipo

-- ?Verifica que en todos los partidos que jugo, que haya jugado mas de N minutos
-- jugaronTodosLosPartidosMasDeNMinutos :: Int -> Jugador -> Bool
-- jugaronTodosLosPartidosMasDeNMinutos n jugador = (all (((<=) n) . snd) . registro) jugador

empiezaConLetra :: Char -> Equipo -> Bool
empiezaConLetra letra equipo = (any ((== letra) . head . nombre)) equipo

-- empiezaConLetra letra = any ((== letra) . head . nombre)

-- * Punto 2

type Entrenador = Jugador -> Jugador

-- Podria interpretarse que el entrenador sea Equipo -> Equipo, pero por menotti parece ser Jugador -> Jugador

modificadorHabilidad :: (Int -> Int) -> Jugador -> Jugador
modificadorHabilidad modificador jugador = jugador {habilidad = (modificador . habilidad) jugador}

modificadorVelocidad :: (Int -> Int) -> Jugador -> Jugador
modificadorVelocidad modificador jugador = jugador {velocidad = (modificador . velocidad) jugador}

modificadorNombre :: (String -> String) -> Jugador -> Jugador
modificadorNombre modificador jugador = jugador {nombre = (modificador . nombre) jugador}

bielsa :: Entrenador
bielsa jugador = (modificadorHabilidad (flip (-) 10) . modificadorVelocidad (mitadEnEntero)) jugador

mitadEnEntero :: Int -> Int
mitadEnEntero numero = ((flip div 2) . (* 3)) numero

-- Queria multiplicar por 1.5 pero me lo deja en fraccion, asi que utilizo
-- 3/2, multiplico por 3 y despues divido entre 2
-- !Anotar el orden de div, para saber si tengo que usar flip

menotti :: Int -> Entrenador
menotti habilidadAgregada personaje = (modificadorHabilidad (+ habilidadAgregada) . modificadorNombre ((++) "Mr. ")) personaje

-- ghci> (++) "hola" "chau"
-- "holachau"

bertolitti :: Entrenador
bertolitti = menotti 10

vanGaal :: Entrenador
vanGaal = id

-- ?Ejemplo de uso
registroMontielFinal :: (Goles, MinutosJugados)
registroMontielFinal = (2, 90)

montiel :: Jugador
montiel = Jugador "Montiel" 40 30 "Delantero" [registroMontielFinal]

{-
-- ?Uso en consola:
(vanGaal . (menotti 30) . bielsa) montiel
-}

-- * Punto 3

mejora :: Entrenador -> Equipo -> Bool
mejora entrenador equipo = ((<) (cuantosJugadoresBuenos equipo) . cuantosJugadoresBuenos . map entrenador) equipo

-- "cuantosJugadoresBuenos equipo" es el equipo antes de que haya sido entreado,
-- que es comparado con el mismo equipo pero despues de haber sido entrenado que viene de la composición

cuantosJugadoresBuenos :: Equipo -> Int
cuantosJugadoresBuenos equipo = (length . filter esBueno) equipo

esBueno :: Jugador -> Bool
esBueno jugador = ((<) (velocidad jugador) . habilidad) jugador || ((== "volante") . posicion) jugador

-- !Esto de abajo NO HACER
-- esBueno jugador = ((>) (habilidad jugador)  . velocidad)jugador
-- esBueno jugador = ( (== "Volante"). posicion)jugador

-- * Punto 4

esImparable :: Jugador -> Bool
esImparable jugador = (registroImparable . registro) jugador

registroImparable :: [RegistroPartido] -> Bool
registroImparable [] = False
registroImparable [registro] = True
registroImparable (primerRegistro : segundoRegistro : registros) =
  fst primerRegistro <= fst segundoRegistro && registroImparable (segundoRegistro : registros)

-- Ultimo punto recursivo esta es algo diferente a los demás, no es guardas del tipo.
-- Usar guardas y que el segundo caso sea "otherwise = False" es condicion de desaprobacion -Profe Fede