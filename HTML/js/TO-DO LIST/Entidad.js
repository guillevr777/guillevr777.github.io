class Entidad {

    // Atributos
    nombre
    descripcion
    estado

    // Constructor (opcional)
    constructor(nombre, descripcion, estado) {
        this.nombre = nombre
        this.descripcion = descripcion
        this.estado = estado
    }

    // Getters/Setters
    getNombre() {
        return this.nombre
    }

    getDescripcion() {
        return this.descripcion
    }

    getEstado() {
        return this.estado
    }

    setNombre(nombre) {
        this.nombre = nombre
    }

    setDescripcion(descripcion) {
        this.descripcion = descripcion
    }

    setEstado(estado) {
        this.estado = estado
    }
}