-- Creación de la base de datos
CREATE DATABASE INTRANT;
USE INTRANT;

-- Creación de tablas, definición de atributos y declaración de PK y FK

CREATE TABLE SOLICITANTES (
 cedulaID VARCHAR(20) PRIMARY KEY,
 Nombre VARCHAR(20),
 Apellido VARCHAR(20),
 Fecha_nacimiento DATE,
 Edad INT,
 Sexo CHAR(1),
 Direccion VARCHAR(100),
);

--Nueva tabla agregada
CREATE TABLE Pagos_SOLICITUDES_LICENCIAS (
 SolicitudLicenciaID INT PRIMARY KEY IDENTITY (1,1),
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 Categoria VARCHAR(20), -- Categoría de la licencia 
 Costo DECIMAL(10, 2) 
);


CREATE TABLE SOLICITANTES_CONTACTO (
 ContactoID INT PRIMARY KEY IDENTITY (1,1),
 cedulaID VARCHAR(20),

 FOREIGN KEY (cedulaID) REFERENCES SOLICITANTES (cedulaID),
 Telefono VARCHAR(15),
 Correo_Electronico VARCHAR(40)
);

CREATE TABLE LICENCIAS (
 LicenciaID varchar (200) primary key,
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 Categoria VARCHAR(100),
 Estatura DECIMAL(5, 2),
 Peso DECIMAL(5, 2),
 Tipo_sangre VARCHAR(2),
 Fecha_emision DATE,
 Fecha_expiracion DATE,
);

CREATE TABLE EXAMENES (
 ExamenID INT PRIMARY KEY IDENTITY,
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 Fecha_examen DATE,
 Tipo_examen VARCHAR(20),
 Resultado VARCHAR(20)
);

--Nueva tabla agregada
CREATE TABLE CARNETS_APRENDIZAJE (
 CarnetID INT PRIMARY KEY IDENTITY,
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 Fecha_emision DATE,
 Categoria_edad VARCHAR(20)
);

CREATE TABLE PERMISOS (
 PermisoID INT PRIMARY KEY IDENTITY,
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 Tipo_permiso VARCHAR(50),
 Fecha_emision DATE,
 Fecha_expiracion DATE
);

CREATE TABLE CERTIFICACIONES (
 CertificadoID INT PRIMARY KEY IDENTITY (1,1),
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 Tipo_certificado VARCHAR(300),
 Fecha_emision DATE
);

CREATE TABLE EMPLEADOS (
 EmpleadoID INT PRIMARY KEY IDENTITY (1,1),
 Nombre VARCHAR(20),
 Apellido VARCHAR(20),
 Puesto VARCHAR(40),
 Salario DECIMAL(10, 2)
);

CREATE TABLE CONTACTO_EMPLEADO (
 ContactoID INT PRIMARY KEY IDENTITY (1,1),
 EmpleadoID INT,
 FOREIGN KEY (EmpleadoID) REFERENCES EMPLEADOS (EmpleadoID),
 Telefono VARCHAR(15),
 Correo_Electronico VARCHAR(40)
);

--Nueva tabla agregada
CREATE TABLE DIVISIONES (
DivisionID INT PRIMARY KEY IDENTITY (1,1),
Division VARCHAR(20)
);

-- Agregar la columna DivisionID y la llave foranea a la tabla Empleados
ALTER TABLE EMPLEADOS
ADD DivisionID INT;

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_DIVISIONES_EMPLEADOS FOREIGN KEY (DivisionID)
REFERENCES DIVISIONES(DivisionID);


CREATE TABLE INFRACCION (
 Infraccion INT PRIMARY KEY IDENTITY,
 LicenciaID varchar(200),
 FOREIGN KEY (LicenciaID) REFERENCES LICENCIAS (LicenciaID),
 Fecha_Infraccion DATETIME,
 Lugar_Infraccion VARCHAR(70),
 Tipo_Infraccion VARCHAR(40),
 Descripcion_Infraccion VARCHAR(60),
 Monto_Infraccion INT
);

