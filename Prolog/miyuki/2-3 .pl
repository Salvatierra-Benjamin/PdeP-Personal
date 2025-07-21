/*¡Tenemos nuevos sectores!: proyectos y logística. Y queremos saber qué empleados pueden servir para cada uno de ellos. 
Se sabe que:

- proyectos: pueden andar ingenieros con experiencia y también abogados jóvenes.
- logística: pueden andar profesionales (ingenieros o abogados) que sean jóvenes o tengan experiencia.

Además se sabe que:
- Fulgencio pueda andar para proyectos pero no para logística
- Clotilde pueda andar para ventas pero no para contaduría.

Asumir que la base de conocimiento ya contiene algunos otros empleados, con hechos de la forma: conExperiencia/1, joven/1, 
ingeniero/1, abogado/1

Codificar las nuevas clausulas del predicado puedeAndar/2, que relaciona a un sector con un empleado.*/


conExperiencia(empleado).
joven(empleado).
ingeniero(empleado).
abogado(empleado).
% profesional(empleado).

% proyectos -> ingeniero y con experiencia
% proyectos -> abogado y joven

% logistica -> profesional y joven
% logisitca -> profesional y con experiencia

profesional(Empleado):-
    abogado(Empleado).

profesional(Empleado):-
    ingeniero(Empleado).

puedeAndar(proyectos,fulgencio).

puedeAndar(proyectos, Empleado):-
    ingeniero(Empleado),
    conExperiencia(Empleado).

puedeAndar(proyectos, Empleado):-
    abogado(Empleado),
    joven(Empleado).

puedeAndar(logistica, Empleado):-
    profesional(Empleado),
    joven(Empleado).

puedeAndar(logistica, Empleado):-
    profesional(Empleado),
    conExperiencia(Empleado).

puedeAndar(ventas, clotilde).