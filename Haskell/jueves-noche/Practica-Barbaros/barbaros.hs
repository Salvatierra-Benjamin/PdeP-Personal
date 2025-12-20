import Data.Char (toUpper)
import qualified Control.Applicative as B


type Nombre = String
type Fuerza = Int
type Habilidad = String
type Objeto = Barbaro -> Barbaro

data Barbaro = Barbaro{
    nombre :: Nombre,
    fuerza :: Fuerza,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
}

modificarNombre :: (Nombre -> Nombre) -> Barbaro -> Barbaro
modificarNombre f barbaro = barbaro { nombre = f (nombre barbaro)} 


modificarFuerza :: (Fuerza -> Fuerza) -> Barbaro -> Barbaro
modificarFuerza f barbaro = barbaro { fuerza = f (fuerza barbaro)} 
-- De esta forma solo me tengo que asegurar que f vaya de Fuerza -> Fuerza

modificarHabilidades :: ([Habilidad] -> [Habilidad]) -> Barbaro -> Barbaro
modificarHabilidades f barbaro = barbaro { habilidades = f (habilidades barbaro)}

modificarObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
modificarObjetos f barbaro = barbaro { objetos = f (objetos barbaro)}



-- ? --------------------------          PUNTO 1          --------------------------

-- 1. Las espadas aumentan la fuerza de los bárbaros en 2 unidades por cada kilogramo de peso.
espadas :: Int -> Objeto
-- espadas peso barbaro = barbaro { fuerza = fuerza barbaro +  2 * peso}
espadas peso = modificarFuerza (+ 2*peso) 


-- 2. Los amuletosMisticos puerco-marranos otorgan una habilidad dada a un bárbaro.
amuletosMisticos :: String -> Barbaro -> Barbaro 
amuletosMisticos habilidad = agregarHabilidad habilidad --Se podria sacar habilidad para que sea point free
-- amuletosMisticos habilidad = modificarHabilidades (++ [habilidad]) -- (++) :: [String] -> [String] -> [String]
-- *IMPORTANTE EXPLICACION DEL MODIFICARHABILIDADES

{-
* (++) :: [String] -> [String] -> [String]
* Al ya aplicarle un [habilidad], me queda [String] -> [String] por ende ya calza con el tipo de 
* modificarHabilidades. 

* Ahora yendo a modificarHabilidades solo le falta un [String] más que lo hace justamente esa pocion
* modificarHabilidades (++ [habilidad])
* Ahora espera un [String] más para aplicarle al barbaro
-}


-- amuletosMisticos = agregarHabilidad
-- amuletosMisticos habilidad barbaro = barbaro { habilidades = habilidades barbaro ++ [habilidad]}
-- amuletosMisticos habilidad barbaro = agregarHabilidad habilidad barbaro


-- 3. Las varitasDefectuosas, añaden la habilidad de hacer magia, pero desaparecen todos los
-- demás objetos del bárbaro.
varitasDefectuosas :: Barbaro -> Barbaro 
varitasDefectuosas = vaciarObjetos . agregarHabilidad "hacerMagia"
-- varitasDefectuosas  = vaciarObjetos . modificarHabilidades (++ ["hacerMagia"])
-- varitasDefectuosas  = vaciarObjetos . modificarHabilidades (++ ["hacerMagia"])
-- varitasDefectuosas  = vaciarObjetos . agregarHabilidad "hacerMagia"


-- *Queda remplazado por modificarHabilidades
-- agregarHabilidad :: String -> Barbaro -> Barbaro
-- agregarHabilidad habilidadNueva barbaro = barbaro { habilidades = habilidades barbaro ++ [habilidadNueva]} 

-- * Podria haberse interpretado como que no haya objetos, o que solo quede varitasDefectuosas
vaciarObjetos :: Barbaro -> Barbaro
vaciarObjetos barbaro = barbaro { objetos = [varitasDefectuosas] }
-- vaciarObjetos barbaro = barbaro { objetos = [] }


-- *Se abstrae aunque es agregar solo 2 pedazos 
agregarHabilidad :: String -> Barbaro -> Barbaro
agregarHabilidad habilidad = modificarHabilidades (++ [habilidad])






