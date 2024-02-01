-- EVALUACION TECNICA SQL - NEISER DENNIS
CREATE DATABASE IE_CESAR_VALLEJO;
USE IE_CESAR_VALLEJO;

-- Tablas
CREATE TABLE Departamentos (
    Departamento_ID INT IDENTITY(1,1) PRIMARY KEY,
    NombreDepartamento VARCHAR(255) NOT NULL,
    Ubicacion VARCHAR(100)
);

CREATE TABLE Docentes (
    Docente_ID INT IDENTITY(1,1) PRIMARY KEY,
    NombreDocente VARCHAR(255) NOT NULL,
    TituloAcademico VARCHAR(100),
    Departamento_ID INT
);

CREATE TABLE Cursos (
    Curso_ID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCurso VARCHAR(255) NOT NULL,
    DuracionCurso INT,
    Creditos INT,
    Departamento_ID INT
);

CREATE TABLE Alumnos (
    Alumno_ID INT IDENTITY(1,1) PRIMARY KEY,
    NombreAlumno VARCHAR(255) NOT NULL,
    FechaNacimiento DATE,
    Direccion VARCHAR(255),
    CorreoElectronico VARCHAR(100)
);

CREATE TABLE Matriculas (
    Matricula_ID INT IDENTITY(1,1) PRIMARY KEY,
    FechaMatricula DATE,
    EstadoMatricula VARCHAR(20),
    Alumno_ID INT,
    Curso_ID INT
);

-- Relaciones adecuadas entre las tablas, claves primarias, foráneas y restricciones de integridad referencial.
ALTER TABLE Docentes
ADD CONSTRAINT FK_Departamento_Docente
FOREIGN KEY (Departamento_ID)
REFERENCES Departamentos (Departamento_ID);

ALTER TABLE Cursos
ADD CONSTRAINT FK_Departamento_Curso
FOREIGN KEY (Departamento_ID)
REFERENCES Departamentos (Departamento_ID);

ALTER TABLE Cursos
ADD CONSTRAINT FK_Docente_Curso
FOREIGN KEY (Departamento_ID)
REFERENCES Docentes (Docente_ID);

ALTER TABLE Matriculas
ADD CONSTRAINT FK_Alumno_Matricula
FOREIGN KEY (Alumno_ID)
REFERENCES Alumnos (Alumno_ID);

ALTER TABLE Matriculas
ADD CONSTRAINT FK_Curso_Matricula
FOREIGN KEY (Curso_ID)
REFERENCES Cursos (Curso_ID);

-- Inserción de registros
INSERT INTO Departamentos (NombreDepartamento, Ubicacion)
VALUES 
('Departamento de Matemáticas', 'Edificio A'),
('Departamento de Historia', 'Edificio B'),
('Departamento de Ciencias de la Salud', 'Edificio C');

INSERT INTO Docentes (NombreDocente, TituloAcademico, Departamento_ID)
VALUES 
('Jose Manuel Solar', 'Doctorado en Matemáticas', 1),
('Marleny Miranda Torres', 'Maestría en Historia', 2),
('Lucio Javier Valdelomar', 'Doctor en Medicina', 3);

INSERT INTO Cursos (NombreCurso, DuracionCurso, Creditos, Departamento_ID)
VALUES 
('Algebra Lineal', 12, 3, 1),
('Historia Antigua', 10, 4, 2),
('Anatomía Humana', 15, 5, 2),
('Ciencias Sociales', 10, 3, 3),
('Filosofía', 8, 2, 3);

INSERT INTO Alumnos (NombreAlumno, FechaNacimiento, Direccion, CorreoElectronico)
VALUES 
('Fabricio Santo Valdez', '2000-01-15', 'Calle 123, Ciudad A', 'Fabricio@example.com'),
('Maldini Oscar Suarez', '1999-05-22', 'Avenida XYZ, Ciudad B', 'Maldini@example.com'),
('Lionel Lunar Perez', '2002-03-10', 'Ruta 456, Ciudad C', 'Lionel@example.com');

INSERT INTO Matriculas (FechaMatricula, EstadoMatricula, Alumno_ID, Curso_ID)
VALUES 
('2023-02-10', 'Activa', 1, 1),
('2023-01-20', 'Inactiva', 2, 2),
('2023-03-05', 'Activa', 3, 3), 
('2023-01-20', 'Inactiva', 2, 1),
('2023-03-05', 'Activa', 3, 1);

-- Consulta SQL que muestre todos los alumnos matriculados en un curso específico.
SELECT Cursos.NombreCurso, Alumnos.NombreAlumno, Matriculas.FechaMatricula, Matriculas.EstadoMatricula
FROM Matriculas
JOIN Alumnos ON Matriculas.Alumno_ID = Alumnos.Alumno_ID
JOIN Cursos ON Matriculas.Curso_ID = Cursos.Curso_ID
WHERE Cursos.NombreCurso = 'Algebra Lineal';


-- Consulta SQL que muestre todos los cursos en los que un docente específico está asignado como instructor.
SELECT Docentes.NombreDocente, Cursos.NombreCurso, Cursos.DuracionCurso
FROM Docentes
JOIN Cursos ON Docentes.Departamento_ID = Cursos.Departamento_ID
WHERE Docentes.NombreDocente = 'Lucio Javier Valdelomar';


