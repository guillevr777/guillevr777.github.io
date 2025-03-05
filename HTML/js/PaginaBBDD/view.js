class TaskView {
  constructor() {
      // Capturar elementos del DOM
      this.nameInput = document.getElementById('Nombre');
      this.lastNameInput = document.getElementById('Apellido');
      this.ageInput = document.getElementById('Edad');
      this.cityInput = document.getElementById('Ciudad');
      this.addTaskButton = document.getElementById('addTaskButton');
      this.taskList = document.getElementById('taskList');
  }

  // Obtener los valores del formulario como un objeto
  getTaskInput() {
      return {
          nombre: this.nameInput.value,
          apellido: this.lastNameInput.value,
          edad: this.ageInput.value,
          ciudad: this.cityInput.value
      };
  }

  // Limpiar los campos del formulario después de añadir una entrada
  clearTaskInput() {
      this.nameInput.value = '';
      this.lastNameInput.value = '';
      this.ageInput.value = '';
      this.cityInput.value = '';
  }

  // Renderizar la tabla con los datos almacenados
  renderTasks(tasks) {
      this.taskList.innerHTML = ''; // Limpiar la tabla antes de renderizar

      tasks.forEach((task, index) => {
        let row = document.createElement("tr"); // Crear un nuevo elemento <tr>
        row.id = `id${index}`; // Asignar el ID dinámicamente
        row.setAttribute("onclick", `deleteRow(${index})`); // Pasar el índice correctamente
    
        row.innerHTML = `
            <td>${task.nombre}</td>
            <td>${task.apellido}</td>
            <td>${task.edad}</td>
            <td>${task.ciudad}</td>
        `;
    
        this.taskList.appendChild(row); // Agregar la fila a la tabla sin sobrescribir el contenido
    });

      // Vincular botones de eliminar
      document.querySelectorAll('.delete-btn').forEach(button => {
          button.addEventListener('click', (event) => {
              const index = event.target.getAttribute('data-index');
              this.onDeleteTask(parseInt(index));
          });
      });
  }

  // Método para enlazar la eliminación
  bindDeleteTask(handler) {
      this.onDeleteTask = handler;
  }

  // Método para enlazar la adición de datos
  bindAddTask(handler) {
      this.addTaskButton.addEventListener('click', handler);
  }
}