class TaskModel {
  constructor() {
      this.tasks = [];
  }

  // Añadir una tarea
  addTask(task) {
      this.tasks.push(task);
  }

  // Obtener todas las tareas
  getTasks() {
      return this.tasks;
  }

  // Eliminar una tarea por su índice
  deleteTask(index) {
      this.tasks.splice(index, 1);
  }
}
