// Clase 3

// Huellitas (veterinaria (establecimiento de veterinarios))

object huellitas {
    const capacidadMaxima = 10;
    // Las listas son homogéneas pero porque todo en Wollok es un objeto
    const botiquin = [ "venda", "venda", "jeringa", "gasa" ];

    // Define un conjunto. Es decir, sus elementos no se repiten y no tienen
    // orden
    const pacientes = #{ pepita, kali, nano }

    method cantidadDePacientes() = pacientes.size();

    method darDeAlta(unPaciente) {
        pacientes.remove(unPaciente);
    }

    // Usar el = reemplaza el return
    method estaLleno() = self.cantidadDePacientes() > capacidadMaxima;

    // No crear variables para cosas que puedo calcular en el momento

    // Ejemplo de polimorfismo, entre listas y conjuntos:
    //
    // agregarAColeccion(pacientes, unPaciente);
    // agregarAColeccion(botiquin, unInstrumento);
    method agregarAColeccion(unaColeccion, unElemento) {
        unaColeccion.add(unElemento);
    }

    // Bloque/Closure. Similar a las lambdas. Se puede usar un método también
    // {1,2,3}.find({numero => numero == 2})
    //
    // Los bloques pueden referenciarse:
    // > logica = {numero => numero == 2}
    // > logica.apply(3)
    // false
    // > logica.apply(2)
    // true

    method pacienteMasEnergico() {
        return pacientes.max({ paciente => paciente.energia() });

        // O sea que esto estaría mal:
        //      return numeros.max({ num => num });
        // Mejor usar esto:
        //      return numeros.max();
    }

    method pacientesRecuperados() {
        return pacientes.filter({ paciente => paciente.esFeliz() });
    }

    method responsables() {
        return pacientes.map({ paciente => paciente.responsable() }).asSet();
    }

    method curarATodos() {
        // Similar al map, con la diferencia de que en lugar de retornar una
        // lista nueva, modifica la original (es decir que tiene efecto). :D
        pacientes.forEach({ paciente => paciente.serCurado() });
    }

}

// TAREA: Modelar a los pacientes

object pepita {

}
object kali {

}

object nano {
  
}



/*
object verdurin {
    var cantidadCajones = 10;
    var pesoCajones = 50;
    var kilometraje = 700000;

    method setCajones(cantidad) {
        cantidadCajones = cantidad;
    }

    method kilosDeCarga() {
        return cantidadCajones*pesoCajones;
    }

    method recorrerKm(kilometros) {
        kilometraje += kilometros;
    }

    method velocidadMaxima() {
        return 80 - self.kilosDeCarga()/500;
    }

}

object pdepCargas {
    var vehiculos = [ verdurin ];
    var gastos = 0;


    method getVehiculos() {
        return vehiculos;
    }
    method gastar(monto) {
      gastos += monto;
    }
}

object rutatlantica {

    method puestoDeControl(empresa) {

        var vehiculos = empresa.getVehiculos();

        var monto = 7000*vehiculos.size();

        vehiculos.forEach(vehiculos.recorrerKm(400)); 

        empresa.gastar(monto);

    }

}
//*/
