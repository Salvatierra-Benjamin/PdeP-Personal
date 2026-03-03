-- Data 
-- data <Nombre del Tipo> = <Construstor> <Tipo de los Campos>

-- *Alu será la palabra con la que instanciare 

-- Alu :: String -> String -> Int -> Alumno
-- data Alumno = Alu String String Int deriving(Show, Eq)
-- No se muestra 


-- ? ACCEDER A LAS ESTRUCTURAS

-- nota :: Alumno -> Int

-- nota (Alu elNombre elLEgajo laNota) = laNota
-- nombre  (Alu elNombre _ _) = elNombre
-- legajo  (Alu _ elLegajo _) = elLegajo
-- nota    (Alu _ _ laNota) = laNota
-- * Funciones de Acceso



-- ?Pattern Matching
-- promociona :: Alumno -> Bool
-- promociona (Alumno _ _ laNota _ _ ) = laNota > 8

-- ?Usando funciones
-- promocionaFunc :: Alumno -> Bool
-- promocionaFunc alumno = nota alumno >= 8 
-- Esta utiliza la funcion de arriba( nota) para pasarle como parametro un alumno


-- data Alumno = Alu String String Int Bool deriving(Show, Eq)
-- Si cambio algo a Alumno, las de acceso se nos rompe pero SIGUE FUNCIONANDO
-- promocionaFunc

-- *Posiblemente trabajr con funciones y no pattern matching 


-- ! TYPE ALIAS !!!!!!!!!!!!!

-- :t Alu
-- Alu :: String -> String -> Int -> Alumno
-- Esto no queda claro si el primer String es el nombre o el alias

-- type Nombre = String 
-- type Legajo = String 
-- type Nota = Int

-- data AlumnoAlias = AluAlias Nombre  String  Nota deriving(Show, Eq)

-- ! Azucar Sintatico

-- data Alumno = Alu {
--     nombre :: String, -- String es el campo
--     legajo :: String,
--     nota :: Int
-- } deriving (Show, Eq)

-- Me crea la funcion para poder acceder, es igual a la funcion nota


-- * Tuplas
-- Algo que se pueda poner en un conjunto cosas de diferentes tipos, strings ints etc

segundoCampo :: (a ,b ,c) -> b
segundoCampo (_, x, _) = x



-- ! PATTERN MATCHING AVANZADO

data Alumno = Alumno {
    legajo :: String, 
    plan :: Int,
    notaFuncional :: Nota,
    notaLogico :: Nota,
    notaObjetos :: Nota
} deriving (Show, Eq)

data Nota = Nota{
    valor :: Int,
    detalle :: String
} deriving(Show, Eq, Ord)

-- id :: Nota -> Nota -- O sea quiero que me devuelva todo el data ese
-- id nota = nota 
-- id (Nota valor detalles) = Nota valor detalles
-- id nota@(Nota valor observaciones) = nota

notaFinal :: Alumno -> Nota
-- notaFinal (Alumno _ (Nota fun _) (Nota log _ ) (Nota obj _)) = (fun + log + obj) `div` 3
-- * Aprovecho las funciones que me da haskell al crear el data Alumno
notaFinal alumno = (notaFuncional alumno + notaLogico alumno + notaObjetos alumno) `div` 3


-- ? GUARDAS
aprobado :: Alumno -> Bool
-- aprobado alumno | plan alumno >= 1995 = notaFinal alumno >= 6
-- aprobado alumno | plan alumno < 1995 = notaFinal alumno >= 4
aprobado alumno 
    | plan alumno >= 1995 = notaFinal alumno >= 6
    | otherwise = notaFinal alumno >= 4

-- * plan es la funcion que me crea haskell para acceder al atributo del data

