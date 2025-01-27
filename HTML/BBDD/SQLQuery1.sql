CREATE TABLE Empleados (
    ID INT IDENTITY(1,1) PRIMARY KEY,           -- ID único para cada empleado
    Nombre VARCHAR(100) NOT NULL CHECK (Nombre NOT LIKE '%[0-9]%'), -- El nombre no puede contener números
    Apellido VARCHAR(100) NOT NULL CHECK (Apellido NOT LIKE '%[^0-9]%'), -- El apellido solo puede contener números
    Edad INT NOT NULL CHECK (Edad BETWEEN 18 AND 65), -- Edad entre 18 y 65 años
    FechaContratacion DATE NOT NULL CHECK (FechaContratacion <= GETDATE()), -- Fecha de contratación no posterior a la fecha actual
    Salario DECIMAL(10, 2) NOT NULL CHECK (Salario BETWEEN 1000 AND 100000 AND Salario % 500 = 0), -- Salario entre 1000 y 100000, múltiplo de 500
    Cargo VARCHAR(50) NOT NULL UNIQUE,         -- Un empleado no puede tener más de un cargo
    Departamento VARCHAR(50) NOT NULL CHECK (NOT (Departamento = 'General' AND Activo = 0)), -- Departamento no puede ser 'General' si está inactivo
    FechaNacimiento DATE NOT NULL CHECK (FechaNacimiento < FechaContratacion), -- Fecha de nacimiento anterior a la fecha de contratación
    Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%@%.__%'), -- Validación básica de formato de email
    Activo BIT NOT NULL CHECK (Activo = 0 OR Salario IS NOT NULL), -- Salario no puede ser nulo si el empleado está activo
    FechaSalida DATE NULL CHECK (FechaSalida IS NULL OR FechaSalida >= FechaContratacion), -- Fecha de salida no puede ser anterior a la contratación
    CHECK (DATEDIFF(YEAR, FechaContratacion, GETDATE()) >= 3 OR FechaSalida IS NOT NULL) -- Antigüedad mínima de 3 años o fecha de salida
);