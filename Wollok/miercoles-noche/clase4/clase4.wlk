class Golondrina{
  var energia = 100

  method vola(kilometro){
    energia = energia - kilometro * 2
  }

  method come(gramos){
    energia = energia + gramos * 10
  }

  method energia()= energia //* Getter
}


object pepito{
  var energia = 100

  method vola(kilometro){
    energia = energia - kilometro * 2
  }

  method come(gramos){
    energia = energia + gramos * 10
  }

  method energia()= energia //* Getter
}




/*
*Colecciones
-Listas: 
const lista = [1, 2, 3]

> const vacas = [new Vaca(), new Vaca()]

> vacas.add(new Vaaca())

> vacas.size()
> 3

> vacas.filter(estaContenta) //! <---- ROMPE

*/


/*
*BLOQUES
> vacas.filter({vaca => vaca.estaContenta()})
> vacas.filter{vaca => vaca.estaContenta()} <--- lo mismo que sin parentesis
[unaVacaContenta, otraVacaContenta]

*/

//! Esto se hace incomodo, por eso se usa las lambda
object criterioEstaContenta{
  method apply(vaca) = vaca.estaContenta()
}


/*
? Igualdad, identidad y mutabilidad

> const rosita = new Vaca()

> const petunia = new Vaca()

? petunia y rosita vienen de la misma clase, pero estos son diferentes

> const vacas = [rosita, petunia]
> const triste = vacas.filter{ vaca => !vaca.estaContenta()}

! filter y map para consultas

!forEach es para causar efecto

*/


/*
* PRACTICA :D

Modelar un corral de vacas que permita: 
- Consultar cuantos litros de leche podemos ordeniar de vacas contenta.
- Saber si todas las vacas estan contentas. 
- Ordeniar todas las vacas contentas. 
- Podemos agregar cabras?
*/

class Corral{
  // const vacas = []
  const bicho = []


  // method lecheDisponible() = bicho.filter{vaca => vaca.estaContenta()}.map{vaca => vaca.litrosDeLeche()}.sum()
  method lecheDisponible() = bicho.filter{vaca => vaca.estaContenta()}.sum{vaca => vaca.litrosDeLeche()}

  //? el filter me devuelve la lista de bicho contentas
  //? el map me devuelve el litro de leche de cada vaca
  //? y por ultimo se suma la leche de cada vaca contenta
  
  method todasContentas() = bicho.all{vaca => vaca.estaContenta()}

  method ordeniar() { //?Ordenio a todas las bicho
    bicho.forEach{vaca => if(vaca.estaContenta()) vaca.ordeniar()} //? ordenio cada vaca
  }
  
  
}
