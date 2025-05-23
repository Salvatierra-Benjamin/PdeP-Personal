{-Dispersión
Trabajamos con tres números que imaginamos como el nivel del río Paraná a la altura de Corrientes medido en tres días consecutivos;
cada medición es un entero que representa una cantidad de cm.
P.ej. medí los días 1, 2 y 3, las mediciones son: 322 cm, 283 cm, y 294 cm.
A partir de estos tres números, podemos obtener algunas conclusiones.
Definir estas funciones:

a) dispersion, que toma los tres valores y devuelve la diferencia entre el más alto y el más bajo.
Ayuda: extender max y min a tres argumentos, usando las versiones de dos elementos.
De esa forma se puede definir dispersión sin escribir ninguna guarda (las guardas están en max y min, que estamos usando).

b) diasParejos, diasLocos y diasNormales reciben los valores de los tres días.
Se dice que son días parejos si la dispersión es chica, que son días locos si la dispersión es grande,
y que son días normales si no son ni parejos ni locos.
Una dispersión se considera chica si es de menos de 30 cm, y grande si es de más de un metro.
Nota: Definir diasNormales a partir de las otras dos, no volver a hacer las cuentas.

-}

-- Diferencia dia más bajo y dia más alto
diaMasAlto num1 num2 num3 = max (max num1 num2) num3

diaMenor num1 num2 num3 = min (min num1 num2) num3

dispersion num1 num2 num3 = diaMasAlto num1 num2 num3 - diaMenor num1 num2 num3

-- Dias

diasParejos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 < 30

diasLocos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 > 100

diasNormales dia1 dia2 dia3 = not (diasParejos dia1 dia2 dia3 || diasLocos dia1 dia2 dia3)

-- negar la parte derecha pues "no son ni parejos ni locos"