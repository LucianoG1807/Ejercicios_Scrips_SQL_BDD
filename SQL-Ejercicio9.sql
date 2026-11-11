DROP DATABASE IF EXISTS bd_cursos_online;
CREATE DATABASE bd_cursos_online;
USE bd_cursos_online;

CREATE TABLE INSTRUCTOR (
    PK_id_instructor VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    biografia TEXT,
    especialidad VARCHAR(50),
    datos_contacto VARCHAR(100)
);

CREATE TABLE ESTUDIANTE (
    PK_id_estudiante VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_registro DATE
);

CREATE TABLE CURSO (
    PK_codigo_curso VARCHAR(20) PRIMARY KEY,
    FK_id_instructor VARCHAR(20) NOT NULL,
    titulo_curso VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(150),
    nivel_dificultad VARCHAR(30),
    FOREIGN KEY (FK_id_instructor) REFERENCES INSTRUCTOR(PK_id_instructor)
);

CREATE TABLE MODULO (
    PK_id_modulo VARCHAR(20) PRIMARY KEY,
    FK_codigo_curso VARCHAR(20) NOT NULL,
    titulo_modulo VARCHAR(100) NOT NULL,
    objetivo_aprendizaje VARCHAR(150),
    orden_secuencia INT,
    duracion_estim_hrs INT,
    FOREIGN KEY (FK_codigo_curso) REFERENCES CURSO(PK_codigo_curso)
);

CREATE TABLE LECCION (
    PK_id_leccion VARCHAR(20) PRIMARY KEY,
    FK_id_modulo VARCHAR(20) NOT NULL,
    tipo_leccion VARCHAR(30),
    titulo_leccion VARCHAR(100) NOT NULL,
    duracion_estim_min INT,
    enlace_contenido VARCHAR(150),
    FOREIGN KEY (FK_id_modulo) REFERENCES MODULO(PK_id_modulo)
);

CREATE TABLE EVALUACION (
    PK_id_evaluacion VARCHAR(20) PRIMARY KEY,
    FK_codigo_curso VARCHAR(20) NOT NULL,
    titulo_evaluacion VARCHAR(100) NOT NULL,
    tipo_evaluacion VARCHAR(30),
    puntaje_aprob_min INT,
    tiempo_limite_min INT,
    FOREIGN KEY (FK_codigo_curso) REFERENCES CURSO(PK_codigo_curso)
);

CREATE TABLE PREGUNTA (
    PK_id_pregunta VARCHAR(20) PRIMARY KEY,
    FK_id_evaluacion VARCHAR(20) NOT NULL,
    enunciado_pregunta TEXT NOT NULL,
    puntaje_asignado INT,
    respuesta_correcta VARCHAR(150),
    opciones_respuesta VARCHAR(150),
    FOREIGN KEY (FK_id_evaluacion) REFERENCES EVALUACION(PK_id_evaluacion)
);

CREATE TABLE INSCRIPCION_CURSO_ESTUDIANTE (
    PK_inscripcion INT PRIMARY KEY,
    FK_codigo_curso VARCHAR(20) NOT NULL,
    FK_id_estudiante VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_curso) REFERENCES CURSO(PK_codigo_curso),
    FOREIGN KEY (FK_id_estudiante) REFERENCES ESTUDIANTE(PK_id_estudiante)
);

CREATE TABLE EVALUACION_REALIZA (
    PK_evaluacion_realiza INT PRIMARY KEY,
    FK_id_estudiante VARCHAR(20) NOT NULL,
    FK_id_evaluacion VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_estudiante) REFERENCES ESTUDIANTE(PK_id_estudiante),
    FOREIGN KEY (FK_id_evaluacion) REFERENCES EVALUACION(PK_id_evaluacion)
);

------------------------------------------------------------------------

INSERT INTO INSTRUCTOR (PK_id_instructor, nombre, apellido, biografia, especialidad, datos_contacto) VALUES
('INS01', 'Carlos', 'Pérez', 'Experto en backend con 10 años', 'Backend & Cloud', 'c.perez@edu.com'),
('INS02', 'María', 'Gómez', 'Diseñadora UX/UI senior', 'UX/UI Design', 'm.gomez@edu.com'),
('INS03', 'Juan', 'Rodríguez', 'Ingeniero de datos y ML', 'Data Science', 'j.rodriguez@edu.com'),
('INS04', 'Ana', 'Martínez', 'Desarrolladora Frontend React', 'Frontend', 'a.martinez@edu.com'),
('INS05', 'Luis', 'Fernández', 'Arquitecto de software DevOps', 'DevOps', 'l.fernandez@edu.com');

INSERT INTO ESTUDIANTE (PK_id_estudiante, nombre, apellido, correo_electronico, fecha_registro) VALUES
('EST01', 'Sofía', 'Benítez', 's.benitez@alumno.edu', '2026-02-15'),
('EST02', 'Mateo', 'Rossi', 'm.rossi@alumno.edu', '2026-02-20'),
('EST03', 'Valentina', 'Ruiz', 'v.ruiz@alumno.edu', '2026-03-01'),
('EST04', 'Lucas', 'Giménez', 'l.gimenez@alumno.edu', '2026-03-10'),
('EST05', 'Camila', 'Torres', 'c.torres@alumno.edu', '2026-03-15');

