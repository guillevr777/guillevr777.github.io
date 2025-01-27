CREATE TABLE Empleados (
    ID INT IDENTITY(1,1) PRIMARY KEY,           -- ID �nico para cada empleado
    Nombre VARCHAR(100) NOT NULL CHECK (Nombre NOT LIKE '%[0-9]%'), -- Nombre sin n�meros
    Apellido VARCHAR(100) NOT NULL CHECK (Apellido NOT LIKE '%[^0-9]%'), -- Apellido solo n�meros
    Edad INT NOT NULL CHECK (Edad BETWEEN 18 AND 65), -- Edad entre 18 y 65
    FechaContratacion DATE NOT NULL CHECK (FechaContratacion <= GETDATE()), -- Fecha contrataci�n no futura
    Salario DECIMAL(10, 2) NOT NULL CHECK (Salario BETWEEN 1000 AND 100000 AND Salario % 500 = 0), -- Salario v�lido
    Cargo VARCHAR(50) NOT NULL,                 -- Cargo del empleado
    Departamento VARCHAR(50) NOT NULL CHECK (NOT (Departamento = 'General' AND Activo = 0)), -- Restricci�n departamento
    FechaNacimiento DATE NOT NULL CHECK (FechaNacimiento < FechaContratacion), -- Fecha nacimiento antes de contrataci�n
    Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%@%.%'), -- Email con @ y .
    Activo BIT NOT NULL,                         -- Estado activo o inactivo del empleado
    FechaSalida DATE NULL CHECK (FechaSalida IS NULL OR FechaSalida >= FechaContratacion), -- Fecha salida v�lida
    CHECK (FechaSalida IS NOT NULL OR DATEDIFF(YEAR, FechaContratacion, GETDATE()) >= 3) -- 3 a�os de antig�edad o salida
);