-- 4. Una ardilla, que no hace nada.
ardilla :: Barbaro -> Barbaro
ardilla = id


-- 5. Una cuerda, que combina dos objetos distintos,obteniendo uno que realiza las transformaciones
cuerda :: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto = unObjeto . otroObjeto




-- ? --------------------------          PUNTO 2          --------------------------

-- 2.
-- El megafono es un objeto que potencia al bárbaro, concatenando sus habilidades y
-- poniéndolas en mayúsculas .

-- Main> megafono dave
-- Barbaro "Dave" 100 ["TEJERESCRIBIRPOESIA"] [<function>,<function>]
-- Sabiendo esto, definir al megafono, y al objeto megafonoBarbarico, que está formado por una cuerda,
-- una ardilla y un megáfono.

-- concat :: [[a]] -> [a]
-- map :: (a->b)-> [a] -> [b]


megafono :: Barbaro -> Barbaro
-- megafono barbaro = barbaro {habilidades = (gritar . habilidades) barbaro }
megafono = modificarHabilidades gritar

gritar :: [String] -> [String]
gritar cadenaString = [map toUpper (concat cadenaString)]


megafonoBarbarico :: Objeto  
megafonoBarbarico = cuerda ardilla megafono     -- *Cuerda es la composicion



-- ? --------------------------          PUNTO 3          --------------------------

--  3 - Aventuras

-- Los bárbaros suelen ir de aventuras por el reino luchando contra las fuerzas del mal, pero ahora que
-- tienen nuestra ayuda, quieren que se les diga si un grupo de bárbaros puede sobrevivir a cierta aventura.
-- Una aventura se compone de uno o más eventos, por ejemplo:

-- type Evento = [Barbaro] -> [Barbaro]
type Aventura = [Evento]
type Evento = Barbaro -> Bool



-- 1. invasionDeSuciosDuendes: Un bárbaro sobrevive si sabe “Escribir Poesía Atroz”

-- map :: (a->b)-> [a] -> [b]

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes = elem "Escribir Poesia Atroz" . habilidades 
-- elem :: Eq a => a -> [a] -> Bool

-- 2. cremalleraDelTiempo: Un bárbaro sobrevive si no tiene pulgares. Los bárbaros llamados Faffy
-- y Astro no tienen pulgares, los demás sí.

cremalleraDelTiempo :: Evento
cremalleraDelTiempo = not . tienePulgares

tienePulgares :: Evento
tienePulgares  (Barbaro "Faffy" _ _ _) = False
tienePulgares  (Barbaro "Astro" _ _ _) = False
tienePulgares _ = False



-- cremalleraDelTiempo = not . tienePulgares . nombre
-- tienePulgares :: Stromg -> Bool
-- tienePulgares "Faffy" = False
-- tienePulgares "Astro" = False
-- tienePulgares _ = True





-- 3. ritualDeFechorias: Un bárbaro puede sobrevivir si pasa una o más pruebas como las
-- siguientes:
--      a. saqueo: El bárbaro debe tener la habilidad de robar y tener más de 80 de fuerza.

--      b. gritoDeGuerra: El bárbaro debe tener un poder de grito de guerra igual a la cantidad de
-- letras de sus habilidades. El poder necesario para aprobar es 4 veces la cantidad de
-- objetos del bárbaro.

--      c. caligrafia: El bárbaro tiene caligrafía perfecta (para el estándar barbárico de la época)
-- si sus habilidades contienen más de 3 vocales y comienzan con mayúscula.

-- ritualFechorias :: Evento
-- ritualFechorias barbaro = saqueo barbaro || gritoDeGuerra barbaro || caligrafia barbaro

ritualFechorias :: [Evento] -> Evento
-- ritualFechorias eventos unBarbaro = any (\evento -> evento unBarbaro) eventos
ritualFechorias eventos unBarbaro = pasaUnaAventura any unBarbaro eventos


saqueo :: Evento
saqueo barbaro = sabeRobar barbaro && esFuerte barbaro

