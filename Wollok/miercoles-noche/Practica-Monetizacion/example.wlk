//?????????????????????????????????????????????????????????????????????????
class TipoContenido{
  var titulo
  var monetizacion
  // var esOfensivo = false
  var property esOfensivo = false

  var property cantVistas


  //* Si no pongo esto aca, puede que durante todo el flujo se cree un contenido 
  //* con una monetizacion incorrecta. Con esto me aseguro que de primera la monetizacion sea correcta
  //? Creo mi propio setter
  method monetizacion(nuevaMonetizacion){
    if(!nuevaMonetizacion.puedeAplicarseA(self))
      throw new DomainException(message = "Este contenido no soporta la forma de monetizacion") 

    monetizacion = nuevaMonetizacion
  }

  //* Lo que se ejecuta de primeras al instanciar una clase de TipoContenido
  override method initialize(){
    if(!monetizacion.puedeAplicarseA(self))
      throw new DomainException(message = "Este contenido no soporta la forma de monetizacion")    
  }
  
  method esPopular()//* Solo a modo de documentacion 
  // method recaudacion() 
  method maximoRecaudacion() //* Nuevamente a modo de documentacion
  method recaudacion() = monetizacion.recaudacion(self)

  method puedeAlquilarse() //* Nuevamente por documentacion principalmente
}

class Video inherits TipoContenido{
  override method maximoRecaudacion() = 10000 
  // override method recaudacion() = monetizacion.recaudacion(self)

  override method esPopular() = cantVistas > 1000
  
  override method puedeAlquilarse() = true 
}

const tagsDeModa = ["bla"]
class Imagen inherits TipoContenido{
  override method maximoRecaudacion() = 4000
  
  const property tags = []
  // override method recaudacion() = monetizacion.recaudacion(self)
  override method esPopular() = tagsDeModa.all{ tag => tags.contains(tag)} //* Verifica que todos los indices
  //* de tagsDeModa esten dentro de tags[]

  override method puedeAlquilarse() = false 

}

//?????????????????????????????????????????????????????????????????????????

// class Monetizacion{
//   method recaudacion(objeto)
//   method plus(objeto)
// }


object publicidad { //* Objeto pues no tendra atributos propios del que dependa 
  // override method recaudacion(objeto) = (if(!objeto.esPopular()) self.recaudacionBase(objeto) else self.recaudacionBase(objeto) + 2000).min(objeto.maximoRecaudacion())  
  
  //* Con la validacion que es necesario, del tercer punto, se asegura que la monetizacion 
  //* ya venga con el contenido apropiado
  // method recaudacion(objeto) = if(!objeto.esOfensivo()) (self.recaudacionInicial(objeto)).min(objeto.maximoRecaudacion()) else 
  //                                       throw new ErrorDeMonetizacionException(message = "No se puede usar esta monetizacion")


  method recaudacion(contenido) = (
      0.05*contenido.cantVistas() + 
      if(contenido.esPopular()) 2000 else 0
  ).min(contenido.maximoRecaudacion())


  // method recaudacionInicial(objeto) = (if(!objeto.esPopular()) self.recaudacionBase(objeto) else self.recaudacionBase(objeto) + 2000)
  //* Forma simplificada por el profe pelado 
  method recaudacionInicial(objeto) = 0.05 * objeto.cantVistas() + if(objeto.esPopular()) 200 else 0
  
  // method recaudacionBase(objeto) = objeto.cantVisitas() * 0.05

  method puedeAplicarseA(contenido) = !contenido.esOfensivo()  
  
}
class Donacion {
  var property donacion 

  method recaudacion(objeto) = donacion
  method puedeAplicarseA(contenido) = true
}
class VentaDeDescarga {
  const property valorDeVenta
  
  method recaudacion(objeto) = objeto.cantVistas() * valorDeVenta 
  //* Devuelta ya se verifico por el punto 3
  // method recaudacion(objeto) =
  //    if(objeto.esPopular())(objeto.cantVistas() * valorDeVenta) 
  //    else throw new ErrorDeMonetizacionException(message = "El contenido no es popular para ser vendido")
  

  method puedeAplicarseA(contenido) = contenido.esPopular()
}


class Alquiler inherits VentaDeDescarga{

  override method valorDeVenta() = 1.max(super())
  
  override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse()
}



//* "EL EMAIL DE LOS 100 USUARIOS"
// class Sistema{
object usuarios{ //* Objeto que acompaña

  const todosLosUsuarios = []

  //* El usuario => usuario.verificado() ya te compara y te trae unicamente los que tenga verificado = true
  //* sortedBy devuelva una lista nueva ordenada
  //* sortBy solo te devuelve la lista vieja pero ordenada
  // Filter devuelve solo a los verificados
  method emailDeLosUsuariosRicos() = todosLosUsuarios
        .filter{usuario => usuario.verificado()}  
        .sortBy{usuario, otroUsuario => usuario.saldoTotal() > otroUsuario.saldoTotal()}
        .take(100)
        .map{usuario => usuario.email()} //Te devuelve la lista de los emails de los usuarios
  
  // method cantSuperUsuarios() = todosLosUsuarios
  //         .filter{usuario => usuario.superUsuario() }.size()
  //* El count es equivalente a hacer filter().size()
  method cantSuperUsuarios() = todosLosUsuarios
          .count{usuario => usuario.esSuperUsuario() }
}


class Usuario{ //* Se modela la idea de un usuario, no todos los usuarios
  var property nombre
  var property email
  var property verificado = false
  const contenidos = [] // Tipo Contenido

  // method esSuperUsuario() = contenidos.filter{contenido => contenido.esPopular()}.size() > 10 
  //* Nuevamente, filter().size() es equivalente a count
  method esSuperUsuario() = contenidos.count{contenido => contenido.esPopular()} >= 10 


  method saldoTotal() = contenidos.sum{contenido => contenido.recaudacion()}

  // method agregarContenido(contenido, monetizacion) { //* Se arregla para que el contenido ya venga con
  //* una monetizacion ya correcta

  method agregarContenido(contenido) {
            contenidos.add(contenido)
  }
}



//? EXCEPCIONES
class ErrorDeMonetizacionException inherits Exception{

}