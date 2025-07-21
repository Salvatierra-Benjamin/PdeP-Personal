/*
Los siguientes son los empleados de una empresa:

Departamento de ventas:
gerente: María
cadetes: Juan y Roque
Departamento de compras:
gerente: Nora
cadete: Pedro
Departamento de administración:
gerente: Felipe
cadetes: Ana y Hugo
Desarrollará esta base de conocimientos de forma tal que se pueda responder consultas de la siguiente forma:

?- trabajaEn(compras, nora).
yes
?- trabajaEn(compras, ana).
no
Modelá el conocimiento utilizando hechos empleado/3, que relacionan un deparamento, una persona y su puesto.

*/

empleado(ventas,maria, gerente).
empleado(ventas, juan, cadete).
empleado(ventas, roque, cadete).

empleado(compras, nora, gerente).
empleado(compras, pedro, cadete).

empleado(administracion, felipe, gerente).
empleado(administracion, ana, cadete).
empleado(administracion, hugo, cadete).


trabajaEn(ventas, Empleado):-
    empleado(ventas, Empleado, _).

trabajaEn(compras, Empleado):-
    empleado(compras, Empleado, _).

trabajaEn(administracion, Empleado):-
    empleado(administracion, Empleado, _).