class Modelo {

    lista = []

     crear(tarea) {
        this.validar(tarea);

        // Verificar si ya existe una tarea con el mismo nombre
        const tareaExistente = this.buscarNombre(tarea.nombre);
        if (tareaExistente !== null) {
            throw new Error(`Ya existe una tarea con el nombre "${tarea.nombre}"`);
        }

        this.lista.push(tarea);
    }


    buscarNombre(nombre) {
        const tarea = null;
        for (let i = 0; i < this.lista.length; i++) {
            const tarea = this.lista[i]; 
            if (tarea.nombre === nombre) { 
                return tarea;
            }   
        }
        return null;
    }
    
    buscarIndicePorNombre(nombre) {
        // Usamos findIndex para encontrar el índice de la tarea
        return this.lista.findIndex(t => t.nombre === nombre);
    }

    actualizar(tarea) {
        // Buscamos el índice de la tarea con el nombre que queremos actualizar
        const index = this.buscarIndicePorNombre(nombre);

        // Si no encontramos la tarea, lanzamos un error
        if (index === -1) {
            throw new Error(`No se encontró una tarea con el nombre "${tarea.nombre}"`);
        }

        // Si la encontramos, reemplazamos la tarea existente con la nueva
        this.lista[index] = tarea;
    }
        
    borrar(nombre) {
        // Buscamos el índice de la tarea a borrar
        const index = this.buscarIndicePorNombre(nombre);

        // Si no encontramos la tarea, lanzamos un error
        if (index === -1) {
            throw new Error(`No se encontró una tarea con el nombre "${nombre}"`);
        }

        // Si la encontramos, la eliminamos de la lista
        this.lista.splice(index, 1);
    }
    
    // Validación
    validar(tarea) {
        if (tarea.nombre === "") {
            throw new Error ("Nombre requerido");
        }
    }   

    listar() {
        return this.lista
    }

    vaciar() {
        this.lista = []
    }
}