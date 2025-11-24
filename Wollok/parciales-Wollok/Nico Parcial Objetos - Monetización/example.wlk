class Contenido{ // Clase abstracta
  const property titulo
  var property vistas = 0 
  var property ofensivo = false
  var property monetizacion // Se optará por composicion pues se cambiara 
  // la forma de monetizacion asi que monetizacion variará 
  
  method monetizacion(nuevaMonetizacion){
  // Me redeclaro el setter para traer la logica de verificar cierta
  // monetizacion a un contenido, pues antes no era responsabilidad del usuario

    self.validarMonetizacion(nuevaMonetizacion)
      monetizacion = nuevaMonetizacion
  }

  method initialize(nuevaMonetizacion){
    self.validarMonetizacion(nuevaMonetizacion)
  }
  
  method validarMonetizacion(nuevaMonetizacion){
    if(!nuevaMonetizacion.puedeAplicarse(self))
    throw new DomainException(message = "Este contenido no soporta la forma de monetizacion.")

  }

  method puedeVenderse() = self.esPopular()
  // Cuando puedo venderme? si sos popular. ¿cuando sos popular? Ah no se 
  // mi subclase lo sabrá

  method recaudacion()= monetizacion.recaudacionDe(self)
  method esPopular() // Es un metodo abstracto
  // Ergo, es clase abstracta
  method recaudacionMaximaParapublicidad() = 10000

  method puedeAlquilarseA()
}

// La responsabilidad de saber si algo es popular (una imagen o video) es justamente del video o imagen
class  Video inherits Contenido{
  override method esPopular() = vistas > 10000
  override method recaudacionMaximaParapublicidad() = 10000

  override method puedeAlquilarseA() = true
  
}

const tagsDeModa = ["objetos", "pdep", "serPeladoHoy"]

class Imagen inherits Contenido{
  const property tags = []
  
  override method esPopular() = tagsDeModa.all{tag =>tags.constains(tag)}
  // “para cada tag de la colección tagsDeModa, verificá si tags (los del objeto imagen) contiene ese mismo tag”
  override method recaudacionMaximaParapublicidad() = 4000

  override method puedeAlquilarseA() = false


}



// Monetizacion 

object publicidad{ // objecto porque no necesitare instanciarlos

  method recaudacionDe(contenido) = (
    0.05 * contenido.vistas() +
    if(contenido.esPopular()) 200 else 0).min(contenido.recaudacionMaximaParapublicidad()) 
    // Si contenido.esPopular true, devuelve 200, si no 0 
    // el recaudacionMaximaParapublicidad será el minimo y se elegira justamente el minimo de ambos

    method puedeAplicarse(contenido) = !contenido.ofensivo()
} 

class Donacion{
  var property donaciones = 0

  method recaudacionDe(contenido) = donaciones 

  method puedeAplicarse(contenido) = true

}

class Descarga{
  const property precio

  method recaudacionDe(contenido) = contenido.vistas() * precio 
  // method puedeAplicarse(contenido) = contenido.puedeVendeser()
  method puedeAplicarse(contenido) = contenido.puedeVenderse()

}

class Alquiler inherits Descarga{
  override method precio() = 1.max(super())
  method puedeAlquilarseA(contenido) = super.contenido(contenido) && contenido.puedeAlquilarseA()
}




// USUARIO


// const usuario = [] // No una buena idea. Se terminaria creando por consola
// y se pierde la informacion.

object usuarios { // "objeto compañero" para conductas que no dependan de una clase
  const property todosLosUsuarios = []

  // Con objeto puedo ponerle mensajes
  method emailsDeUsuariosRicos() = todosLosUsuarios.
        filter{usuario => usuario.verificado()
        .sortedBy{uno, otro => uno.saldoTotal() > otro.saldoTotal()}}.
        take(100).map{usuario=>usuario.email()}

  method cantidadDeSuperUsuarios() = todosLosUsuarios.count{usuario => usuario.esSuperUsuario()}
  // Tiene sentido que la responsabilidad de esSuperUsuario caiga en usuario y no en todos los usuarios
  
}
class Usuario{ // Idea de un usuario
  const property nombre
  const property email
  var property verificado = false
  const contenidos = []

  //const usuario = [] // MAAL!!! no es responsabilidad de un usuario
  // conocer la existencia de otros usuario
  
  // method saldoTotal() = contenidos.sum{ credito => contenidos.recaudacionDe(credito)}
  method saldoTotal() = contenidos.sum{ contenido => contenido.recaudacion()}

  method esSuperUsuario()=contenidos.count{contenido => contenido.esPopular()} >= 10

  method publicar(contenido) {
  // method publicar(contenido, monetizacion) {
  
    // if(monetizacion.puedeAplicarse(contenido))
    //   throw new DomainException(message = "El contenido no soporta la forma de monetizacion.")
    
    // contenido.monetizacion(monetizacion)
    //!!! Se delega confiando en que el contenido viene ya validado con su monetizacion!!!!
    contenidos.add(contenido)
  } 
}


 