% Inversibilidad

% cuando puedo puedo usar los argumentos como entrada( con un individuo)
%   o como salida (variable libre que empieza con mayuscula).

% predicado generador
persona(nahuel).
persona(juan).
persona(caro).

programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, ruby).
programaEn(caro, haskell).
programaEn(caro, scala).
programaEn(caro, javascript).

% puedo preguntar por consola programaEn(_,c) , pero no podre preguntar quienes son todos los que programan en cierto lenguajes

programaEn(Persona, c):-
    persona(Persona).

% con esta Regla programaEn(Persona,c) puedo preguntar quienes son todos los que programan en c y además 


% negación not/1 - niega el valor de verdad, no te devuelve los valores que hagan falsa la consulta.

not(programa(nuhuel,ruby)).
% true


irremplazable(Persona):-
    programaEn(Persona, Lenguaje),
    not((programaEn(Alguien, Lenguaje), 
        Alguien\= Persona)). 

