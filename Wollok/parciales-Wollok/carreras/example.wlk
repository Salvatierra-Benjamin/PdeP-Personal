// todos tienen habilidades
// incapacitado => salud esta debjo de la salud crítica


class Empleado{
  var salud = 100
  method saludCritica() // metodo abstracto, el metodo esta definido en los hijos???
  method estaIncampacitado() = salud < self.saludCritica() 
  // al hacer self.saludCritica desde terminal y de un hijo, 
  // el self. buscara en el hijo saludCritica
  
}

class Espia inherits Empleado{
  method saludCritica()=15
  // method estaIncampacitado() = salud < self.saludCritica()

}

class oficinista inherits Empleado{
  // var saludCritica = 40
  // si tenemos un valor que es dependiente de otro, va como metodo. De lo contrario smells
  method saludCritica()= 40 - (5*cantEstrellas)
  var cantEstrellas = 0
  // method estaIncampacitado() = salud < self.saludCritica()


  method ganarEstrellas(){
    cantEstrellas = cantEstrellas +1
    
  }
}

// modelar misiones??

