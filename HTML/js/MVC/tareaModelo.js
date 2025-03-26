class TareaModel {
    constructor() {
        this.tareas = []; // Array que simula una base de datos
    }

    // Método para agregar una tarea
    agregarTarea(texto) {
        const nuevaTarea = {
            id: Date.now(), // ID único basado en la fecha actual
            texto: texto,
            completada: false // Estado inicial de la tarea
        };
        this.tareas.push(nuevaTarea); // Agrega la tarea al array
    }

    // Método para eliminar una tarea por su ID
    eliminarTarea(id) {
        this.tareas = this.tareas.filter(tarea => tarea.id !== id);
    }

    // Método para marcar una tarea como completada o no completada
    toggleCompletada(id) {
        this.tareas = this.tareas.map(tarea => {
            if (tarea.id === id) {
                return { ...tarea, completada: !tarea.completada };
            }
            return tarea;
        });
    }

    // Método para obtener todas las tareas
    obtenerTareas() {
        return this.tareas;
    }
}