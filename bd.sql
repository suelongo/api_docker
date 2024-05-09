CREATE TABLE carrera (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE materia (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera_id INTEGER REFERENCES carrera(id)
);

CREATE TABLE especialidad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera_id INTEGER REFERENCES carrera(id)
);

CREATE TABLE materia_especialidad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad_id INTEGER REFERENCES especialidad(id)
);

-- Insertar carrera
INSERT INTO carrera (nombre) VALUES ('Ing. Sistemas Computacionales');

-- Insertar materias básicas
INSERT INTO materia (nombre, carrera_id) VALUES
('POO', 1),
('Estructuras de datos', 1),
('Bases de datos', 1);

-- Insertar especialidades
INSERT INTO especialidad (nombre, carrera_id) VALUES
('Desarrollo de Aplicaciones empresariales', 1),
('Computo en la IA', 1);

-- Insertar materias de especialidad de Desarrollo de Aplicaciones empresariales
INSERT INTO materia_especialidad (nombre, especialidad_id) VALUES
('Computo en la nube', 1),
('Desarrollo de apps moviles', 1);

-- Insertar materias de especialidad de Computo en la IA
INSERT INTO materia_especialidad (nombre, especialidad_id) VALUES
('Machine Learning', 2),
('Patrones', 2);




-- Insertar carrera
INSERT INTO carrera (nombre) VALUES ('Ingeniería Industrial');

-- Insertar materias básicas
INSERT INTO materia (nombre, carrera_id) VALUES
('MERCADOTECNIA', 2),
('LOGISTICA Y CADENA DE SUMINISTRO', 2),
('GESTION DE LOS SISTEMAS DE CALIDAD', 2);

-- Insertar especialidades
INSERT INTO especialidad (nombre, carrera_id) VALUES
('Ingeniería en Manufactura y Calidad', 2),
('Manufactura en Artículos de Piel', 2);

-- Insertar materias de especialidad de Ingeniería en Manufactura y Calidad
INSERT INTO materia_especialidad (nombre, especialidad_id) VALUES
('SISTEMAS NEUMATICOS E HIDRAULICOS', 3),
('TEMAS SELECTOS DE MANUFACTURA', 3),
('MEDICION Y MEJORAMIENTO DE LA PRODUCTIVIDAD', 3);

-- Insertar materias de especialidad de Manufactura en Artículos de Piel
INSERT INTO materia_especialidad (nombre, especialidad_id) VALUES
('ADMINISTRACION DE LOS SISTEMAS DE PRODUCCION DE CALZADO', 4),
('TEMAS SELECTOS DE MANUFACTURA', 4),
('CORE TOOL', 4);


-- Insertar carrera
INSERT INTO carrera (nombre) VALUES ('Ingeniería en Gestión Empresarial');

-- Insertar materias básicas
INSERT INTO materia (nombre, carrera_id) VALUES
('Plan de Negocios', 3),
('Ingeniería Económica', 3),
('Costos Empresariales', 3),
('Gestión del Capital Humano', 3);

-- Insertar especialidades
INSERT INTO especialidad (nombre, carrera_id) VALUES
('Gestión de la Calidad e Innovación de Procesos', 3);

-- Insertar materias de especialidad de Gestión de la Calidad e Innovación de Procesos
INSERT INTO materia_especialidad (nombre, especialidad_id) VALUES
('Innovación de Procesos', 5),
('Calidad Aplicada a la Gestión Empresarial II', 5),
('Gestión del Conocimiento', 5);
