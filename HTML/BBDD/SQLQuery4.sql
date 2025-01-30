		DROP DATABASE IF EXISTS Agenda;
		CREATE DATABASE Agenda;
		USE Agenda;

		DROP DATABASE Agenda;

		CREATE TABLE  Contactos (
		  nombre varchar(25),
		  dni varchar(9),
		  PRIMARY KEY (dni)
		)

		CREATE TABLE  Telefonos (
		  id INT Identity,
		  numero varchar(9),
		  dni varchar(9),
		   PRIMARY KEY(id),
		   FOREIGN KEY(dni) REFERENCES Contactos(dni) 
		   ON DELETE SET NULL
		   ON UPDATE SET NULL
		)

		INSERT INTO Contactos values('Ana', '111');
		INSERT INTO Contactos values('Pepe', '222');
		INSERT INTO Contactos values('Juan', '333');

		INSERT INTO Telefonos (numero, dni) values ('1111', '111');
		INSERT INTO Telefonos (numero, dni) values ('2222', '111');
		INSERT INTO Telefonos (numero, dni) values ('3333', '111');
		INSERT INTO Telefonos (numero, dni) values ('4444', '222');
		INSERT INTO Telefonos (numero, dni) values ('5555', '222');
		INSERT INTO Telefonos (numero, dni) values ('5555', '333');

-----------------------------------------------------------------

			CREATE DATABASE Escuela

			USE Escuela

			CREATE TABLE Profesores (
			DNI CHAR(9) PRIMARY KEY,
			Nombre VARCHAR(50)
		)

		CREATE TABLE Alumnos (
			DNI CHAR(9) PRIMARY KEY,
			Nombre VARCHAR(50)
		)

		CREATE TABLE Asignaturas (
			Codigo CHAR(10) PRIMARY KEY,
			Nombre VARCHAR(50),
			HorasSemanales INT,
			DNI_Profesor CHAR(9),
			CONSTRAINT FK_Asignaturas_Profesor FOREIGN KEY (DNI_Profesor) 
			REFERENCES Profesores(DNI) ON DELETE SET NULL
		)

		CREATE TABLE Matricula (
			ID decimal(2) PRIMARY KEY,
			DNI_Alumno CHAR(9),
			Codigo_Asignatura CHAR(10),
			Nota DECIMAL(4, 2),
			CONSTRAINT FK_Matricula_Alumno FOREIGN KEY (DNI_Alumno) 
				REFERENCES Alumnos(DNI) ON DELETE CASCADE,
			CONSTRAINT FK_Matricula_Asignatura FOREIGN KEY (Codigo_Asignatura) 
				REFERENCES Asignaturas(Codigo) ON DELETE CASCADE
		)

		INSERT INTO Profesores (DNI, Nombre) VALUES ('123456789', 'Profesor A');
		INSERT INTO Profesores (DNI, Nombre) VALUES ('987654321', 'Profesor B');

		INSERT INTO Alumnos (DNI, Nombre) VALUES ('111111111', 'Alumno 1');
		INSERT INTO Alumnos (DNI, Nombre) VALUES ('222222222', 'Alumno 2');

		INSERT INTO Asignaturas (Codigo, Nombre, HorasSemanales, DNI_Profesor) 
		VALUES ('MAT001', 'Matemáticas', 5, '123456789');
		INSERT INTO Asignaturas (Codigo, Nombre, HorasSemanales, DNI_Profesor) 
		VALUES ('FIS001', 'Física', 4, '987654321');

		INSERT INTO Matricula (DNI_Alumno, Codigo_Asignatura, Nota) 
		VALUES ('111111111', 'MAT001', 8.5);
		INSERT INTO Matricula (DNI_Alumno, Codigo_Asignatura, Nota) 
		VALUES ('222222222', 'FIS001', 7.2);

		DELETE FROM Alumnos WHERE DNI = '111111111';
		DELETE FROM Profesores WHERE DNI = '123456789';
		DELETE FROM Asignaturas WHERE Codigo = 'FIS001';
		UPDATE Asignaturas SET Codigo = 'MAT002' WHERE Codigo = 'MAT001';
		UPDATE Alumnos SET DNI = '333333333' WHERE DNI = '222222222';

