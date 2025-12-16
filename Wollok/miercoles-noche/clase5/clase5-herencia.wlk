class Tanque{ //* Vamos a querer construir varios tanques
  const armas = []
  const tripulantes = 2 
  var salud = 1000
  var property prendidoFuego = false

  method emiteCalor() = prendidoFuego || tripulantes > 3

  method sufrirDanio(danio){
    salud -= danio
  }

  method atacar(objetivo){
    armas.anyOne().dispararA(objetivo)
  }
}


//? Como no tengo atributos/estados del objeto lanzaLlamas, me sirve para representar varios
//? objetos
//! object lanzaLlamas{ // Me evito crear clases pues como solo voy a tener un objeto
// class LanzaLlamas{ // Me evito crear clases pues como solo voy a tener un objeto
//   var cargador = 100

//   method agotada() = cargador <= 0 //*Con esto
//   method disparaA(objetivo){
//     objetivo.prendidoFuego(true)
//   }
// }


//? Como esta arma tendra un estado interno distinto, es apropiado tener una clase,
//? donde cada objeto que salga de la clase, tenga una potencia distinta
class Misil{
  const potencia 
  method dispararA(objetivo){
    objetivo.sufirDAnio(potencia)
  }
}

//! PELIGRO
//? Uno estaria tentado a querer modelar las tres metrallas 
//? con una clase, pero si se presta atencion, el danio que se le pasa a 
//? objetivo.sufrirDAnio() varios entre cada uno

object metrallaChica{
  const property calibre = 12

  method dispararA(objetivo){
    // Calibre muy chico, no hacen danio
  }
}

object metrallaMediana{
  const property calibre = 40
  method dispararA(objetivo){
    objetivo.sufrirDanio(10)
  }
}

object metrallaGrande{
  var emiteCalor = true
  const property calibre = 120
  method dispararA(objetivo){
    objetivo.sufirDanio(30)
  }
}

// class Metralla{
//   const property calibre

//   //? Esto ahora repite logica con Lanzallamas, y mas ahora que Lanzallamas es una clase
//   //? Entra herencia en juego
//   var cargador = 100

//   method agotada() = cargador <= 0
  
//   method dispararA(objetivo){
//     if(calibre > 50) objetivo.sufrirDanio(calibre / 4)
//   }
// }

//? HERENCIA
/*
Es donde mis clases iran a buscar ciertas cosas, methodos o atributos

*Clase que no se instancia es la CLASE ABSTRACTA
*esta clase es para la finlidad de compartir logica y no instanciar. Nunca hare new...
*/


class Recargable{ //? No me interesa instanciarla. Esta es una CLASE ABSTRACTA, que solo me dará la logica.
  var cargador = 100
  
  method recargar() {
    cargador = 100
  }

  method agotada() = cargador <= 0
}

// class LanzaLlamas inherits Recargable{ // Me evito crear clases pues como solo voy a tener un objeto

//   method disparaA(objetivo){
//     cargador -= 20
//     objetivo.prendidoFuego(true)
//   }
// }

class Metralla inherits Recargable{
  const calibre 

  method dispararA(objetivo){
    cargador -= 10
    if (calibre > 50) objetivo.sufrirDanio(calibre / 4) 
  }
}

//? Solo puedo heredar de clases, no de objetos. 


//* REDEFINICION


class MisilDos{
  const potencia 
  var agotada = false

  method agotada() = agotada
  
  // Y si quiero que solo dispare a objetos que emitan calor??? 
  method dispararA(objetivo){
    agotada = true 
    objetivo.sufirDAnio(potencia)  
  }
}


class MisilTermino inherits MisilDos{ //? Si mando el disparaA() quiero que se comporte 
//? diferente antes de llegar a la clase de la que heredo, ergo tenemos que sobreescribir

  override method dispararA(objetivo){ //De esta forma copia todo, menos el disprarA()
    if(objetivo.emiteCalor()){
    //* Estas dos lineas se repite, y no basta con hacer self.dispararA() porque entra en loop infinito
    // agotada = true 
    // objetivo.sufrirDanio(potencia) 
      super(objetivo) // Ejecuto en el padre dispararA()
      //* SUPER SOLO SIRVE PARA METODOS OVERRIDED
      //* El super no me deja especificar de que clase padre heredar el metodo
      // De esta forma le agrege un "PLUS" al metodo dispararA()

    //* Estaria mal poner heredar misil de misilTermino porque justamente es al revez, el misilTermino es 
    //* algo particular de misil
    }
  }

}

class A {
  method m2() = 2
  method m4() = self.m5()
  method m5() = 5
}

class B inherits A {
  override method m2() = self.m3()
  method m3() = 8
  override method m4() = super()
}

class C inherits B {
  method m1() = self.m2()
  override method m3() = self.m4()
  override method m5() = 9
}

class D inherits C {
  override method m3() = 26
  override method m4() = 41
  override method m5() = 6
}


// Al quere hacer 
// < new C().m1() 
// 9


// * POR QUE??: 
// * se mete al m1() de C,
// * Busca m2() en C, pero como no esta se va al padre
// * En B, encuentra m2() = self.m3() 
// * El self.m3() reinicia el metodo lookup, y vuelve a C!!!!
// * En C, encuentra m3() = self.m4(), 
// * Ya estando en C, no encuentra m4() 
// * Va al padre (B) y encuentra m4() = super(), 
// * Con el super se va a A
// * En A encuentra m4() = self.m5(). Esto reinicia nuevamente el metodo lookup
// * Regresa a C por el self que reinicia
// * En C encuentra method m5() = 9
// ? Entonces devuelve todo 9



// ! Si borro, method m4() = super()
// * No tiene sentido alguno porque solo heredo, no le agrego algo mas 





class TanqueBlindado inherits Tanque{
  const blindaje = 200

  override method emiteCalor() = false
  override method sufrirDanio(danio){
    if (danio > blindaje)
      super(danio - blindaje) //Le paso por parametro una resta. 
      // Sufrire menos danio, pero con la logica del Tanque (la super clase)
  }
}


// class MataFuego inherits Recargable{
//   //? EUREKA. FINALICE!! NONONO
//   //* Esto es demasiado parecido a la logica de LanzaLlamas!!!!
//   method dispararA(objetivo){
//     cargador -= 20
//     objetivo.prendidoFuego(false)
//   }
// }


class Rociador inherits Recargable{ //? Esta es abstracta
  // method descargarPorRafaga() = 20
  method dispararA(objetivo){
    cargador -= 20
    self.causarEfecto(objetivo) //* Esto me sirve para yo despues 
    //* overridear el metodo causarEfecto dentro de las subclases
  }

  method causarEfecto(objetivo) //? Metodo abstracto \= clase abstracta
  //? Este metodo solo me dice que tengo que tener algo, pero las subclases
  //? se ocuparan de saber que hacer
}

//? TEMPLATE METHOD MUY POTENTE

class Matafuego inherits Rociador{
  override method causarEfecto(objetivo){ //* Aca es donde overrideo que efecto tendre
  //* segun el arma
    objetivo.prendidoFuego(false)
  }
}

class LanzaLlamas inherits Rociador{
  override method causarEfecto(objetivo){
    objetivo.prendidoFuego(true)
  }
}


class Sellador inherits Rociador{
  override method causarEfecto(objetivo){
    objetivo.salud(objetivo.saludo() * 1.1)
  }

  // override method descargarPorRafaga() = 25
}