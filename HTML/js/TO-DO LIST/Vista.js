class Vista {
    campoNombre   // Input para el nombre de la tarea
    campoDescripcion // Input para la descripción de la tarea
    botonGuardar  // Botón para guardar la tarea
    listaTareas   // Ul para mostrar la lista de tareas

    // Constructor: Inicializa componentes visuales
    constructor() {
        this.campoNombre = new CampoTexto("Nombre de la tarea");
        this.campoDescripcion = new CampoTexto("Descripción de la tarea");
        this.botonGuardar = new Botón("Guardar Tarea");
        this.listaTareas = new Lista();
    }

    // Renderiza datos en la interfaz
    mostrarTarea(tarea) {
        this.campoNombre.setValor(tarea.nombre);
        this.campoDescripcion.setValor(tarea.descripcion);
    }

    mostrarLista(lista) {
        this.listaTareas.mostrar(lista);
    }

    // Notifica al controlador cuando hace clic en "Guardar"
    onGuardar(controlador) {
        this.botonGuardar.onClick(() => {
            const nombre = this.campoNombre.getValor();
            const descripcion = this.campoDescripcion.getValor();
            controlador.guardarTarea({ nombre, descripcion });
        });
    }
}