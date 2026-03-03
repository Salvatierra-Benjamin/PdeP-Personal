type Peso = Int
type Tiempo = Int
type Grados = Int

data Gimnasta = Gimnasta{
    peso :: Int,
    coeficienteTonificacion :: Int
    -- velocidaPromedio :: Int
} deriving(Show)

-- type Ejercicio = Gimnasta -> Gimnasta
-- type Rutina = [Ejercicio]


data Rutina = Rutina {
    nombre :: String,
    duracionTotal :: Int,
    ejercicios :: [Ejercicio]
}

pepe :: Gimnasta
pepe = Gimnasta  20  30 


-- ? -------------------     1     --------------------

--  1.
--  Modelar a los Gimnastas y las operaciones necesarias para hacerlos ganar
--  tonificación y quemar calorías considerando que 
--  *por cada 500 calorías quemadas se baja 1 kg de peso.

-- tonificar2 ::Int -> Gimnasta ->  Gimnasta
-- tonificar2 cantidad gimnasta = ((cantidad +) .  coeficienteTonificacion) gimnasta  

tonificar ::Int -> Gimnasta ->  Gimnasta
tonificar cantidad gimnasta = gimnasta { coeficienteTonificacion = cantidad + coeficienteTonificacion gimnasta }


quemarCalorias :: Int -> Gimnasta -> Gimnasta
quemarCalorias calorias gimnasta = 
    gimnasta {peso = peso gimnasta  - (calorias `div` 500)} 




-- ? -------------------     2     --------------------


--  2. 
--  Modelar los siguientes ejercicios del gimnasio:
--  2.a. 
--  La cinta es una de las máquinas más populares entre los socios que quieren perder 
--  peso. Los gimnastas simplemente corren sobre la cinta y queman calorías en función de 
--  la velocidad promedio alcanzada (quemando 10 calorías por la velocidad promedio por minuto).

--  La cinta puede utilizarse para realizar dos ejercicios diferentes:
    --  La caminata es un ejercicio en cinta con velocidad constante de 5 km/h.
    --  El pique arranca en 20 km/h y cada minuto incrementa la velocidad en 1 km/h, con lo cual 
    --  la velocidad promedio depende de los minutos de entrenamiento.


-- type Ejercicio = ()

-- cinta :: Int -> Tiempo -> (Gimnasta -> Gimnasta)
cinta :: Int -> Ejercicio

cinta velocidad tiempo = quemarCalorias (tiempo * velocidad * 10)


--  2.a.i
--  La caminata es un ejercicio en cinta con velocidad constante de 5 km/h.

-- caminata :: Tiempo -> Gimnasta -> Gimnasta 
caminata :: Ejercicio
caminata = cinta 5


--  2.a.ii
--  El pique arranca en 20 km/h y cada minuto incrementa la velocidad en 1 km/h, con lo cual 
--  la velocidad promedio depende de los minutos de entrenamiento.

-- pique :: Tiempo -> Gimnasta -> Gimnasta
pique :: Ejercicio
pique tiempo = cinta (20 + tiempo) tiempo





-- *b. 
-- Las pesas son el equipo preferido de los que no quieren perder peso, sino ganar musculatura.
-- Una sesión de levantamiento de pesas de más de 10 minutos hace que el gimnasta gane una
-- tonificación equivalente a los kilos levantados. Por otro lado, una sesión de menos de 10
-- minutos es demasiado corta, y no causa ningún efecto en el gimnasta.

-- levantarPeso :: Int -> Tiempo -> (Gimnasta -> Gimnasta) 
levantarPeso :: Peso -> Ejercicio
levantarPeso tiempo pesas 
    | tiempo > 10 =  tonificar pesas 
    | otherwise = id
-- El id toma algo y lo devuelve 

-- levantarPeso tiempo pesas gimnasta 
--     | tiempo > 10 =  tonificar pesas  gimnasta
--     | otherwise = gimnasta


-- *c.
-- La colina es un ejercicio que consiste en ascender y descender sobre una superficie inclinada
-- y quema 2 calorías por minuto multiplicado por la inclinación con la que se haya
-- montado la superficie.

