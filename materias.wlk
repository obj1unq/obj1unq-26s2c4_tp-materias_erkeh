class Carrera{
   const listaDeMaterias
}

const programacion = new Carrera (listaDeMaterias = [elementosDeProgramacion,
                             matematica1,
                             objetos2,
                             objetos3,
                             trabajoFinal,
                             baseDeDatos])

const medicina = new Carrera (listaDeMaterias = [quimica,
                             biologia,
                             biologia2,
                             anatomiaGeneral])

const derecho = new Carrera (listaDeMaterias = [latin,
                             derechoRomano,
                             historiaDelDerechoArgentino,
                             derechoPenal,
                             derechoPenal2])



    class Materia{
        const nombre
        const carreraALaQuePertenece 
        var listaDeAlumnos = []

        method perteneceALaCarrera(carrera){
        }

        method cumpleConLosRequisitos(estudiante){

    }
}

    class MateriaConCorrelativas inherits Materia{
        const correlativas  
        
        override method cumpleConLosRequisitos(estudiante){
            return correlativas.all({correlativa => estudiante.estaAprobada(correlativa)})
        }
    }

    class MateriaConCreditos inherits Materia{
        const cantidadDeCreditos

        override method cumpleConLosRequisitos(estudiante){
            return estudiante.creditosObtenidos >= cantidadDeCreditos
        }
    }

    class MateriaPorAño inherits Materia{
        const año

        override method cumpleConLosRequisitos(estudiante){
            return estudiante.añoCursando >= año
        }
    }

    class MateriaLibre inherits Materia{

        override method cumpleConLosRequisitos(estudiante){
            return true
        }
    }

    const elementosDeProgramacion = new MateriaLibre (nombre = "Elementos de Programación", carreraALaQuePertenece = programacion, listaDeAlumnos = [])
    const matematica1 = new MateriaLibre (nombre = "Matemática 1", carreraALaQuePertenece = programacion)
    const objetos1 = new MateriaConCorrelativas (nombre = "Objetos 1", carreraALaQuePertenece = programacion,correlativas = [elementosDeProgramacion])
    const objetos2 = new MateriaConCorrelativas (nombre = "Objetos 2", carreraALaQuePertenece = programacion,correlativas = [objetos1, matematica1])
    const objetos3 = new MateriaConCorrelativas (nombre = "Objetos 3", carreraALaQuePertenece = programacion, correlativas = [objetos2])
    const trabajoFinal = new MateriaPorAño (nombre = "Trabajo Final", carreraALaQuePertenece = programacion, año = 3)
    const baseDeDatos = new MateriaConCreditos (nombre = "Base de Datos", carreraALaQuePertenece = programacion, cantidadDeCreditos = 4)

    const quimica = new MateriaLibre (nombre = "Química", carreraALaQuePertenece = medicina)
    const biologia = new MateriaConCorrelativas (nombre = "Biología", carreraALaQuePertenece = medicina,  correlativas = [quimica])
    const biologia2 = new MateriaConCorrelativas (nombre = "Biología 2", carreraALaQuePertenece = medicina, correlativas = [biologia])
    const anatomiaGeneral = new MateriaPorAño (nombre = "Anatomía General", carreraALaQuePertenece = medicina, año = 2)

    const latin = new MateriaLibre (nombre = "Latín", carreraALaQuePertenece = derecho)
    const derechoRomano = new MateriaPorAño (nombre = "Derecho Romano", carreraALaQuePertenece = derecho, año = 2)
    const historiaDelDerechoArgentino = new MateriaLibre (nombre = "Historia del Derecho Argentino", carreraALaQuePertenece = derecho)
    const derechoPenal = new MateriaConCreditos (nombre = "Derecho Penal", carreraALaQuePertenece = derecho, cantidadDeCreditos = 4)
    const derechoPenal2 = new MateriaConCorrelativas (nombre = "Derecho Penal 2", carreraALaQuePertenece = derecho,correlativas = [derechoPenal])

class Estudiante{
    const nombre
    const property carrerasElegidas = []
    var listaDeMateriasAprobadas = []
    var creditosObtenidos = 0
    var añoCursando = 1

    method registrarMateriaAprobada(materia, nota){
        if (self.estaAprobada(materia))
            self.error("La materia ya fue aprobada")    
        
        listaDeMateriasAprobadas.add(new AprobacionDeMateria(materia = materia, nota = nota))
    }
    
    method estaAprobada(materia){
        return listaDeMateriasAprobadas.any({materiaAprobada => materiaAprobada.materia() == materia})
    }

    method materiasAprobadas(){
        return listaDeMateriasAprobadas.map({materiaAprobada => materiaAprobada.materia()})
    }

    method cantidadDeMateriasAprobadas(){
        return listaDeMateriasAprobadas.size()
    }

    method promedioDeNotas(){
        if (self.cantidadDeMateriasAprobadas() == 0)
            return 0
        return listaDeMateriasAprobadas.map({materiaAprobada => materiaAprobada.nota()}).sum() / self.cantidadDeMateriasAprobadas()
    }

    method todasLasMateriasDeLaCarrera(){
        return carrerasElegidas.map({carrera => carrera.listaDeMaterias()}).flatten()
    }

    method perteneceALaCarrera(materiaAComparar){
        if (!materiaAComparar.perteneceALaCarrera(carrerasElegidas))
            self.error("La materia no pertenece a ninguna de las carreras elegidas")
    }


    method estaCursandoMateria(materiaACursar){
        if (materiaACursar.listaDeAlumnos().any({alumno => alumno == self}))
            self.error("El estudiante ya está cursando la materia")
    }

    method puedeCursarMateria(materiaACursar){
        self.perteneceALaCarrera(materiaACursar)
        !self.estaAprobada(materiaACursar)
        self.estaCursandoMateria(materiaACursar)
        materiaACursar.cumpleConLosRequisitos(self)
    }


}



const roque = new Estudiante (nombre = "Roque", carrerasElegidas = [programacion], listaDeMateriasAprobadas = [])   

class AprobacionDeMateria{
    const property materia
    const property nota
}

