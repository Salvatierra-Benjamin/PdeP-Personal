-- TUPLAS

{-
Se tiene información detallada de la duración en minutos de las llamadas que se llevaron a cabo en un período determinado,
discriminadas en horario normal y horario reducido.
duracionLlamadas =
(("horarioReducido",[20,10,25,15]),(“horarioNormal”,[10,5,8,2,9,10])).

a. Definir la función cuandoHabloMasMinutos, devuelve en que horario se habló más cantidad de minutos, en el de tarifa normal o en el reducido.
Main> cuandoHabloMasMinutos
“horarioReducido”

b. Definir la función cuandoHizoMasLlamadas, devuelve en que franja horaria realizó más cantidad de llamadas,
en el de tarifa normal o en el reducido.
Main> cuandoHizoMasLlamadas
“horarioNormal”
Nota: Utilizar composición en ambos casos
-}

--  cuandoHabloMasMinutos = -- me meto a uno de los elementos de la tupla, eligo el segundo elemento,
-- sumo todos los elementos del elemento y comparo

duracionLlamadas = (("horarioReducido", [20, 10, 25, 15]), ("horarioNormal", [10, 5, 8, 2, 9, 10]))

-- tupla de tupla

sumaHorarioReducido tupla = sum ((snd . fst) tupla)

sumaHorarioNormal tupla = sum ((snd . snd) tupla)

cuandoHabloMasMinutos2 tupla
  | sumaHorarioReducido tupla > sumaHorarioNormal tupla = (fst . fst) tupla
  | sumaHorarioNormal tupla > sumaHorarioReducido tupla = (fst . snd) tupla