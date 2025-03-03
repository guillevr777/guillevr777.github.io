class TaskController {
    constructor(model, view) {
        this.model = model;
        this.view = view;

        // Vincular eventos
        this.view.bindAddTask(this.handleAddTask.bind(this));
        this.view.bindDeleteTask(this.handleDeleteTask.bind(this));

        // Mostrar tareas iniciales
        this.updateView();
    }

    // Manejar la adición de una tarea
    handleAddTask() {
        const task = this.view.getTaskInput();
        if (task) {
            this.model.addTask(task);
            this.view.clearTaskInput();
            this.updateView();
        }
    }
 // Manejar la eliminación de una tarea
 handleDeleteTask(index) {
    this.model.deleteTask(index);
    this.updateView();
}

// Actualizar la vista con las tareas actuales
updateView() {
    const tasks = this.model.getTasks();
    this.view.renderTasks(tasks);
    }
}