CREATE TABLE DOCUMENTO_EMITIDO (
 DocumentoID INT PRIMARY KEY IDENTITY (1,1),
 CedulaID VARCHAR(20),
 FOREIGN KEY (CedulaID) REFERENCES SOLICITANTES (cedulaID),
 PermisoID INT,
 FOREIGN KEY (PermisoID) REFERENCES PERMISOS (PermisoID),
 CertificadoID INT,
 FOREIGN KEY (CertificadoID) REFERENCES CERTIFICACIONES (CertificadoID),
 EmpleadoID INT,
 FOREIGN KEY (EmpleadoID) REFERENCES EMPLEADOS (EmpleadoID),
 Fecha_Emision DATE,
 Fecha_Expiracion DATE,
 Estado_Documento VARCHAR(20)
);



-- Insertar registros en la tabla SOLICITANTES 
INSERT INTO SOLICITANTES (cedulaID, Nombre, Apellido, Fecha_nacimiento, Edad, Sexo, Direccion)
VALUES
  ('001-4533795-7', 'Juan', 'Pérez', '1990-01-15', 32, 'M', 'Calle Arístides Fiallo Cabral #32, Los Prados'),
  ('402-3164748-4', 'Ana', 'Gómez', '1998-05-20', 25, 'F', 'Calle José Contreras #78, Villa Juana'),
  ('001-6647965-2', 'Carlos', 'Rodríguez', '1988-09-10', 33, 'M', 'Carretera Mella #15, San Cristóbal'),
  ('402-3425118-5', 'María', 'López', '2000-03-05', 23, 'F', 'Calle Máximo Gómez #56, Gazcue'),
  ('402-3377742-8', 'Santiago', 'Santos', '2002-11-18', 21, 'M', 'Calle Juan Alejandro Ibarra #23, Zona Colonial'),
  ('001-1102730-6', 'Laura', 'Martínez', '1987-07-25', 36, 'F', 'Avenida Independencia #345, Ciudad Nueva'),
  ('402-3277529-3', 'José', 'Ramírez', '2006-02-25', 17, 'M', 'Carretera Mella #15, San Cristóbal');


 
-- Insertar registros en la tabla Pagos_SOLICITUDES_LICENCIAS
INSERT INTO Pagos_SOLICITUDES_LICENCIAS (CedulaID, Categoria, Costo)
VALUES
  ('001-4533795-7', '1', 2900.00),
  ('402-3164748-4', '2', 2900.00),
  ('001-6647965-2', '3', 2900.00),
  ('402-3425118-5', '1', 2900.00),
  ('402-3377742-8', '2', 2900.00),
  ('001-1102730-6', '2', 2900.00),
  ('402-3277529-3', '3', 2900.00);

-- Insertar registros en la tabla SOLICITANTES_CONTACTO
INSERT INTO SOLICITANTES_CONTACTO (cedulaID, Telefono, Correo_Electronico)
VALUES
  ('001-4533795-7', '809-123-4567', 'juan.perez@hotmail.com'),
  ('402-3164748-4', '829-987-6543', 'ana.gomez@gmail.com'),
  ('001-6647965-2', '809-567-8901', 'carlos.rodriguez@gmail.com'),
  ('402-3425118-5', '829-555-3333', 'maria.lopez@gmail.com'),
  ('402-3377742-8', '809-777-8888', 'S.santos@gmail.com'),
  ('001-1102730-6', '829-111-2222', 'laura.martinez@hotmail.com'),
  ('402-3277529-3', '809-657-3758', 'JoseR@gmail.com');

 -- Insertar registros  en la tabla LICENCIAS
