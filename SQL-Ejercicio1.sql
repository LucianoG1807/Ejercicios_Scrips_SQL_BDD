CREATE DATABASE IF NOT EXISTS bd_biblioteca;
USE bd_biblioteca;

-- ==========================================================
-- 1. CREACIÓN DE TABLAS (DDL)
-- ==========================================================

CREATE TABLE AUTOR (
    PK_ID_autor VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE
);

CREATE TABLE EDITORIAL (
    PK_ID_editorial VARCHAR(10) PRIMARY KEY,
    nombre_editorial VARCHAR(100) NOT NULL,
    pais_origen VARCHAR(50),
    direccion_fiscal VARCHAR(150),
    email_contacto VARCHAR(100)
);

CREATE TABLE LIBRO (
    PK_ISBN VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    tipo VARCHAR(50),
    fecha_lanzamiento DATE,
    anio_edicion INT,
    idioma VARCHAR(50),
    FK_ID_editorial VARCHAR(10),
    FOREIGN KEY (FK_ID_editorial) REFERENCES EDITORIAL(PK_ID_editorial)
);

CREATE TABLE LIBRO_AUTOR (
    PK_ID_autor_libro VARCHAR(10) PRIMARY KEY,
    FK_ID_autor VARCHAR(10) NOT NULL,
    FK_ISBN VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_ID_autor) REFERENCES AUTOR(PK_ID_autor),
    FOREIGN KEY (FK_ISBN) REFERENCES LIBRO(PK_ISBN)
);

CREATE TABLE USUARIO (
    PK_num_legajo VARCHAR(10) PRIMARY KEY,
    tipo_usuario VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(30)
);

CREATE TABLE EJEMPLAR (
    PK_cod_inventario VARCHAR(10) PRIMARY KEY,
    estado_conservacion VARCHAR(50),
    ubicacion_estanteria VARCHAR(50),
    disponibilidad VARCHAR(30),
    fecha_alta_inventario DATE,
    FK_ISBN VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_ISBN) REFERENCES LIBRO(PK_ISBN)
);

CREATE TABLE PRESTAMO (
    PK_ID_prestamo VARCHAR(10) PRIMARY KEY,
    fecha_solicitud DATE NOT NULL,
    estado_prestamo VARCHAR(30),
    observaciones TEXT,
    FK_num_legajo VARCHAR(10) NOT NULL,
    FOREIGN KEY (FK_num_legajo) REFERENCES USUARIO(PK_num_legajo)
);

CREATE TABLE DETALLE_PRESTAMO_EJEMPLAR (
    PK_ID_detalle VARCHAR(10) PRIMARY KEY,
    FK_ID_prestamo VARCHAR(10) NOT NULL,
    FK_cod_inventario VARCHAR(10) NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_prevista_dev DATE NOT NULL,
    fecha_real_dev DATE,
    FOREIGN KEY (FK_ID_prestamo) REFERENCES PRESTAMO(PK_ID_prestamo),
    FOREIGN KEY (FK_cod_inventario) REFERENCES EJEMPLAR(PK_cod_inventario)
);


-- ==========================================================
-- 2. INSERCIÓN DE DATOS (DML)
-- ==========================================================

-- AUTOR
INSERT INTO AUTOR (PK_ID_autor, nombre, apellido, nacionalidad, fecha_nacimiento) VALUES
('A00001', 'Gabriel', 'Garcia Marquez', 'Colombia', '1927-03-06'),
('A00002', 'J.R.R.', 'Tolkien', 'Reino Unido', '1892-01-03'),
('A00003', 'Julio', 'Cortazar', 'Argentina', '1914-08-26'),
('A00004', 'Jorge Luis', 'Borges', 'Argentina', '1899-08-24'),
('A00005', 'Isabel', 'Allende', 'Chile', '1942-08-02');

-- EDITORIAL
INSERT INTO EDITORIAL (PK_ID_editorial, nombre_editorial, pais_origen, direccion_fiscal, email_contacto) VALUES
('ED001', 'Sudamericana', 'Argentina', 'Humberto 1 555', 'info@suda.com'),
('ED002', 'Planeta', 'España', 'Av. Diagonal 662', 'contacto@planeta.es'),
('ED003', 'Alfaguara', 'España', 'Calle Torrelaguna 60', 'info@alfaguara.es'),
('ED004', 'Minotauro', 'Argentina', 'Av. Belgrano 120', 'minotauro@mail.com'),
('ED005', 'Siglo XXI', 'Mexico', 'Av. Coyoacan 10', 'contacto@sigloxxi.mx');

