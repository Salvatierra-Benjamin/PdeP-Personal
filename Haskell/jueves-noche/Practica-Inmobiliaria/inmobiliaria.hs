type Barrio = String
type Mail = String
type Requisito = Depto -> Bool
type Busqueda = [Requisito] -- Una lista de funciones

data Depto = Depto {
    ambientes :: Int,
    superficie :: Int,
    precio :: Int,
    barrio :: Barrio
} deriving (Show, Eq)

data Persona = Persona {
    mail :: Mail,
    busquedas :: [Busqueda]
} -- Este no puede ser Show y Eq porque tiene una lista
-- de lista de funciones

ordenarSegun :: ( a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) =
    (ordenarSegun criterio . filter (not . criterio x)) xs ++
    [x] ++
    (ordenarSegun criterio . filter (criterio x)) xs

between :: Ord a => a -> a -> a -> Bool
between cotaInferior cotaSuperior valor = valor <= cotaSuperior && valor >= cotaInferior

deptosDeEjemplo = [
    Depto 3 80 7500 "Palermo",
    Depto 1 45 3500 "Villa Urquiza",
    Depto 2 50 5000 "Palermo",
    Depto 1 45 5500 "Recoleta"]



--  1.a
--  Definir las funciones mayor y menor que reciban una función y dos valores, y retorna
--  true si el resultado de evaluar esa función sobre el primer valor es mayor o menor que el
--  resultado de evaluarlo sobre el segundo valor respectivamente.

-- tengo que devolver true si evaluando dicha funcion sobre el 
-- primer argumento es mayor que el segundo
-- esMayor :: (a -> b) -> c -> d -> Bool 
-- !Esto esta mal porque los argumentos que le pondre 
-- ! a la funcion criterio tiene que ser el mismo tipo que la funcion esMayor
-- ! y el resultado de la funcion criterio es la que deberia ser Ordenable
esMayor :: Ord b => ( a-> b) -> a -> a -> Bool
esMayor criterio c d = criterio c > criterio d
-- // esMayor criterio c d = (( (criterio c))  `>` ) criterio d

esMenor :: Ord b => ( a-> b) -> a -> a -> Bool
esMenor criterio c d = criterio c < criterio d


--  1.b
--  Mostrar un ejemplo de cómo se usaria una de estas funciones para ordenar una lista
--  de strings en base a su longitud usando ordenarSegun

ejemplo = ordenarSegun (esMayor length ) ["1", "esteSeraElTercero", "2"] 
-- // ordenarSegun (esMayor (\c d -> length c > length d)) ["string1", "string2"] ["string3" "string4"]

-- ? -----------------------------------------

--  2.a
--  ubicadoEn que dada una lista de barrios que le interesan al usuario, retorne verdadero si
--  el departamento se encuentra en alguno de los barrios de la lista.

-- ubicadoEn :: [Barrio] -> Depto -> Bool
ubicadoEn :: [Barrio] -> (Depto -> Bool)

ubicadoEn barrios = ( (`elem` barrios) .  barrio)
-- ubicadoEn barrios depto = ( (`elem` barrios) .  barrio) depto
-- ubicadoEn barrios depto = (flip elem barrios .  barrio) depto -- ? Es lo mismo pero utiliza el flip
-- ? que cambia el orden de parametros
-- ubicadoEn barrios depto = elem (barrios depto) barrios



-- elem :: Eq a => a -> [a] -> Bool -- * CUIDADO porque elem recibe primero un elemento despues una lista
-- * sin las tildes francesas estaba aplicando primero las lista y despues el elemento


--  2.b
--  cumpleRango que a partir de una función y dos números, indique si el valor retornado
--  por la función al ser aplicada con el departamento se encuentra entre los dos valores
--  indicados.
cumpleRango :: Ord a => (Depto -> a) -> a -> a -> (Depto -> Bool) -- ! IMPORTA MUCHO EL ORDEN DE ARG 

cumpleRango f cotaInf cotaSup =  between cotaInf cotaSup . f 
cumpleRango' f cotaInf cotaSup depto = between cotaInf cotaSup (f depto) 
-- * Esto no demuestra que haya aprendido algo 





-- ? ------------------------------------------------

--  3.a 
--  Definir la función cumpleBusqueda que se cumple si todos los requisitos de una
--  búsqueda se verifican para un departamento dado.

-- cumpleBusqueda :: Busqueda -> (Depto -> Bool)
cumpleBusqueda ::Depto -> (Busqueda -> Bool)

cumpleBusqueda depto =  all (\requisito -> requisito depto)
-- cumpleBusqueda' depto =  all ($ depto)
cumpleBusqueda'' depto busqueda=  all (\requisito -> requisito depto) busqueda
-- * all :: (a -> Bool) -> [a] -> Bool
-- * all recibe 2 argumentos
-- * 1° arg es una funcion. Esta funcion toma un elemento de la lista
-- * 2° arg es una lista


--  3.b 
--  Definir la función buscar que a partir de una búsqueda, un criterio de ordenamiento y una
--  lista de departamentos retorne todos aquellos que cumplen con la búsqueda ordenados
--  en base al criterio recibido.

buscar :: Busqueda -> (Depto -> Depto -> Bool) -> ([Depto] -> [Depto])

buscar busqueda criterio = ordenarSegun criterio . filter (`cumpleBusqueda` busqueda) 
-- buscar' busqueda criterio = ordenarSegun criterio . filter (flip cumpleBusqueda busqueda) 
-- buscar'' busqueda criterio deptos = ordenarSegun criterio . filter (flp cumpleBusqueda busqueda) deptos
-- ! NO ANIDAR A LOCO FUNCIONES (((((())))))


--  3.c
--  Mostrar un ejemplo de uso de buscar para obtener los departamentos de ejemplo,
--  ordenado por mayor superficie, que cumplan con:
--  ■ Encontrarse en Recoleta o Palermo
--  ■ Ser de 1 o 2 ambientes
--  ■ Precio menor a $6000 por me

ejemploDeBuscar = buscar [
    ubicadoEn["Recoleta", "Palermo"] , cumpleRango ambientes 1 2 ,
    cumpleRango precio 0 6000] (esMayor superficie) deptosDeEjemplo



--  4.
--  Definir la función mailsDePersonasInteresadas que a partir de un departamento y una lista de
--  personas retorne los mails de las personas que tienen alguna búsqueda que se cumpla para el
--  departamento dado.

mailsDePersonasInteresadas :: Depto -> [Persona] -> [Mail]
mailsDePersonasInteresadas depto = map mail . filter( any (cumpleBusqueda depto) . busquedas)