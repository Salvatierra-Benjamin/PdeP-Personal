import danger_zone.cursadas.*
import danger_zone.estudiantes.*


/*
Tenemos modelados a los cursos de carreras universitarias,
los cuales son capaces de dar tarea a sus estudiantes. 

También pueden decir qué estudiantes están al dia (quienes completarons
todas las tareas vencidas)

*/

/*
Cuando un estudiante recibe una tarea, no la completa inmediatamente. 

Eventualmente un estudiante puede ponerse a estudiar, 
para trabajar sobre alguna de las tareas que tengan pendientes.

La forma de elegir la tarea a realizar no es igual para todos los estudiantes. Ampliaremos...

Ejemplo de uso: 
caro.recibirTarea(tarea1)
caro.recibirTarea(tarea2)
leo.recibirTarea(tarea2)
caro.estudiar()
caro.completo(tarea1)
Falso
caro.completo(tarea2)
True
leo.completo(tarea2)
false
*/


/*
Eleccion de tareas de caro y leo:
Leo elige trabajr sobre la tarea con fecha de entrega más proxima.

Caro elgie trabajr sore la tarea que más tiempo le requiere.

*/

/*
recirbirTarea(tarea), para registrar que tiene una nueva tarea
estudiar(), para que elija una tarea pendiente y trabaje sobre ella
completo(tarea), que indique si completó la tarea indicada

*/




class Estudiante {
    const property tareasPendientes = [] 
    const tareasCompletas = [] // Se desea contemplar aquellas tareas que recibí, las que complete y las que faltan completar
    var property formaDeElegir // !!!! ESTO ES LO QUE PERMITE LA COMPOSICION!!!! 

    method recibirTarea(tarea){ // quiero que tenga efecto
        tareasPendientes.add(tarea)
    }
    method estudiar(){
        const tareaElegida = self.elegirTarea(self.tareasPendientes())
        self.trabajarSobre(tareaElegida)        
    }
    method trabajarSobre(tareaElegida){
        tareasPendientes.remove(tareaElegida)
        tareasCompletas.add(tareaElegida)
    }

    method completo(tarea) = tareasCompletas.contains(tarea)
        
    method elegirTarea(tareas) =  formaDeElegir.elegirTarea(tareas)    
}


// const leo = new Estudiante(formaDeEstudiar = remadora)
const leo = new Estudiante(formaDeElegir = new Priotario(materia = "PdeP"))
const caro = new Estudiante(formaDeElegir = new Prioritaria(materia = "AdS"))


class Priotario {
    var property materia 
    method elegirTarea(tareas) = tareas.FindOrElse({tarea => tarea.materia() == materia}, {tareas.first()})
}

object hijoDelRigor{
    method elegirTarea(tareas) = tareas.min{
        tarea => tarea.proximidadAFechaDeEntrega()
    }
}


object prudente {
    method elegirTarea(tareas) = tareas.max{ tarea =>
        tarea.tiempoEstimado() 
    }
}

class Remadora {
    method elegirTarea(tareas) = tareas.max { tarea => tarea.curso() == estudiante.cursoMasColgado()}
}

/*
Se puede generalizar la lógica y estado común en Estudiantes.

Caro y Leo pueden elegir la tarea a resolver.


Si queremos varios objetos que se comporten de esa forma, elegimos nombres expresivos para definir clases,
    e instanciamos a Caro y Leo a partir de ellas.

*/


////////// Plot twist 


/*
 Nos dimos cuenta que los estudiantes no eligen siempre de la misma forma.

 Queremos hacer que Leo y Caro puedan volverses prudentes/ Hijos del rigor en cualquier momento. 
 
*/


// La herencia tiene el problema que, si un objeto se crea por una clase, ese objeto vive y muere por con esa clase

// Composicion, algo para tener una super clase pero que los objetos puedan cambiar algo, o que actuen diferente
    // en base a algo de la superclase???


// const leo = new Estudiante(formaDelegir = hijoDelrigor) 




/*
Prioritaria: se debe poder indicar a qué materia se le dará prioridad para elegir

Remadora: se elige una tarea del curso que el estudiante tenga más colgado

*/




/*
Herencia:
    - Modelo más simple (una idea - un objeto). 
    - Nos ayuda el method lookup. 
    - Estático: no se puede cambiar la clase de un objeto.
    - Con herencia simple no puedo tener más de un tipo de clasificación, 
        Lleva a repetición exponencial.
    - Se pueden definir métodos para tipos más particulares
*/


/*
Composición:
    - Modelo más completjo (varios objetos para una idea).
    - Hya uqe delegar a mano. 
    - Dinámico: facil de cambiar de compartamiento. 
    - Se puede distribuir la lógica en objetos distinos y combinarlos para 
        múltiples clasificaciones. 
*/