INSERT INTO LICENCIAS (LicenciaID, CedulaID, Categoria, Estatura, Peso, Tipo_sangre, Fecha_emision, Fecha_expiracion)
VALUES
  ('00116840232','001-4533795-7', '1', 1.75, 70.5, 'A+', '2023-01-15', '2023-12-31'),
  ('00239401840','402-3164748-4', '2', 1.68, 65.2, 'O-', '2023-02-20', '2023-11-30'),
  ('02304918162','001-6647965-2', '3', 1.80, 80.0, 'B+', '2023-03-10', '2023-10-15'),
  ('00102948501','402-3425118-5', '1', 1.72, 68.8, 'A-', '2023-04-05', '2023-09-30'),
  ('88491002039','402-3377742-8', '2', 1.76, 72.3, 'O+', '2023-05-12', '2023-08-31'),
  ('01817489202','001-1102730-6', '2', 1.78, 77.0, 'A-', '2023-06-25', '2023-12-15'),
  ('01727489503','402-3277529-3', '3', 1.82, 76.0, 'B+', '2023-06-25', '2023-12-15');

-- Insertar registros en la tabla EXAMENES
INSERT INTO EXAMENES (CedulaID, Fecha_examen, Tipo_examen, Resultado)
VALUES
  ('001-4533795-7', '2023-01-10', 'Examen Teórico', '72'),
  ('402-3164748-4', '2023-02-15', 'Examen Práctico', '83'),
  ('001-6647965-2', '2023-03-20', 'Examen Teórico', '88'),
  ('402-3425118-5', '2023-04-25', 'Examen Práctico', '91'),
  ('402-3377742-8', '2023-05-30', 'Examen Teórico', '73'),
  ('001-1102730-6', '2023-06-05', 'Examen Teórico', '55'),
  ('402-3277529-3', '2023-01-10', 'Examen Teórico', '92');

-- Insertar registros en la tabla CARNETS_APRENDIZAJE
INSERT INTO CARNETS_APRENDIZAJE (CedulaID, Fecha_emision, Categoria_edad)
VALUES
  ('001-4533795-7', '2023-01-05', 'Mayores de edad'),
  ('402-3164748-4', '2023-02-10', 'Mayores de edad'),
  ('001-6647965-2', '2023-03-15', 'Mayores de edad'),
  ('402-3425118-5', '2023-04-20', 'Mayores de edad'),
  ('402-3377742-8', '2023-05-25', 'Mayores de edad'),
  ('402-3277529-3' , '2023-06-15','Menores de edad');

-- Insertar registros en la tabla PERMISOS
INSERT INTO PERMISOS (CedulaID, Tipo_permiso, Fecha_emision, Fecha_expiracion)
VALUES
  ('001-4533795-7', 'Carnet de aprendizaje Mayores de 18 Años', '2023-01-05', '2024-01-15'),
  ('402-3164748-4', 'Carnet de aprendizaje Mayores de 18 Años', '2023-02-10', '2024-02-20'),
  ('001-6647965-2', 'Carnet de aprendizaje Mayores de 18 Años', '2023-03-15', '2024-03-10'),
  ('402-3425118-5', 'Carnet de aprendizaje Mayores de 18 Años', '2023-04-20', '2024-04-25'),
  ('402-3377742-8', 'Carnet de aprendizaje Mayores de 18 Años', '2023-05-25', '2024-05-15'),
  ('402-3277529-3', 'Carnet de aprendizaje Menores de 18 Años', '2023-06-15', '2024-06-15');
  
-- Insertar registros en la tabla CERTIFICACIONES (arreglar)
INSERT INTO CERTIFICACIONES (CedulaID, Tipo_certificado, Fecha_emision)
VALUES
  ('001-4533795-7', 'Certificación Para Realizar Estudios De Impacto De Tráfico A Empresas E Ingenieros Individuales', '2023-01-15'),
  ('402-3425118-5', 'Certificación Para Optar Por La Obtención De Placas A Remolques, Semiremolques Y Buggys', '2023-04-05'),
  ('402-3425118-5', 'Certificación Para Realizar Estudios De Impacto De Tráfico A Empresas E Ingenieros Individuales', '2023-05-12');

 
