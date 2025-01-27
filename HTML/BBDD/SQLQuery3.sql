CREATE TABLE Empleados (
    ID INT IDENTITY(1,1) PRIMARY KEY,           -- ID único para cada empleado
    Nombre VARCHAR(100) NOT NULL CHECK (Nombre NOT LIKE '%[0-9]%'), -- Nombre sin números
    Apellido VARCHAR(100) NOT NULL CHECK (Apellido NOT LIKE '%[^0-9]%'), -- Apellido solo números
    Edad INT NOT NULL CHECK (Edad BETWEEN 18 AND 65), -- Edad entre 18 y 65
    FechaContratacion DATE NOT NULL CHECK (FechaContratacion <= GETDATE()), -- Fecha contratación no futura
    Salario DECIMAL(10, 2) NOT NULL CHECK (Salario BETWEEN 1000 AND 100000 AND Salario % 500 = 0), -- Salario válido
    Cargo VARCHAR(50) NOT NULL,                 -- Cargo del empleado
    Departamento VARCHAR(50) NOT NULL CHECK (NOT (Departamento = 'General' AND Activo = 0)), -- Restricción departamento
    FechaNacimiento DATE NOT NULL CHECK (FechaNacimiento < FechaContratacion), -- Fecha nacimiento antes de contratación
    Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%@%.%'), -- Email con @ y .
    Activo BIT NOT NULL,                         -- Estado activo o inactivo del empleado
    FechaSalida DATE NULL CHECK (FechaSalida IS NULL OR FechaSalida >= FechaContratacion), -- Fecha salida válida
    CHECK (FechaSalida IS NOT NULL OR DATEDIFF(YEAR, FechaContratacion, GETDATE()) >= 3) -- 3 años de antigüedad o salida
);
