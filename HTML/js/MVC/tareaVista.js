class TareaView {
    constructor() {
        this.campoTarea = document.getElementById('campo-tarea');
        this.botonAgregar = document.getElementById('boton-agregar');
        this.tablaTareas = document.querySelector('#tabla-tareas tbody');
    }

    // Método para obtener el valor del input
    obtenerTextoTarea() {
        return this.campoTarea.value;
    }

    // Método para limpiar el input
    limpiarInput() {
        this.campoTarea.value = '';
    }

    // Método para renderizar las tareas en la tabla
    renderizarTareas(tareas) {
        this.tablaTareas.innerHTML = ''; // Limpiar la tabla
        tareas.forEach(tarea => {
            const fila = document.createElement('tr');

            // Columna para el checkbox
            const columnaCheckbox = document.createElement('td');
            const checkbox = document.createElement('input');
            checkbox.type = 'checkbox';
            checkbox.checked = tarea.completada;
            checkbox.addEventListener('change', () => controller.toggleCompletada(tarea.id));
            columnaCheckbox.appendChild(checkbox);
            fila.appendChild(columnaCheckbox);

            // Columna para el texto de la tarea
            const columnaTexto = document.createElement('td');
            columnaTexto.textContent = tarea.texto;
            if (tarea.completada) {
                columnaTexto.classList.add('completada');
            }
            fila.appendChild(columnaTexto);

            // Columna para el botón de eliminar
            const columnaAcciones = document.createElement('td');
            const botonEliminar = document.createElement('button');
            botonEliminar.textContent = 'Eliminar';
            botonEliminar.addEventListener('click', () => controller.eliminarTarea(tarea.id));
            columnaAcciones.appendChild(botonEliminar);
            fila.appendChild(columnaAcciones);

            this.tablaTareas.appendChild(fila);
        });
    }

    // Método para vincular el evento de agregar tarea
    bindAgregarTarea(handler) {
        this.botonAgregar.addEventListener('click', (event) => {
            event.preventDefault();
            handler();
        });
    }
}