-- Insertar registros en la tabla EMPLEADOS
INSERT INTO EMPLEADOS (Nombre, Apellido, Puesto, Salario)
VALUES
  ('Juan', 'Pérez', 'Asistente Administrativo', 27500.00),
  ('Ana', 'Gómez', 'Coordinador de Licencias', 38000.00),
  ('Carlos', 'Rodríguez', 'Técnico en Seguridad Vial', 34000.00),
  ('María', 'López', 'Evaluador de Exámenes', 25000.00),
  ('Pedro', 'Santos', 'Asesor Legal', 44320.00),
  ('Laura', 'Martínez', 'Supervisor de Operaciones', 48000.00),
  ('Luis', 'Ramírez', 'Gerente de Recursos Humanos', 56800.00);


-- Insertar registros  en la tabla CONTACTO_EMPLEADO
INSERT INTO CONTACTO_EMPLEADO (EmpleadoID, Telefono, Correo_Electronico)
VALUES
  (1, '809-123-4567', 'juan.perez@gmail.com'),
  (2, '829-987-6543', 'ana.gomez@gmail.com'),
  (3, '809-567-8901', 'carlos.rodriguez@hotmail.com'),
  (4, '829-555-3333', 'maria.lopez@hotmail.com'),
  (5, '809-777-8888', 'pedro.santos@gmail.com'),
  (6, '829-111-2222', 'laura.martinez@gmail.com'),
  (7, '809-444-5555', 'luis.ramirez@gmail.com');

 --Insertar datos en la tabla divisiones
 INSERT INTO DIVISIONES (Division) VALUES ('Licencias'),('Permisos'),('Certificaciones');

  --Insertar divisiones en las que trabajan los empleados
  UPDATE EMPLEADOS
  SET DivisionID = 1
  WHERE Nombre IN ('Ana', 'Carlos', 'Laura');

  UPDATE EMPLEADOS
  SET DivisionID = 2
  WHERE Nombre IN ('Luis', 'Pedro');
 
  UPDATE EMPLEADOS
  SET DivisionID = 3
  WHERE Nombre IN ( 'María','Juan');

-- Insertar registros en la tabla INFRACCION (arreglar)
INSERT INTO INFRACCION (LicenciaID, Fecha_Infraccion, Lugar_Infraccion, Tipo_Infraccion, Descripcion_Infraccion, Monto_Infraccion)
VALUES
  ( '00116840232', '2023-01-05 08:30:00', 'Avenida Principal', 'Exceso de velocidad', 'Velocidad 10 km/h por encima del límite', 1000),
  ('02304918162', '2023-02-10 14:15:00', 'Calle 3', 'Estacionamiento ilegal', 'Estacionado en zona prohibida', 800),
  ('88491002039', '2023-03-15 10:45:00', 'Autopista Norte', 'Semáforo en rojo', 'No respetó el semáforo en rojo', 2000),
  ('00102948501', '2023-04-20 12:00:00', 'Calle Principal', 'Exceso de velocidad', 'Velocidad 20 km/h por encima del límite', 1500);


-- Insertar registros  en la tabla DOCUMENTO_EMITIDO (arreglar)
INSERT INTO DOCUMENTO_EMITIDO (CedulaID, PermisoID, CertificadoID, EmpleadoID, Fecha_Emision, Fecha_Expiracion, Estado_Documento)
VALUES
  ('001-4533795-7', 1, 1, 4, '2023-01-15', '2023-02-15', 'Válido'),
  ('402-3164748-4', 2, NULL, 3, '2023-02-20', '2023-03-20', 'Válido'),
  ('001-6647965-2', 3, NULL, 2, '2023-03-25', '2023-04-25', 'Válido'),
  ('402-3425118-5', 4, 2, 4, '2023-04-30', '2023-05-30', 'Válido'),
  ('402-3377742-8', 5, NULL, 1, '2023-05-05', '2023-06-05', 'Válido'),
  ('001-1102730-6', NULL, NULL, 5, '2023-06-10', '2023-07-10', 'Inválido');


  select * from CERTIFICACIONES
  select * from SOLICITANTES 
  select * from LICENCIAS


--Consulta 1
SELECT cedulaID, Nombre
FROM SOLICITANTES;

--Consulta 2
SELECT *
FROM SOLICITANTES
WHERE Nombre LIKE 'C%' OR Nombre LIKE 'S%';

