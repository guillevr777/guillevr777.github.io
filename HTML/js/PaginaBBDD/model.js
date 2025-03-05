class TaskModel {
    constructor() {
        this.tasks = [];
    }

    // Añadir una nueva entrada con Nombre, Apellido, Edad y Ciudad
    addTask(task) {
        this.tasks.push(task);
    }

    // Obtener todas las entradas
    getTasks() {
        return this.tasks;
    }

    // Eliminar una entrada por índice
    deleteTask(index) {
        this.tasks.splice(index, 1);
    }
}