sabeRobar :: Barbaro -> Bool
sabeRobar =  elem "robar" . habilidades 

esFuerte :: Barbaro -> Bool
esFuerte =  (>80) . fuerza




gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra barbaro = poderGritoDeGuerra barbaro >= 4 * cantObjetos barbaro

poderGritoDeGuerra :: Barbaro -> Int
poderGritoDeGuerra = length . concat . habilidades

cantObjetos :: Barbaro -> Int
cantObjetos = length . objetos



caligrafia :: Barbaro -> Bool 
caligrafia barbaro = all inicianMayusculaYTienen3Vocales  (habilidades barbaro)  

inicianMayusculaYTienen3Vocales :: String -> Bool
inicianMayusculaYTienen3Vocales habilidad = empiezanConMayuscula habilidad && tienenTresVocales habilidad

empiezanConMayuscula :: String -> Bool
empiezanConMayuscula = estaEnMayuscula . head 

estaEnMayuscula :: Char -> Bool
estaEnMayuscula caracter = caracter == toUpper caracter

-- estaEnMayuscula  = isUpper . head -- Le entra un String y toma la cabeza de ese String. Deberia ser lo mismo
 

tienenTresVocales :: String -> Bool
tienenTresVocales  =  (>3 ). length . filter (esVocal) 


esVocal :: Char -> Bool
esVocal 'a' = True 
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal _ = False





sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]

-- sobrevivientes unosBarbaros unaAventura = 
--     filter ( \unBarbaro -> all (\evento -> evento unBarbaro) unaAventura) unosBarbaros

sobrevivientes unosBarbaros unaAventura = 
    filter ( \unBarbaro -> pasaUnaAventura all unBarbaro unaAventura) unosBarbaros




pasaUnaAventura criterio unBarbaro unaAventura = criterio (\evento -> evento unBarbaro) unaAventura












-- ? --------------------------          PUNTO 4          --------------------------


-- *A
-- Los bárbaros se marean cuando tienen varias habilidades iguales. Por todo esto, nos piden
-- desarrollar una función que elimine los elementos repetidos de una lista (sin utilizar nub ni nubBy)
-- > sinRepetidos [1,2,3,4,4,5,5,6,7]
-- [1,2,3,4,5,6,7]

-- Nota: Puede usarse recursividad para este punto.


-- *B
-- Los bárbaros son una raza muy orgullosa, tanto que quieren saber cómo van a ser sus descendientes
-- y asegurarse de que los mismos reciban su legado.

-- El descendiente de un bárbaro comparte su nombre, y un asterisco por cada generación. Por ejemplo
-- "Dave*", "Dave**" , "Dave***" , etc.

-- Además, tienen en principio su mismo poder, habilidades sin repetidos, y los objetos de su padre, pero
-- antes de pasar a la siguiente generación, utilizan (aplican sobre sí mismos) los objetos. Por ejemplo, el
-- hijo de Dave será equivalente a:

-- (ardilla.varitasDefectuosas) (Barbaro "Dave*" 100 ["tejer","escribirPoesia"]

-- [ardilla, varitasDefectuosas])
-- Definir la función descendientes, que dado un bárbaro nos de sus infinitos descendientes.

-- *C
-- Pregunta: ¿Se podría aplicar sinRepetidos sobre la lista de objetos? ¿Y sobre el nombre de un
-- bárbaro? ¿Por qué?



-- A. 
sinRepetidos :: (Eq a) => [a] -> [a]

sinRepetidos [] = []
sinRepetidos (cabeza : cola) 
    | elem cabeza cola = cola 
    | otherwise = (cabeza : cola)


-- B. 

descendiente :: Barbaro -> Barbaro
descendiente  = utilizarObjetos . modificarNombre (++ "*") . modificarHabilidades sinRepetidos

utilizarObjetos :: Barbaro -> Barbaro 
utilizarObjetos unBarbaro = foldr ($) unBarbaro (objetos unBarbaro)

descendientes :: Barbaro -> [Barbaro]
descendientes unBarbaro = iterate descendiente unBarbaro
