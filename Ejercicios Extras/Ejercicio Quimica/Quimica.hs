-- import Data.Char

-- compuestas y sencillas

-- Sencillas/elementos: corresponde directamente con un elemento.

-- De los elementos se conoce el nombre, simbolo químico y número atómico

--------------------------------------------------------------------------------------------------------

-- Compuestos:  dupla de sustancia y cantidad de esa sustancia

--              la sustancia puede ser otro compuesto o un elemento.

--------------------------------------------------------------------------------------------------------

-- Todas las sustancias pueden tener el grupo: Metal, NoMetal, Halogeno, Gas Noble.

------ Inciso 1 ------

-- hidrogeno = ("Hidrogeno", 'H', 1, "NoMetal")

-- oxigeno = ("Oxigeno", 'O', 8, "NoMetal")

-- agua = ("Agua", (hidrogeno, 2), (oxigeno, 1))

------ Inciso 2 ------

data Grupo
  = Metal
  | NoMetal
  | Halogeno
  | GasNoble
  deriving (Show, Eq)

data Sustancia
  = Elemento String String Int Grupo
  | Compuesto String [(Sustancia, Int)] Grupo
  deriving (Show, Eq)

-- Construyo mi sustancia, elemento o compuesto
hidrogeno = Elemento "Hidrogeno" "H" 1 NoMetal

hidrogenoNoble = Elemento "Hidrogeno" "H" 1 GasNoble

oxigeno = Elemento "Oxigeno" "O" 8 NoMetal

hierro = Elemento "Hierro" "Fe" 26 Metal

aguaMetal = Compuesto "Agua Metal" [(hidrogeno, 2), (oxigeno, 1)] Metal

agua = Compuesto "Agua" [(hidrogeno, 2), (oxigeno, 1)] NoMetal

aguaHalogeno = Compuesto "Agua" [(hidrogeno, 2), (oxigeno, 1)] Halogeno

-- nombreDeUnion (Elemento nombre _ _ _) = sacarUltimaConsonante (nombre)

sacarVocalElemento (Elemento nombre _ _ _) = sacarLetra nombre ++ "uro"

-- sacarLetra texto = reverse (dropWhile esVocal (reverse texto))

sacarLetra = reverse . dropWhile esVocal . reverse

-- Primero hace el reverse de la derecha, después el dropWhile esVocal, después el reverse de la izquierda

esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal _ = False

------ Inciso 3 ------

-- los metales cumples cualquier criterio, sea compuesto o elementos

-- gases nobles -> conducen bien electricidad

-- compuesto halogeno -> conduce bien calor

-- el resto no conducen bien

data Criterio
  = Electricidad
  | Calor
  deriving (Show, Eq)

{-conduceBien criterio sustancia
  | criterio == Electricidad && esMetal sustancia = "conduce bien ELECTRICIDAD"
  | criterio == Calor && (esGasNoble sustancia || esHalogeno sustancia) = "conduce bien CALOR"
  | otherwise = "no hace nada"
-}
conduceBien2 Electricidad (Compuesto _ _ Metal) = "conduce bien Electricidad"
conduceBien2 Electricidad (Elemento _ _ _ Metal) = "conduce bien Electricidad"
conduceBien2 Calor (Elemento _ _ _ GasNoble) = "conduce bien Calor"
conduceBien2 Calor (Compuesto _ _ Halogeno) = "conduce bien Calor"
conduceBien2 _ _ = "no conduce Nada"

esHalogeno (Compuesto _ _ Halogeno) = True
esHalogeno _ = False

esGasNoble (Elemento _ _ _ GasNoble) = True
esGasNoble _ = False

esMetal (Elemento _ _ _ Metal) = True
esMetal (Compuesto _ _ Metal) = True
esMetal _ = False