INSERT INTO CURSO (PK_codigo_curso, FK_id_instructor, titulo_curso, precio, descripcion, nivel_dificultad) VALUES
('CUR01', 'INS01', 'Master en Node.js', 149.99, 'Microservicios y Node.js', 'Avanzado'),
('CUR02', 'INS02', 'UX/UI Fundamentos', 89.99, 'Diseño de interfaces', 'Principiante'),
('CUR03', 'INS03', 'Python Data Science', 129.99, 'Machine Learning y Pandas', 'Intermedio'),
('CUR04', 'INS04', 'React Expert', 99.99, 'Aplicaciones web modernas', 'Intermedio'),
('CUR05', 'INS05', 'DevOps con Docker', 179.99, 'Contenedores y Kubernetes', 'Avanzado');

INSERT INTO MODULO (PK_id_modulo, FK_codigo_curso, titulo_modulo, objetivo_aprendizaje, orden_secuencia, duracion_estim_hrs) VALUES
('MOD01', 'CUR01', 'Intro a Node.js', 'Entender fundamentos del runtime', 1, 5),
('MOD02', 'CUR01', 'Microservicios', 'Diseñar servicios desacoplados', 2, 10),
('MOD03', 'CUR02', 'Investigación UX', 'Técnicas de entrevistas y testing', 1, 4),
('MOD04', 'CUR03', 'Pandas & Numpy', 'Limpieza de datasets', 1, 8),
('MOD05', 'CUR05', 'Docker y Contenedores', 'Creación y gestión de imágenes', 1, 6);

INSERT INTO LECCION (PK_id_leccion, FK_id_modulo, tipo_leccion, titulo_leccion, duracion_estim_min, enlace_contenido) VALUES
('LEC01', 'MOD01', 'Video', '¿Qué es Node.js y V8?', 25, 'https://edu.com/lec1'),
('LEC02', 'MOD01', 'Lectura', 'Event Loop y Asincronía', 15, 'https://edu.com/lec2'),
('LEC03', 'MOD02', 'Video', 'gRPC y REST', 40, 'https://edu.com/lec3'),
('LEC04', 'MOD03', 'Cuestionario', 'Test de Wireframing', 20, 'https://edu.com/lec4'),
('LEC05', 'MOD05', 'Video', 'Uso avanzado de useEffect', 35, 'https://edu.com/lec5');

INSERT INTO EVALUACION (PK_id_evaluacion, FK_codigo_curso, titulo_evaluacion, tipo_evaluacion, puntaje_aprob_min, tiempo_limite_min) VALUES
('EVA01', 'CUR01', 'Examen Parcial Backend', 'Quiz', 60, 45),
('EVA02', 'CUR02', 'Proyecto Final UX/UI', 'Práctico', 70, 120),
('EVA03', 'CUR03', 'Examen Pandas', 'Quiz', 60, 50),
('EVA04', 'CUR04', 'Test de React Hooks', 'Quiz', 75, 30),
('EVA05', 'CUR05', 'Examen Kubernetes', 'Quiz', 80, 60);

INSERT INTO PREGUNTA (PK_id_pregunta, FK_id_evaluacion, enunciado_pregunta, puntaje_asignado, respuesta_correcta, opciones_respuesta) VALUES
('PRG01', 'EVA01', '¿Método para salir de proceso?', 10, 'process.exit()', 'exit / stop / process.exit()'),
('PRG02', 'EVA02', 'Objetivo de wireframe baja fid.', 20, 'Validar estructura', 'Colores / Estructura / Tipografía'),
('PRG03', 'EVA03', 'Función Pandas leer CSV', 15, 'pd.read_csv()', 'read / read_csv() / load'),
('PRG04', 'EVA04', 'Hook efectos secundarios', 10, 'useEffect', 'useState / useEffect / useContext'),
('PRG05', 'EVA05', 'Objeto K8s para pods replicados', 20, 'Deployment', 'Pod / Service / Deployment');

INSERT INTO INSCRIPCION_CURSO_ESTUDIANTE (PK_inscripcion, FK_codigo_curso, FK_id_estudiante) VALUES
(101, 'CUR01', 'EST01'),
(102, 'CUR02', 'EST02'),
(103, 'CUR03', 'EST03'),
(104, 'CUR04', 'EST04'),
(105, 'CUR05', 'EST05');

INSERT INTO EVALUACION_REALIZA (PK_evaluacion_realiza, FK_id_estudiante, FK_id_evaluacion) VALUES
(501, 'EST01', 'EVA01'),
(502, 'EST02', 'EVA02'),
(503, 'EST03', 'EVA03'),
(504, 'EST04', 'EVA04'),
(505, 'EST05', 'EVA05');