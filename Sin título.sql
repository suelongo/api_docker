CREATE TABLE estudiantes (
    matricula SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    carrera VARCHAR(100),
    correo VARCHAR(100)
);

-- Insertar valores de ejemplo en la tabla estudiantes
INSERT INTO estudiantes (nombre, carrera, correo) VALUES
    ('Juan Pérez', 'Ingeniería en Sistemas', 'juan@example.com'),
    ('María García', 'Medicina', 'maria@example.com'),
    ('Pedro López', 'Derecho', 'pedro@example.com'),
    ('Ana Martínez', 'Arquitectura', 'ana@example.com');

SELECT * FROM estudiantes;
-- Crear tabla de campus
CREATE TABLE campus (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Insertar datos de ejemplo en la tabla de campus
INSERT INTO campus (nombre) VALUES
    ('Campus I'),
    ('Campus II');

-- Crear tabla de carreras
CREATE TABLE carreras (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    campus_id INT REFERENCES campus(id),
    turno VARCHAR(20) NOT NULL,
    especialidad VARCHAR(100) NOT NULL
);

-- Insertar datos de ejemplo en la tabla de carreras
INSERT INTO carreras (nombre, campus_id, turno, especialidad) VALUES
    ('Ingeniería Industrial', 1, 'Matutino', 'Gestión de la Producción'),
    ('Ingeniería Electromecánica', 1, 'Vespertino', 'Automatización Industrial'),
    ('Ingeniería en Logística', 1, 'Matutino', 'Logística Internacional'),
    ('Ingeniería en Sistemas Computacionales', 2, 'Vespertino', 'Seguridad Informática'),
    ('Ingeniería en Tecnologías de la Información y Comunicaciones', 2, 'Matutino', 'Sistemas Embebidos');

-- Crear tabla de materias de especialidad
CREATE TABLE materias_especialidad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera_id INT REFERENCES carreras(id)
);

-- Insertar datos de ejemplo en la tabla de materias de especialidad
INSERT INTO materias_especialidad (nombre, carrera_id) VALUES
    ('Gestión de Proyectos', 1),
    ('Diseño Mecánico', 2),
    ('Logística Inversa', 3),
    ('Redes Inalámbricas', 4),
    ('Sistemas Embebidos Avanzados', 5);