----Consulta 3
SELECT *
FROM SOLICITANTES
WHERE SUBSTRING(cedulaID, LEN(cedulaID), 1) = '2';

--Consulta 4
SELECT *
FROM SOLICITANTES
WHERE LEFT(cedulaID, 3) = '001';

--Consulta 5
SELECT COUNT(DISTINCT Categoria) AS Tipos_de_Licencias
FROM Pagos_SOLICITUDES_LICENCIAS;

--Consulta 6
SELECT l.Categoria AS Tipo_de_licencia, s.cedulaID, s.Nombre 
FROM SOLICITANTES s
JOIN Licencias l ON s.cedulaID = l.CedulaID
GROUP BY l.Categoria, s.Nombre, s.cedulaID

--Consulta 7 
SELECT MAX(e.Salario) AS Salario_Maximo, MIN(e.Salario) AS Salario_Minimo
FROM EMPLEADOS e
JOIN DIVISIONES d ON e.DivisionID = d.DivisionID
WHERE d.DivisionID IN ('1','2','3');

--Consultas 8
SELECT MIN(CAST(Resultado AS INT)) AS Calificacion_Minima, MAX(CAST(Resultado AS INT)) AS Calificacion_Maxima
FROM EXAMENES
WHERE Tipo_examen = 'Examen Práctico';

--Consultas 9
SELECT Categoria_edad, COUNT(*) AS Cantidad
FROM CARNETS_APRENDIZAJE
GROUP BY Categoria_edad;

--Consultas 10
SELECT Categoria, SUM(Costo) AS Total_Pagado
FROM Pagos_SOLICITUDES_LICENCIAS
GROUP BY Categoria;

--Consultas 11
SELECT SOLICITANTES.cedulaID, SOLICITANTES.Nombre, Pagos_SOLICITUDES_LICENCIAS.Categoria
FROM SOLICITANTES
INNER JOIN Pagos_SOLICITUDES_LICENCIAS ON SOLICITANTES.cedulaID = Pagos_SOLICITUDES_LICENCIAS.CedulaID
WHERE SOLICITANTES.Edad = 17;


--Primera vista
CREATE VIEW VistaLicencias AS
SELECT LicenciaID, CedulaID
FROM LICENCIAS;

--Segunda vista
CREATE VIEW Vista_Categoria_3
WITH ENCRYPTION
AS
SELECT s.cedulaID, s.Nombre, s.Apellido, s.Fecha_nacimiento, s.Edad
FROM SOLICITANTES s
INNER JOIN LICENCIAS l ON s.cedulaID = l.CedulaID
WHERE l.Categoria = '3';

-- Para confirmar que los datos estan encriptados
SELECT name, OBJECTPROPERTY(OBJECT_ID('Vista_Categoria_3'), 'IsEncrypted') AS IsEncrypted
FROM sys.views
WHERE name = 'Vista_Categoria_3';

--Crear una vista basada en una instrucción SELECT
CREATE VIEW Vista_solicitantes_licencias 
AS
SELECT s.cedulaID, 
s.Nombre, 
s.Apellido, 
s.Fecha_nacimiento, 
s.sexo,
l.Categoria,
l.Fecha_emision,
l.Fecha_expiracion,
e.Tipo_examen,
e.Resultado

FROM SOLICITANTES s

JOIN LICENCIAS l ON s.cedulaID = l.cedulaID
JOIN EXAMENES e ON s.cedulaID = e.CedulaID

SELECT * FROM Vista_solicitantes_licencias

--Trigger para evento insert en la tabla principal
CREATE TRIGGER Aviso
ON SOLICITANTES
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Edad < 16)
    BEGIN
        PRINT 'Inserción cancelada. La edad insertada es menor que la edad mínima permitida';
    END
    ELSE
    BEGIN
	    PRINT 'Inserción correcta. Usted acaba de insertar un nuevo registro.';
        INSERT INTO SOLICITANTES (cedulaID, Nombre, Apellido, Fecha_nacimiento, Edad, Direccion) 
        SELECT cedulaID, Nombre, Apellido, Fecha_nacimiento, Edad, Direccion FROM inserted;
    END;
