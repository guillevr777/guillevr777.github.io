CREATE TABLE Empleados (
    ID INT IDENTITY(1,1) PRIMARY KEY,           -- ID �nico para cada empleado
    Nombre VARCHAR(100) NOT NULL CHECK (Nombre NOT LIKE '%[0-9]%'), -- El nombre no puede contener n�meros
    Apellido VARCHAR(100) NOT NULL CHECK (Apellido NOT LIKE '%[^0-9]%'), -- El apellido solo puede contener n�meros
    Edad INT NOT NULL CHECK (Edad BETWEEN 18 AND 65), -- Edad entre 18 y 65 a�os
    FechaContratacion DATE NOT NULL CHECK (FechaContratacion <= GETDATE()), -- Fecha de contrataci�n no posterior a la fecha actual
    Salario DECIMAL(10, 2) NOT NULL CHECK (Salario BETWEEN 1000 AND 100000 AND Salario % 500 = 0), -- Salario entre 1000 y 100000, m�ltiplo de 500
    Cargo VARCHAR(50) NOT NULL UNIQUE,         -- Un empleado no puede tener m�s de un cargo
    Departamento VARCHAR(50) NOT NULL CHECK (NOT (Departamento = 'General' AND Activo = 0)), -- Departamento no puede ser 'General' si est� inactivo
    FechaNacimiento DATE NOT NULL CHECK (FechaNacimiento < FechaContratacion), -- Fecha de nacimiento anterior a la fecha de contrataci�n
    Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%@%.__%'), -- Validaci�n b�sica de formato de email
    Activo BIT NOT NULL CHECK (Activo = 0 OR Salario IS NOT NULL), -- Salario no puede ser nulo si el empleado est� activo
    FechaSalida DATE NULL CHECK (FechaSalida IS NULL OR FechaSalida >= FechaContratacion), -- Fecha de salida no puede ser anterior a la contrataci�n
    CHECK (DATEDIFF(YEAR, FechaContratacion, GETDATE()) >= 3 OR FechaSalida IS NOT NULL) -- Antig�edad m�nima de 3 a�os o fecha de salida
);