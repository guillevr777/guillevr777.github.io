class TareaController {

    // Dependencias
    modeloTarea
    vistaTarea

    constructor(modelo, vista) {
        this.modeloTarea = modelo;
        this.vistaTarea = vista;
    }

    // Acción: Crear tarea
    crear(tarea) {
        try {
            const tareaOk = this.validarDatos(tarea);
            const nuevaTarea = this.modeloTarea.crear(tareaOk);
            this.vistaTarea.mostrarExito("Tarea creada");
        } catch (error) {
            this.vistaTarea.mostrarError(error.message);
        }
    }

    // Acción: Obtener lista de tareas
    listar() {
        const tareas = this.modeloTarea.listarTodas();
        this.vistaTarea.renderizarLista(tareas);
    }

    // Validación de entrada
    validarDatos(tarea) {
        if (tarea.getNombre() === "") {
            throw new Error("El nombre de la tarea es inválido");
        }
        return tarea;
    }
}

