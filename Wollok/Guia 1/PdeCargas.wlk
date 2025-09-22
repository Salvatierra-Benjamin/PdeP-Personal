object verdurin{
    var cantCajas = 10          // unidades
    const pesoCajas = 50        // kg 
    var prueba123 = 20
    var kilometraje = 700000    // kms
    // var pesoTotal = 500         // cantCajas * pesoCajas

    method pesoDeCarga()= cantCajas * pesoCajas
    
    method cantCajasACargar(nuevaCantidad){
        cantCajas = nuevaCantidad
        // return cantCajas     // solo si quiero ver el efecto
    }
    
    method velocidadMaxima() =
        80 - self.pesoDeCarga().div(500)
    // no podre ver el efecto (no return)
    

    // method ejemplo(){
    //     var variableLoca = self.pesoDeCarga().div(500)
    //     return variableLoca
    // }
}

object scanion5000{
    var litrosCargados = 5000 // 5000*1
    const densidad = 1      // litros
    var velocidadMaxima = 140   // km/h

    method pesoDeCarga() = litrosCargados * densidad
}



object cerealitas{
    var nivelDeDeterioro = 0
    // modificarlo al hacer viajes
    // var velocidadMaxima = 10
    method velocidadMax(){
        if (nivelDeDeterioro < 10){
              return 40
        } else{
            return 60 - nivelDeDeterioro
        }
    }
}

object rutaAtlantica{
    var precioBase = 7000

}
