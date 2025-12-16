

/*
 Los objetos tienen:
* Interfaz: conjunto de operaciones(mensajes) que puedo hacer con el objeto.
* no podemos interactuar directamnte con los atributos del objetos, solo le mandamos mensajes y este cambia
* sus atributos.
* metodo es la accion, implementacion de los mensajes.

*Estado interno: conjunto de atributos. Que referencia a otros objetos.

*Entidad: si ambos objetos tienen los mismos metodos, siguen teniendo diferente identidad ergo son diferentes objetos

*/

object pepita{
  var energia = 100

  // Desde afuera no podemos hacer efecto en energia = 100, por lo que 
  // enviandole mensajes (method) es que le decimos al objeto de que si lo haga.
  
  // Instruccion que el objeto seguira al llegarle vola(), 
  // No retorna nada
  method vola(kilometro){
    energia = energia - kilometro * 2
  }

  method come(gramos){
    energia = energia + gramos * 10
  }

  // Solo retorna energia
  // Tiene el mismo nombre que el atributo, y es porque nosotros no 
  // podemos acceder al atributo, asi que con este method vamos a poder hacerlo
  method energia()= energia //* Getter
}

object emilia{
  method entrena(ave){
    // a Emilia no le importa que el ave sea pepita, solo le importa que sepa
    // volar y comer
    // A Emilia solo le importa  que ave sepa volar y comer 
    ave.come(5)
    ave.vola(10)
    ave.come(5)
  }
}

object pepote{
  var volado = 0 
  var comido = 0

  method vola(kilometro){
    volado = volado + kilometro
  }

  method come(gramos){
    comido = comido + gramos
  }

  method energia() = 255 * comido **2 - volado/5
}

//? Pepita y pepote trabajan polimorficamente para emilia

//? Para el polimorfismo aparte de que entienda los mensajes, necesita recibir la misma
//? cantidad de parametros, puede que incluso pongamos parametros al pedo solo para que 
//? cumpla con el polimorfismo.




/*
*Terna para un buen manejo del Paradigma de Objetos

*Encapsulamiento: un objeto no puede acceder a los atributos de otro.

*Delegacion: darle la responsabilidad a otro. Ej. pepita es la que come, no de emilia.

*Polimorfismo: que un objeto pueda usar un objeto u otro, sin importar que sean diferente.
*/

//! PRACTICA :D

/*
Implementar a Ramiro, que cuando entrena una ave la hace volar 15km
cuando esta de buen humor, y cuando no, el doble. Ramiro solamente esta de
buen humor cuando durmio, por lo menos, 8 horas.
*/

//* SIEMPRE QUE SE TENGA QUE CALCULAR, LO HACEMOS EN BASE A ATRIBUTOS
//* EJ: ESTACANSADO DEPENDERA DE LAS HORAS QUE DURMIO
object ramiro{

  var horasQueDurmio = 0

  method horasQueDurmio() = horasQueDurmio  //*Getter
  method horasQueDurmio(horas) {            //*Setter
    horasQueDurmio = horas
  }
  
  method estaDeBuenHumor() = horasQueDurmio < 8 
  
  method entrena(ave){
    // if(self.estaDeBuenHumor()){
    //   ave.vola(15)
    // }
    // else{
    //   ave.vola(30)
    // }
    const distancia = if(self.estaDeBuenHumor()) 15 else 30
    ave.vola(distancia)
  }
}

