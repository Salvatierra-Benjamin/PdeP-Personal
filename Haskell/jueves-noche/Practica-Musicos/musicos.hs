type Instrumento = String
type Dia = Int
type Mes = Int
type Anio = Int

data Musico = Musico{
    nombre :: String,
    experiencia :: Int,
    instrumentoFavorito :: Instrumento,
    actuaciones :: [Actuacion]
}

data Actuacion = Actuacion {
    fecha :: (Dia, Mes, Anio),
    cantidad :: Int
}

-- 1. 

-- map :: (a->b)-> [a] -> [b] 


masde500 :: Musico -> Bool
masde500 =  any ((>500) . cantidad) . actuaciones  


actuacionesEnUnAnio :: Musico -> Int
actuacionesEnUnAnio =  fecha . actuaciones 