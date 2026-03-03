{-
Definir una función inversa, que invocando a la función con un número cualquiera me devuelva su inversa.
Main> inversa 4
0.25
Main> inversa 0.5
2.0
-}

{-
Jerarquia de operadores:
- parentesis
- aplicacion prefija (ej: siguiente 300)
- compisición
- ** (exponente)
- * , / multiplicacion y division
- + y -
- > , >= , < , <= , == , /=
- && , ||
- ($)
-}

inversa = (** (-1))