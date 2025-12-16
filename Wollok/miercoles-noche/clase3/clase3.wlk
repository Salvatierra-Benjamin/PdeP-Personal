// object pepita{ //* Pasara a ser una clase, la idea de golondrinas
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

// Clases \= Objetos

/*
*La clase me sirve para construir la idea de los objetos
*Las clases nos servira para: 
  - instanciar objetos
  - definen atributos
  - proveen metodos
*/


//> const pepita = new Golondrina() <---- me genera un objeto pepita
// pepita.energia()
// 100 <---- me devuelve esto


//> const pepito = new golondrina(energia = 180) <---- me genero un objeto pero este tendra otra inicializacion de energia
// pepito.energia() 
// 180 <---- me devuelve la nueva energia


//*Referencia y Garbage Collection 

//const pepita = new Golondrina()   <---- mantenemos una referencia al objeto

// new Golondrina()                 <---- ya no tengo una referencia, la pierdo