-- Los gimnastas más experimentados suelen preferir otra versión de este ejercicio: la montaña,
-- que consiste en 2 colinas sucesivas (asignando a cada una la mitad del tiempo total), donde la
-- segunda colina se configura con una inclinación de 5 grados más que la inclinación de la
-- primera. Además de la pérdida de peso por las calorías quemadas en las colinas, la
-- montaña incrementa en 3 unidades la tonificación del gimnasta.


-- colina :: Grados -> Tiempo ->  (Gimnasta -> Gimnasta)
colina :: Grados -> Ejercicio
colina inclinacion tiempo = quemarCalorias (inclinacion * 2 * tiempo)


-- montania :: Grados -> Tiempo ->  (Gimnasta -> Gimnasta)
montania :: Grados -> Ejercicio

montania inclinacion tiempo =
    tonificar 3 . colina (inclinacion + 5) (div tiempo 2) . colina inclinacion (div tiempo 2)

-- montania inclinacion tiempo =
--     let tiempoAsignado = div tiempo 2 in tonificar 3 . colina (inclinacion + 5) (tiempoAsignado) . colina inclinacion (tiempoAsignado)




-- ? -------------------     3     --------------------


-- *3. 
-- Dado un gimnasta y una Rutina de Ejercicios, representada con la siguiente estructura:
--
-- data Rutina = Rutina {
--    nombre :: String,
--    duracionTotal :: Int,
--    ejercicios :: [Ejercicio]
-- }
--
-- Implementar una función realizarRutina, que dada una rutina y un gimnasta retorna el gimnasta
-- resultante de realizar todos los ejercicios de la rutina, repartiendo el tiempo total de la rutina en partes
-- iguales. 
-- Mostrar un ejemplo de uso con una rutina que incluya todos los ejercicios del punto anterior.

type Ejercicio = Tiempo -> Gimnasta -> Gimnasta

-- realizarRutina :: Rutina -> (Gimnasta -> Gimnasta)
realizarRutina :: Gimnasta -> Rutina ->  Gimnasta
realizarRutina gimnastaInicial rutina =
    foldl (\gimnasta ejercicio -> ejercicio ( tiempoPorRutina rutina) gimnasta) gimnastaInicial (ejercicios rutina) 


tiempoPorRutina :: Rutina -> Tiempo
-- *Estaba bien pero me confundi quien dividia a quien
-- tiempoPorRutina rutina =  (div ((length . ejercicios) rutina)  . duracionTotal) rutina 
tiempoPorRutina rutina =  ( div (duracionTotal rutina) . length . ejercicios) rutina



ejemplo = realizarRutina (Gimnasta 90 0 ) (Rutina "mi Rutina" 30 [caminata, pique, levantarPeso 4, colina 30, montania 20])


-- ? -------------------     4     --------------------



-- *4. Definir las operaciones necesarias para hacer las siguientes consultas a partir de una lista de rutinas:
--
-- a. ¿Qué cantidad de ejercicios tiene la rutina con más ejercicios?
-- b. ¿Cuáles son los nombres de las rutinas que hacen que un gimnasta dado gane tonificación?
-- c. ¿Hay alguna rutina peligrosa para cierto gimnasta? Decimos que una rutina es peligrosa para
--    alguien si lo hace perder más de la mitad de su peso.


-- *4.a.
-- map :: (a->b)-> [a] -> [b]
conMasEjercicios :: [Rutina] -> Int
-- ? Una vez mas vencido por el sueño. Esta igual esta bien pero es menos funcionalosa
-- conMasEjercicios rutinas = ( maximum . map length . map ejercicios ) rutinas 
conMasEjercicios = maximum . map (length . ejercicios) --- <---- Esta es la mejor

-- *4.b. 

nombresDeRutinasTonificadoras :: Gimnasta -> ([Rutina] -> [String])

nombresDeRutinasTonificadoras gimnasta =
     map nombre . filter ( (> coeficienteTonificacion gimnasta) . coeficienteTonificacion . realizarRutina gimnasta )

-- *4.c.

hayPeligrosa :: Gimnasta -> [Rutina] -> Bool
hayPeligrosa gimnasta = any ( (< peso gimnasta `div` 2) . peso . (realizarRutina gimnasta))

