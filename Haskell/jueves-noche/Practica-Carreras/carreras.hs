import Distribution.PackageDescription (BuildInfo(otherModules))
data Auto = Auto{
    color :: String,
    velocidad :: Int,
    distanciaRecorrida :: Int
} deriving(Eq, Show)

type Carrera = [Auto]

estaCerca :: Auto -> Auto -> Bool
-- estaCerca unAuto otroAuto = ( (<10) . abs . ( (distanciaRecorrida otroAuto) - ) . distanciaRecorrida) unAuto
estaCerca unAuto otroAuto = unAuto /= otroAuto && (distanciaEntreDosAutos unAuto otroAuto < 10)

distanciaEntreDosAutos :: Auto -> Auto -> Int
distanciaEntreDosAutos unAuto = abs . (distanciaRecorrida unAuto -).  distanciaRecorrida



-- vaTranquilo ::  Auto -> Carrera -> Bool
-- vaTranquilo auto carrera = tieneAlgunoCerca auto carerea && lesVaGanando auto carrera

-- tieneAlgunosCerca :: Auto -> Carrera -> Bool
-- tieneAlgunosCerca auto carrera = any (estaCerca auto) carrera



-- vaTranquilo :: Auto -> Carrera -> Bool 
-- vaTranquilo auto carrera 
--   = (not.tieneAlgunAutoCerca auto) carrera
--       && vaGanando auto carrera

-- * POR QUE  solo le pasa un auto y no se rompe
-- tieneAlgunAutoCerca :: Auto -> Carrera -> Bool 
-- tieneAlgunAutoCerca auto = any (estaCerca auto) 


-- vaGanando :: Auto -> Carrera -> Bool
-- vaGanando auto 
--   = all (leVaGanando auto) . filter (/= auto)

-- leVaGanando :: Auto -> Auto -> Bool
-- leVaGanando ganador = (< distanciaRecorrida ganador).distanciaRecorrida