END;

--Inserción para probar el trigger
INSERT INTO SOLICITANTES (cedulaID, Nombre, Apellido, Fecha_nacimiento, Edad, Direccion)
VALUES ('40256128972','Ramón','Tolentino','2008/10/10',17,'Carretera Mella #34, San Cristóbal');

-- Trigger para el evento DELETE en la tabla LICENCIAS
CREATE TRIGGER Licencias_Delete_Trigger
ON LICENCIAS
AFTER DELETE
AS
BEGIN
    PRINT 'Usted ha eliminado un registro de la tabla LICENCIAS.';
END;

--Inserción para probar el trigger
INSERT INTO LICENCIAS (LicenciaID, CedulaID, Categoria, Estatura, Peso, Tipo_sangre, Fecha_emision, Fecha_expiracion)
VALUES   ('01728589674','40256128972', '3', 1.77, 76.0, 'B+', '2023-08-25', '2023-12-15');

DELETE FROM LICENCIAS
WHERE CedulaID='40256128972';

-- Trigger para eventos INSERT, UPDATE y DELETE en una tabla diferente 
CREATE TRIGGER modificacion_permisos
ON PERMISOS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND NOT EXISTS (SELECT * FROM DELETED)
    BEGIN
        -- En caso de una inserción
        PRINT 'Inserción correcta. Usted acaba de insertar un nuevo registro.';
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        -- En caso de una modificación
        PRINT 'Modificación realizada correctamente. Usted acaba de modificar un registro.';
    END
    ELSE IF NOT EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        -- En caso de una eliminación
        PRINT 'Eliminación correcta. Usted acaba de eliminar un registro.';
    END
END;

-- Inserción, modificación y eliminación para probar el trigger

INSERT INTO PERMISOS (CedulaID, Tipo_permiso, Fecha_emision, Fecha_expiracion)
VALUES
  ('40256128972', 'Carnet de aprendizaje Menores de 18 Años', '2023-08-25', '2023-12-15');

UPDATE PERMISOS
SET Tipo_permiso= 'Carnet de aprendizaje Mayores de 18 Años'
WHERE CedulaID = '40256128972';

DELETE FROM PERMISOS
WHERE CedulaID = '40256128972';

---Inhabilitación de primer y segundo trigger---

---Primer Trigger--- 
 Alter table SOLICITANTES 
 Disable trigger aviso 

 ---Segundo Trigger---

 Alter table Licencias
 Disable trigger Licencias_Delete_Trigger


 
 -- Crear una tabla temporal local
CREATE TABLE #TablaTemporal_SOLICITANTES (
    TempID INT PRIMARY KEY,
    CedulaID VARCHAR(20),
    Nombre VARCHAR(50),
    Apellido VARCHAR(50)
);

-- Crear una tabla temporal global
CREATE TABLE ##TablaTemporal_INFRACCION (
    TempID INT PRIMARY KEY,
    LicenciaID VARCHAR(200),
    Fecha_Infraccion DATETIME,
    Lugar_Infraccion VARCHAR(70)
);

-- Insertar registros en la tabla temporal local
INSERT INTO #TablaTemporal_SOLICITANTES (TempID, CedulaID, Nombre, Apellido)
VALUES
    (1, '001-4533795-7', 'Juan', 'Pérez'),
    (2, '402-3164748-4', 'Ana', 'Gómez'),
    (3, '001-6647965-2', 'Carlos', 'Rodríguez'),
    (4, '402-3425118-5', 'María', 'López'),
    (5, '402-3377742-8', 'Santiago', 'Santos');

-- Insertar registros en la tabla temporal global
INSERT INTO ##TablaTemporal_INFRACCION (TempID, LicenciaID, Fecha_Infraccion, Lugar_Infraccion)
VALUES
    (1, '00116840232', '2023-01-05 08:30:00', 'Avenida Principal'),
    (2, '02304918162', '2023-02-10 14:15:00', 'Calle 3'),
    (3, '88491002039', '2023-03-15 10:45:00', 'Autopista Norte'),
	(4, '40291002039', '2023-03-18 11:23:00', 'Carretera Mella'),
    (5, '00102948501', '2023-04-20 12:00:00', 'Calle Principal');