-----------------------------------------------------------------


		CREATE DATABASE Libreria
		USE Libreria

		CREATE TABLE Editorial (
			Nombre VARCHAR(100) PRIMARY KEY,
			Telefono CHAR(9)
		)

		CREATE TABLE Autor (
			Nombre VARCHAR(100) PRIMARY KEY,
			AñoNacimiento date
		)

		CREATE TABLE Libro (
			ISBN CHAR(13) PRIMARY KEY,
			Titulo VARCHAR(200),
			Editorial VARCHAR(100),
			Autor VARCHAR(100),
			CONSTRAINT FK_Libro_Editorial FOREIGN KEY (Editorial) 
				REFERENCES Editorial(Nombre) ON DELETE CASCADE ON UPDATE CASCADE,
			CONSTRAINT FK_Libro_Autor FOREIGN KEY (Autor) 
				REFERENCES Autor(Nombre) ON DELETE SET NULL ON UPDATE CASCADE
		)

		CREATE TABLE Stock (
			ISBN CHAR(13) PRIMARY KEY,
			Cantidad INT,
			CONSTRAINT FK_Stock_Libro FOREIGN KEY (ISBN) 
				REFERENCES Libro(ISBN) ON DELETE RESTRICT ON UPDATE CASCADE
		)


		INSERT INTO Editorial (Nombre, Telefono) VALUES ('Planeta', '911223344');
		INSERT INTO Editorial (Nombre, Telefono) VALUES ('Alfaguara', '912334455');

		INSERT INTO Autor (Nombre, AñoNacimiento) VALUES ('Gabriel García Márquez', 1927);
		INSERT INTO Autor (Nombre, AñoNacimiento) VALUES ('Isabel Allende', 1942);

		INSERT INTO Libro (ISBN, Titulo, Editorial, Autor) 
		VALUES ('9780439139601', 'Cien años de soledad', 'Planeta', 'Gabriel García Márquez');
		INSERT INTO Libro (ISBN, Titulo, Editorial, Autor) 
		VALUES ('9780060883287', 'La casa de los espíritus', 'Alfaguara', 'Isabel Allende');

		INSERT INTO Stock (ISBN, Cantidad) VALUES ('9780439139601', 10);
		INSERT INTO Stock (ISBN, Cantidad) VALUES ('9780060883287', 5);


		CREATE DATABASE Universidad;
		USE Universidad;

		CREATE TABLE Facultad (
			IDFacultad INT PRIMARY KEY AUTO_INCREMENT,
			Nombre VARCHAR(100)
		)

		CREATE TABLE Departamento (
			IDDepartamento INT PRIMARY KEY AUTO_INCREMENT,
			Nombre VARCHAR(100),
			IDFacultad INT,
			CONSTRAINT FK_Departamento_Facultad FOREIGN KEY (IDFacultad) 
				REFERENCES Facultad(IDFacultad) ON DELETE CASCADE
		)

		CREATE TABLE Profesor (
			IDProfesor INT PRIMARY KEY AUTO_INCREMENT,
			Nombre VARCHAR(100),
			IDDepartamento INT,
			CONSTRAINT FK_Profesor_Departamento FOREIGN KEY (IDDepartamento) 
				REFERENCES Departamento(IDDepartamento) ON DELETE CASCADE
		)

		INSERT INTO Facultad (Nombre) VALUES ('Ingeniería');
		INSERT INTO Facultad (Nombre) VALUES ('Ciencias Sociales');

		INSERT INTO Departamento (Nombre, IDFacultad) VALUES ('Informática', 1);
		INSERT INTO Departamento (Nombre, IDFacultad) VALUES ('Civil', 1);
		INSERT INTO Departamento (Nombre, IDFacultad) VALUES ('Psicología', 2);

		INSERT INTO Profesor (Nombre, IDDepartamento) VALUES ('Juan Pérez', 1);
		INSERT INTO Profesor (Nombre, IDDepartamento) VALUES ('Ana Gómez', 1);
		INSERT INTO Profesor (Nombre, IDDepartamento) VALUES ('Luis Martínez', 2);
		INSERT INTO Profesor (Nombre, IDDepartamento) VALUES ('Carla Fernández', 3);

		DELETE FROM Facultad WHERE IDFacultad = 1;
		DELETE FROM Departamento WHERE IDDepartamento = 3;
		SELECT * FROM Facultad;
		SELECT * FROM Departamento;
		SELECT * FROM Profesor;



		CREATE DATABASE Tienda;
		USE Tienda;

		CREATE TABLE Cliente (
			IDCliente INT PRIMARY KEY AUTO_INCREMENT,
			Nombre VARCHAR(100),
			Email VARCHAR(100)
		)

		CREATE TABLE Pedido (
			IDPedido INT PRIMARY KEY AUTO_INCREMENT,
			Fecha DATE,
			IDCliente INT,
			CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (IDCliente) 
				REFERENCES Cliente(IDCliente) ON DELETE CASCADE
		)

		CREATE TABLE DetallePedido (
			IDDetalle INT PRIMARY KEY AUTO_INCREMENT,
			IDPedido INT,
			Producto VARCHAR(100),
			Cantidad INT,
			Precio DECIMAL(10, 2),
			CONSTRAINT FK_Detalle_Pedido FOREIGN KEY (IDPedido) 
				REFERENCES Pedido(IDPedido) ON DELETE CASCADE
		)


		INSERT INTO Cliente (Nombre, Email) VALUES ('Juan Pérez', 'juan@example.com');
		INSERT INTO Cliente (Nombre, Email) VALUES ('Ana López', 'ana@example.com');

		INSERT INTO Pedido (Fecha, IDCliente) VALUES ('2025-01-01', 1);
		INSERT INTO Pedido (Fecha, IDCliente) VALUES ('2025-01-02', 1);
		INSERT INTO Pedido (Fecha, IDCliente) VALUES ('2025-01-03', 2);

		INSERT INTO DetallePedido (IDPedido, Producto, Cantidad, Precio) VALUES (1, 'Lápiz', 10, 0.50);
		INSERT INTO DetallePedido (IDPedido, Producto, Cantidad, Precio) VALUES (1, 'Cuaderno', 5, 1.50);
		INSERT INTO DetallePedido (IDPedido, Producto, Cantidad, Precio) VALUES (2, 'Bolígrafo', 3, 0.75);
		INSERT INTO DetallePedido (IDPedido, Producto, Cantidad, Precio) VALUES (3, 'Regla', 2, 1.20);

		DELETE FROM Cliente WHERE IDCliente = 1;
		DELETE FROM Pedido WHERE IDPedido = 3;
		SELECT * FROM Cliente;
		SELECT * FROM Pedido;
		SELECT * FROM DetallePedido;
