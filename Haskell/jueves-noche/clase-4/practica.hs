{-
1. Inferencia: 
    a. (.)
    b. f = (> 0) . g . h . i . (*3)

2. Para un domino dado con Clientes y Productos, definir:
    a. NuevoClienteVIP :: String -> Cliente
    b. comprar :: Producto -> Cliente -> Cliente
    c. comprarEnPromocion :: Producto -> Producto -> MOnto -> Cliente -> Cliente
-}


-- 1.a. 
-- (.) :: (a -> b) -> (b -> c) -> (a ->c)

-- 1.b. 
-- f :: Num a => a -> (b -> c) -> (d -> e) -> (f -> g) -> Bool 
-- f :: Num a => a -> Bool -- * Me ignoro todo lo que tenga en el medio
-- {-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
-- {-# HLINT ignore "Eta reduce" #-}



data Cliente = Cliente {
    saldo :: Float,
    esVIP :: Bool,
    nombre :: String
} deriving (Eq, Show)

data Producto = Producto{
    tipo :: String,
    precio :: Float
}deriving (Eq, Show)

-- cambiarSaldo :: Cliente -> Float -> Cliente
cambiarSaldo cliente delta = cliente {
    saldo = saldo cliente + delta
}


-- nuevoClienteVIP :: String -> Cliente

-- nuevoClienteVIP nuevoCliente = Cliente{saldo = 2, esVIP = True, nombre = nuevoCliente}
-- *Ahora como pro
-- nuevoClienteVIP nombre = Cliente 2 True nombre  --* 

-- *Aún mas pro

-- nuevoClienteVIP unNombre = ((Cliente 0) True) unNombre -- *Aca se dice que Cliente es una funcion
-- * y se aplica parcialmente la funcion Cliente


nuevoClienteVIP :: String -> Cliente -- *Aca por ejemplo me sirve porque ya se cuales serán los otros
-- *parametros y solo necesito que me digas el nombre
nuevoClienteVIP = Cliente 0 True


comprar :: Producto -> Cliente -> Cliente

-- comprar producto Cliente = (     ((saldo Cliente) -)  . precio ) producto

comprar producto cliente = ( (cambiarSaldo cliente) . negate . (* 1.21)  . precio)producto

-- ? ES CLAVE PENSAR CON COMPOSICION PORQUE SALE AL TOQUE 


comprarEnPromocion :: Producto -> Producto -> Float -> Cliente -> Cliente
-- comprarEnPromocion prod1 prod2 descuento cliente = 
--         ((cambiarSaldo 1.21) . comprar prod2 . comprar prod1 ) cliente 
-- * CAMBIAR SALDO: CASI PERO NO, EL PRIMER ARGUMENTO ES EL CLIENTE, NO EL DESCUENTO

comprarEnPromocion prod1 prod2 descuento cliente = 
        ((`cambiarSaldo` 1.21) . comprar prod2 . comprar prod1 ) cliente

-- * ESTE TRUCAZO HACEMOS QUE CAMBIARSALDO RECIBA CLIENTE 