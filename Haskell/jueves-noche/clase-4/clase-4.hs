-- * COMPOSICION Y APLICACION PARCIAL

-- (f o g) (x) == f(g(x))
-- g :: a -> b

-- f :: b -> c

-- f . g :: a -> c


-- (.) :: (b -> c) -> (a -> b) -> (a -> c)


nota :: Alumno -> Int
esMenorAOcho :: Int -> Bool
not :: Bool -> Bool

promociona :: Alumno -> Bool

-- promociona alumno = not (esMenorAOcho(nota alumno))
-- nota alumno le entra un Alumno y devuelve un Int
-- ese Int se va a esMenorAOcho, que espera un Int ( del nota alumno) y retorna un Bool
-- Por ultimo el not solo niega lo de esMenorAOcho

promociona alumno = (not . esMenorAOcho . nota ) alumno
-- *Primero se aplica el nota, despues el esMenorAOcho y por ultimo el not

-- Es IMPORTANTE los parentesis


-- ? CURRIFICACION !!!!!!!!!!! 

-- f :: a -> b -> c -> d
-- f :: a -> (b -> c -> d) -- Espera un solo parametro pero retorna una que recibe 2 parametros
-- f :: a -> (b -> [c -> d]) -- Espera un solo parametro pero retorna una que recibe 2 parametros



-- * Aplicacion Parcial

(&&) :: Bool -> (Bool -> Bool)

-- *Cuando meto un valor a una funcion se le va el argumento de la izquierda
-- (&&) unBool :: Bool -> Bool
-- (&&) True :: Bool -> Bool


-- * Ejemplo de aplicacion parcial
-- :t (!!)
-- (!!) :: GHC.Stack.Types.HasCallStack => [a] -> Int -> a

-- :t (!!) "a" 
-- (!!) "a" :: Int -> Char



-- *Abajo me dice que es Ord, y que 'a' debe ser Ord
-- *pero si le pongo un valor, ya se setea el Ord y un valor,
-- *ergo, se sabe que tipo de Ord es
-- (>) :: Ord a => a -> a -> Bool 

-- (>) 3 :: Int -> Bool 

-- (`div` 3) -> "Dividir por 3"


-- ?ENTONCES, CUANDO TENGO QUE HACER UNA COMPOSICION PERO
-- ?UNA DE LAS FUNCIONES ESPERA DOS O MAS ARGUMENTOS, LA APLICO
-- ?PARCIALMENTE PARA PODER RECIEN HACER LA COMPOSICION


-- ? ------ POINT FREE ---------------


promociona alumno = (not . (<8) . nota) alumno -- Aca es donde el argumento desaparece

-- alumno se aplica a promociona y a (not . (<8) . nota)
-- entonces le puedo sacar alumon. Quedando: 
promociona = not . (<8) . nota  -- ? Point Free 


vaAFinal nota = ((nota >= 6 &&) . (< 8)) nota -- !Aca no se puede borar al parametro nota 
-- !porque sigue estando dentro de la composicion