-- Mostrar el contenido de ambas tablas temporales en una consulta general
SELECT *
FROM #TablaTemporal_SOLICITANTES AS T1
JOIN ##TablaTemporal_INFRACCION AS T2 ON T1.TempID = T2.TempID;

--creacion de usuario digitador
CREATE LOGIN digitador WITH PASSWORD = 'mayonesa';

USE INTRANT; 
CREATE USER digitador FOR LOGIN digitador;

ALTER ROLE db_datawriter ADD MEMBER digitador;

CREATE USER digitador FOR LOGIN digitador;
GRANT INSERT, UPDATE, DELETE ON SCHEMA :: dbo TO digitador;

USE INTRANT; 


--creacion de usuario admin
CREATE LOGIN Gerente WITH PASSWORD = 'jefe';
CREATE USER Gerente FOR LOGIN Gerente;
ALTER ROLE db_ddladmin ADD MEMBER Gerente;
GRANT ALL PRIVILEGES ON INTRANT TO Gerente

-- Crear procedimiento almacenado con 2 parámetros de entrada
CREATE PROCEDURE ObtenerLicenciasPorEdad(
    @EdadMinima INT,
    @EdadMaxima INT
)
AS
BEGIN
    SELECT s.Nombre, s.Apellido, l.Categoria, l.Fecha_emision, l.Fecha_expiracion
    FROM SOLICITANTES s
    JOIN LICENCIAS l ON s.cedulaID = l.CedulaID
    WHERE s.Edad BETWEEN @EdadMinima AND @EdadMaxima;
END;

-- Ejecutar el procedimiento almacenado con valores específicos para los parámetros
EXEC ObtenerLicenciasPorEdad @EdadMinima = 25, @EdadMaxima = 35;

-- Crear el procedimiento almacenado para obtener licencias por edad y categoría
CREATE PROCEDURE ObtenerLicenciasPorEdadYCategoria
    @EdadMinima INT,
    @EdadMaxima INT,
    @Categoria VARCHAR(20) = NULL
AS
BEGIN
    SELECT s.Nombre, s.Apellido, l.Categoria, l.Fecha_emision, l.Fecha_expiracion
    FROM SOLICITANTES s
    JOIN LICENCIAS l ON s.cedulaID = l.CedulaID
    WHERE s.Edad BETWEEN @EdadMinima AND @EdadMaxima
    AND (@Categoria IS NULL OR l.Categoria = @Categoria);
END;

-- ejecución del procedimiento almacenado con filtro opcional por categoría de licencia
EXEC ObtenerLicenciasPorEdadYCategoria @EdadMinima = 25, @EdadMaxima = 35, @Categoria = '1';



-- Crea un procedimiento almacenado con 2 parámetros de salida 
CREATE PROCEDURE ObtenerInformacionSolicitanteSimple
    @CantidadSolicitantes INT OUTPUT,
    @InfoSolicitanteMasJoven VARCHAR(100) OUTPUT
AS
BEGIN

    SELECT @CantidadSolicitantes = COUNT(*)
    FROM SOLICITANTES;

    SELECT TOP 1 @InfoSolicitanteMasJoven = CONCAT(Nombre, ' ', Apellido, ', Edad: ', 
	CAST(Edad AS VARCHAR(10)))
    FROM SOLICITANTES
    ORDER BY Fecha_nacimiento DESC;
END;

-- Declaración de variables y ejecución del procedimiento.
DECLARE @Cantidad INT;
DECLARE @InfoSolicitanteMasJoven VARCHAR(100);

EXEC ObtenerInformacionSolicitanteSimple @Cantidad OUTPUT, @InfoSolicitanteMasJoven OUTPUT;

-- Muestra de resultados
SELECT 'Cantidad Total de Solicitantes' AS Informacion, @Cantidad AS Cantidad;

