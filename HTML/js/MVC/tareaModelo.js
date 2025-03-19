class TareaModel {
    constructor() {
        this.tareas = []; // Array que simula una base de datos
    }

    // Método para agregar una tarea
    agregarTarea(texto) {
        const nuevaTarea = {
            id: Date.now(), // ID único basado en la fecha actual
            texto: texto,
            completada: false
        };
        this.tareas.push(nuevaTarea); // Agrega la tarea al array
    }

    // Método para eliminar una tarea por su ID
    eliminarTarea(id) {
        this.tareas = this.tareas.filter(tarea => tarea.id !== id);
    }

    // Método para obtener todas las tareas
    obtenerTareas() {
        return this.tareas;
    }
}