-- LIBRO
INSERT INTO LIBRO (PK_ISBN, titulo, tipo, fecha_lanzamiento, anio_edicion, idioma, FK_ID_editorial) VALUES
('ISBN001', 'Cien Anos Soledad', 'Novela', '1967-06-05', 2018, 'Espanol', 'ED001'),
('ISBN002', 'El Hobbit', 'Fantasia', '1937-09-21', 2015, 'Ingles', 'ED004'),
('ISBN003', 'Rayuela', 'Novela', '1963-06-28', 2019, 'Espanol', 'ED003'),
('ISBN004', 'Ficciones', 'Cuentos', '1944-05-12', 2011, 'Espanol', 'ED002'),
('ISBN005', 'La Casa de Espiritus', 'Novela', '1982-10-10', 2020, 'Espanol', 'ED001');

-- LIBRO_AUTOR
INSERT INTO LIBRO_AUTOR (PK_ID_autor_libro, FK_ID_autor, FK_ISBN) VALUES
('AL001', 'A00001', 'ISBN001'),
('AL002', 'A00002', 'ISBN002'),
('AL003', 'A00003', 'ISBN003'),
('AL004', 'A00004', 'ISBN004'),
('AL005', 'A00005', 'ISBN005');

-- USUARIO
INSERT INTO USUARIO (PK_num_legajo, tipo_usuario, dni, nombre, apellido, correo, telefono) VALUES
('L001', 'Estudiante', '42111222', 'Luciano', 'Gomez', 'lucho@mail.com', '281455566'),
('L002', 'Docente', '28333444', 'Mariana', 'Perez', 'mariana@mail.com', '281788990'),
('L003', 'Estudiante', '40555666', 'Carlos', 'Ruiz', 'carlos@mail.com', '281112233'),
('L004', 'Investigador', '35777888', 'Ana', 'Torres', 'ana@mail.com', '281445586'),
('L005', 'Estudiante', '43999000', 'Mateo', 'Diaz', 'mateo@mail.com', '281778899');

-- EJEMPLAR
INSERT INTO EJEMPLAR (PK_cod_inventario, estado_conservacion, ubicacion_estanteria, disponibilidad, fecha_alta_inventario, FK_ISBN) VALUES
('EJ001', 'Bueno', 'Estante A1', 'Disponible', '2025-02-10', 'ISBN001'),
('EJ002', 'Excelente', 'Estante B3', 'Prestado', '2025-03-15', 'ISBN002'),
('EJ003', 'Regular', 'Estante C2', 'Disponible', '2025-04-20', 'ISBN003'),
('EJ004', 'Excelente', 'Estante D1', 'Prestado', '2025-05-05', 'ISBN004'),
('EJ005', 'Bueno', 'Estante A2', 'Disponible', '2025-06-12', 'ISBN005');

-- PRESTAMO
INSERT INTO PRESTAMO (PK_ID_prestamo, fecha_solicitud, estado_prestamo, observaciones, FK_num_legajo) VALUES
('P001', '2028-10-01', 'Activo', 'Ninguna', 'L001'),
('P002', '2026-10-05', 'Finalizado', 'A tiempo', 'L002'),
('P003', '2026-10-08', 'Activo', 'Renovado', 'L003'),
('P004', '2026-10-10', 'Pendiente', 'Ninguna', 'L004'),
('P005', '2026-10-12', 'Finalizado', 'Con mora', 'L005');

-- DETALLE_PRESTAMO_EJEMPLAR
INSERT INTO DETALLE_PRESTAMO_EJEMPLAR (PK_ID_detalle, FK_ID_prestamo, FK_cod_inventario, fecha_prestamo, fecha_prevista_dev, fecha_real_dev) VALUES
('DET001', 'P001', 'EJ001', '2026-10-01', '2026-10-15', NULL),
('DET002', 'P002', 'EJ002', '2026-10-05', '2026-10-19', '2026-10-18'),
('DET003', 'P003', 'EJ003', '2026-10-08', '2026-10-22', NULL),
('DET004', 'P004', 'EJ004', '2026-10-10', '2026-10-24', NULL),
('DET005', 'P005', 'EJ005', '2026-10-12', '2026-10-26', '2026-10-28');