SELECT 'Información del Solicitante Más Joven' AS Informacion, 
@InfoSolicitanteMasJoven AS InfoSolicitanteMasJoven;



--Modificacion del procedimiento almacenado con 2 parámetros de salida 
CREATE PROCEDURE ObtenerInformacionSolicitanteCompleta
    @CantidadSolicitantes INT OUTPUT,
    @InfoSolicitanteMasJoven VARCHAR(200) OUTPUT,
    @InfoSolicitanteMasViejo VARCHAR(200) OUTPUT
AS
BEGIN
    SELECT @CantidadSolicitantes = COUNT(*)
    FROM SOLICITANTES;

    SELECT TOP 1 @InfoSolicitanteMasJoven = CONCAT(Nombre, ' ', Apellido, ', Edad: ', 
	CAST(Edad AS VARCHAR(10)))
    FROM SOLICITANTES
    ORDER BY Fecha_nacimiento DESC;

    SELECT TOP 1 @InfoSolicitanteMasViejo = CONCAT(Nombre, ' ', Apellido, ', Edad: ', 
	CAST(Edad AS VARCHAR(10)))
    FROM SOLICITANTES
    ORDER BY Fecha_nacimiento ASC;
END;

-- Declaración de variables y ejecución del procedimiento.
DECLARE @Cantidad INT;
DECLARE @InfoSolicitanteMasJoven VARCHAR(200);
DECLARE @InfoSolicitanteMasViejo VARCHAR(200);

EXEC ObtenerInformacionSolicitanteCompleta @Cantidad OUTPUT, @InfoSolicitanteMasJoven OUTPUT, @InfoSolicitanteMasViejo OUTPUT;

-- Muestra de resultados
SELECT 'Cantidad Total de Solicitantes' AS Informacion, @Cantidad AS Cantidad;

SELECT 'Información del Solicitante Más Joven' AS Informacion, 
@InfoSolicitanteMasJoven AS InfoSolicitanteMasJoven;

SELECT 'Información del Solicitante Más Viejo' AS Informacion, 
@InfoSolicitanteMasViejo AS InfoSolicitanteMasViejo;




--Normalizacion de la tabla empleados
CREATE TABLE PUESTOS_EMPLEADOS (
  PuestoID INT PRIMARY KEY IDENTITY (1,1),
  NombrePuesto VARCHAR(40)
);

-- Modificar la tabla EMPLEADOS para referenciar los puestos
ALTER TABLE EMPLEADOS
ADD PuestoID INT;

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_PUESTOS_EMPLEADOS FOREIGN KEY (PuestoID)
REFERENCES PUESTOS_EMPLEADOS(PuestoID);

-- Insertar datos en la tabla PUESTOS
INSERT INTO PUESTOS_EMPLEADOS (NombrePuesto)
VALUES
  ('Asistente Administrativo'),
  ('Coordinador de Licencias'),
  ('Técnico en Seguridad Vial'),
  ('Evaluador de Exámenes'),
  ('Asesor Legal'),
  ('Supervisor de Operaciones'),
  ('Gerente de Recursos Humanos');

-- Actualizar la tabla EMPLEADOS con los ID de los puestos
UPDATE EMPLEADOS
SET PuestoID = 1
WHERE Nombre = 'Juan';

UPDATE EMPLEADOS
SET PuestoID = 2
WHERE Nombre = 'Ana';

UPDATE EMPLEADOS
SET PuestoID = 3
WHERE Nombre = 'Carlos';

UPDATE EMPLEADOS
SET PuestoID = 4
WHERE Nombre = 'María';

UPDATE EMPLEADOS
SET PuestoID = 5
WHERE Nombre = 'Pedro';

UPDATE EMPLEADOS
SET PuestoID = 6
WHERE Nombre = 'Laura';

UPDATE EMPLEADOS
SET PuestoID = 7
WHERE Nombre = 'Luis';


-- Eliminar la columna Puesto de la tabla EMPLEADOS 
ALTER TABLE EMPLEADOS
DROP COLUMN Puesto;

select * from EMPLEADOS
select * from PUESTOS_EMPLEADOS