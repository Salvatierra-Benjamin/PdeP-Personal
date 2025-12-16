//* IMPRESORAS -> TIENEN CABEZAL
// DISTINTO CABEZAL USA DIFERENTE LA TINTA
// CADA CABEZAL TIENE CARTUCHOS

/*
> const documento = ... 

> const impresoras = [...]

> impresoras.anyOne().imprimir()
* Si anyOne() no encuentra a nadie
> wollok.lang.exception : illegal operation 'anyOne' on empty //! Que frene por completo

> if(!impresoas.isEmpty()) impresoras.anyOne().imprimir()
!??? como puedo saber si se hizo realmente, o si hubo otro error??

? TODO METODO DEBE HACER LO QUE PROMETE,
? O NO HACER NADA Y EXPLOTAR.

*/

// class Impresora{
//   const cabezal

//   method trazar(recorrido){}

//   method mostrarEnPantalla(mensaje){}

//   method imprimir(documento){
//     cabezal.eyectar(documento.tinta())
//     self.trazar(documento.recorrido())
//   }
// }


class Cabezal{
  const eficiencia
  const cartucho

  method liberar(){}

  method eyectar(cantidad){
    cartucho.extraer(1 / eficiencia * cantidad)
    self.liberar()
  }
}


// class Cartucho{
//   var carga

//   method extraer(cantidad){
//   // method extraerSiPodes(cantidad){ //* Esto, aun que sea comico, a veces es suficiente.

//     if(carga >cantidad) //* no me asegura como llega la impresion a la impresora
//     //* Este metodo se ejecuta previo a muchos otros en otras clases. 
    
//     carga -= cantidad //? solo con esto puede la carga en negativo   
//   }
// }

//? Hacer todo devuelta, pero antes de enviar el metodo imprimir, enviar el metodo
//? method podesImprimir??? Este recorreria todos consultando 


//* Poner una verificacion con true o false en cada nivel queda sucio porque repetis
//* logica en cada nivel




class Cartucho{
  var carga

  method extraer(cantidad){
    if( carga < cantidad)
    throw new SinCargaException( carga = carga) //* Tiro este error para que reviente en impresora

    // throw new Exception( message = "Sin carga") //? BURBUJEO de error
    //? Si se lanza este error, sube todos los niveles (cabezal, impresora hasta usuario) para
    //? romper por no tener tinta. Y se verá al final en la consola
    carga -= cantidad
  }
}

// class Impresora{
//   const cabezal
//   const cabezalAux

//   method trazar(recorrido){}
//   method mostrarEnPantalla(mensaje){}

//   method imprimir(documento){
//     //* En nuestro caso (ahora tenemos dos cabezal, cada cabezal solo un cartucho(creo))
//     //* Si un cabezal no funciona, salta un error y probamos con el cabezalAux
//     //* Es como un if else
//     try {
//         cabezal.eyectar(documento.tinta())
//     // } catch error{ //? el catch error obsorve CUALQUIER error que haya sucedido con el try, sin importar cual  
//     } catch error : SinCargaException{   

//       cabezalAux.eyectar(documento.tinta())
//     } catch error{
//       self.mostrarEnPantalla(error.message()) //* Raro que queramos absorver TODO los errores en uno
//     }
//     self.trazar(documento.recorrido())
//   }
// }

class SinCargaException inherits DomainException{
  const property carga
}


//* PRACTICA :))


/*
Impresoras ocupadas:

  - Una impresora "ocupada" no puede imprimir.carga()
  - Una impresora permanece "ocupada" mientras imprimre "hay otras causas"
  - Si algo saliera mal durante una impresion, la imporesora se desocupa
*/


class Impresora{
  const cabezal
  const cabezalAux
  var property ocupada

  method trazar(recorrido){}
  method mostrarEnPantalla(mensaje){}

  // method puedoImprimir() = !ocupada

  // method validarQuePuedoImprimir(){
  //   if(!self.puedoImprimir()) throw new NoPuedoImprimirException()
  // }
  
  //! ESTO NONONONO HACER
  // method puedeImprimir(){
  //   if(!ocupada) return true
  //   else throw new NoPuedoImprimirException()
  // }
  
  

  method imprimir(documento){
    // self.validarQuePuedoImprimir()

    // if(!self.pruedeImprimir()) throw new NoPuedoImprimirException()
    
    if(ocupada) throw new NoPuedoImprimirException()

    //* En nuestro caso (ahora tenemos dos cabezal, cada cabezal solo un cartucho(creo))
    //* Si un cabezal no funciona, salta un error y probamos con el cabezalAux
    //* Es como un if else
    try {
        cabezal.eyectar(documento.tinta())
    // } catch error{ //? el catch error obsorve CUALQUIER error que haya sucedido con el try, sin importar cual  
    } catch error : SinCargaException{
      cabezalAux.eyectar(documento.tinta())
    } then always {
      ocupada = false
    } 
    
    self.trazar(documento.recorrido())
  }
}

//! Nunca pero nunca capturar un error y no hacer nada!!

class NoPuedoImprimirException inherits DomainException{

}