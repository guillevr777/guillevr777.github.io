class TaskController {
    constructor(model, view) {
        this.model = model;
        this.view = view;

        // Enlazar eventos de la vista
        this.view.bindAddTask(this.handleAddTask.bind(this));
        this.view.bindDeleteTask(this.handleDeleteTask.bind(this));

        // Cargar la vista inicial
        this.updateView();
    }

    // Manejar la adición de una nueva entrada
    handleAddTask() {
        const task = this.view.getTaskInput();
        
        // Validar que los campos no estén vacíos
        if (task.nombre && task.apellido && task.edad && task.ciudad) {
            this.model.addTask(task);
            this.view.clearTaskInput();
            this.updateView();
        } else {
            alert('Por favor, complete todos los campos.');
        }
    }

    // Manejar la eliminación de una entrada
    handleDeleteTask(index) {
        this.model.deleteTask(index);
        this.updateView();
    }

    // Actualizar la vista con los datos actuales
    updateView() {
        const tasks = this.model.getTasks();
        this.view.renderTasks(tasks);
    }
}