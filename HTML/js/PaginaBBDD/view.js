class TaskView {
  constructor() {
      this.taskInput = document.getElementById('taskInput');
      this.addTaskButton = document.getElementById('addTaskButton');
      this.taskList = document.getElementById('Nombre');
  }

  // Mostrar la lista de tareas
  renderTasks(tasks) {
      this.taskList.innerHTML = '';
      const table = document.createElement('table');
      tasks.forEach((task, index) => {
          const row = document.createElement('tr');
          const cell = document.createElement('td');
          cell.textContent = task;
          const deleteButton = document.createElement('button');
          deleteButton.textContent = 'Eliminar';
          deleteButton.addEventListener('click', () => {
              this.onDeleteTask(index);
          });
          const deleteCell = document.createElement('td');
          deleteCell.appendChild(deleteButton);
          row.appendChild(cell);
          row.appendChild(deleteCell);
          table.appendChild(row);
      });
      this.taskList.appendChild(table);
  }

  // Obtener la tarea del input
  getTaskInput() {
    return this.taskInput.value;
  }

  // Limpiar el input
  clearTaskInput() {
    this.taskInput.value = '';
  }

  // Método para manejar el evento de eliminar tarea
  bindDeleteTask(handler) {
    this.onDeleteTask = handler;
  }

  // Método para manejar el evento de añadir tarea
  bindAddTask(handler) {
    this.addTaskButton.addEventListener('click', handler);
  }
}
