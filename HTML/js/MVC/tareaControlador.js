class TareaController {
    constructor() {
        this.modelo = new TareaModel(); // Inicializa el modelo
        this.vista = new TareaView();  // Inicializa la vista

        // Vincular eventos
        this.vista.bindAgregarTarea(this.agregarTarea.bind(this));
        this.actualizarVista();
    }

    // Método para agregar una tarea
    agregarTarea() {
        const texto = this.vista.obtenerTextoTarea();
        if (texto) {
            this.modelo.agregarTarea(texto);
            this.vista.limpiarInput();
            this.actualizarVista();
        }
    }

    // Método para eliminar una tarea
    eliminarTarea(id) {
        this.modelo.eliminarTarea(id);
        this.actualizarVista();
    }

    // Método para marcar una tarea como completada o no completada
    toggleCompletada(id) {
        this.modelo.toggleCompletada(id);
        this.actualizarVista();
    }

    // Método para actualizar la vista
    actualizarVista() {
        const tareas = this.modelo.obtenerTareas();
        this.vista.renderizarTareas(tareas);
    }
}