aprobo :: Estudiante -> Bool
aprobo estudiante = nota estudiante >= 6

data Estudiante = UnEstudiante
  { nombre :: String,
    legajo :: String,
    nota :: Int
  }
  deriving (Show, Eq)

-- Donde Estudiante es el tipo de dato

-- UnEstudiante es el constructor, constructur de valores de tipo Estudiante

juanita :: Estudiante
juanita = UnEstudiante "Juana" "123456-7" 8

pepito :: Estudiante
pepito =
  UnEstudiante
    { legajo = "98765-0",
      nota = 2,
      nombre = "Pepe"
    }

-- juanita :: Estudiante
-- juanita =
--   UnEstudiante
--     { legajo = "98222-0",
--       nota = 9,
--       nombre = "juanita"
--     }

-- la forma en que se escribio pepito es mucho más expresivo.
-- pepito te da más flexibilidad para poder elegir yo el orden en el que defino los parametros de UnEstudiante
--  defini primero nombre, pero le doy valor primero a legajo

-- :t nombre
-- nombre:: Estudiante -> String

-- esto lo de arriba es una funcion que devuelve un String, no es un string

legajoYNombre :: Estudiante -> String
legajoYNombre (UnEstudiante asd asdasd _) = asd ++ " " ++ asdasd

-- legajoYNombre (UnEstudiante legajo nombre _) = legajo ++ " " ++ nombre

-- Con Pattern matching y sin

leFueMejor (UnEstudiante _ _ mejorNota) (UnEstudiante _ _ otraNota) = mejorNota > otraNota

leFueMejor2 estudianteConMejorNota otroEstudiante = nota estudianteConMejorNota > nota otroEstudiante

-- este utiliza las funcioens que te regala haskell al hacer el tipo de dato.
-- no utilizamos la forma en que se crea el data, en especial si se creo todo en un solo formato

-- Inmutabilidad

cambiarNota :: Int -> Estudiante -> Estudiante
cambiarNota nuevaNota (UnEstudiante nombre legajo _) = UnEstudiante nombre legajo nuevaNota

truncar :: Int -> String -> (String, Int)
truncar cantidadCaracteres palabra = (take cantidadCaracteres palabra, length palabra - cantidadCaracteres)

-- Las tuplas son equiparaables, y ordenables si y solo si todos sus componentes lo son?

type Objeto = UnBarbaro -> UnBarbaro

data UnBarbaro = Barbaro
  { nombre2 :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objeto]
  }

pjPrueba = Barbaro "pjPrueba" 20 ["dormir"] []

cualquierCosa unBarbudo = unBarbudo {nombre2 = "jeje"}