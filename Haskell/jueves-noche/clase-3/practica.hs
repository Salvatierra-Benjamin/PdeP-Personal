{-
"Subir un puntito: dada una nota, incrementa su valor en 1"
-}

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
} deriving(Show, Eq)

subir :: Nota -> Nota
-- subir nota = Nota{valor = valor nota + 1 , detalle = detalle nota} -- El valor Actualizado
subir nota = nota{ valor = valor nota +1} -- * Azucar sintactico 
-- Será comun entrar una data, y devolverla construyendo una nueva pero con un atributo modificado


-- ? PRACTICAAAAAAAAAAAAAAAAAAAAAA
{-
"   Rambo tiene dos armas: una principal y una secundaria, cada una con un cargador 
    de cierta capacidad con alguna cantidad de balas"
-}
-- *1. Averiguar cuantas balas le quedan a Rambo en total
-- *2. Dada un arma, disparar si tiene balas
-- *3. Hacer que rambo dispare todo a la vez

data Arma = Arma {
    balas :: Int,
    tamanioCargador :: Int
} deriving(Eq, Show)

data Rambo = Rambo{
    armaPrincipal :: Arma,
    armaSecundaria :: Arma
} deriving(Eq, Show)


balasTotales :: Rambo -> Int
-- balasTotales (Rambo (Arma balasPrin _) (Arma balasSec _ )) = balasPrin + balasSec
-- * Este de arriba justamente es lo que se evita, que no se rompa si hay algun cambio en el data Rambo
balasTotales rambo = balas (armaPrincipal rambo) + balas (armaSecundaria rambo)


disparar :: Arma -> Arma
-- disparar = Si el cargador esta lleno, Rambo se confia y dispara 2 tiros
-- disparar = Si el cargador no esta lleno, pero tiene al menos una bala la dispara
-- disparar = Si el cargador esta vacio, Rambo gatilla pero no pasa nada

disparar arma 
    | balas arma == tamanioCargador arma    = arma{ balas = balas arma - 2}
    | balas arma > 0                        = arma{ balas = balas arma -1}
    | otherwise                             = arma

dispararTodo :: Rambo -> Rambo
dispararTodo rambo =
    rambo { armaPrincipal = disparar (armaPrincipal rambo), 
    armaSecundaria = disparar(armaSecundaria rambo)}