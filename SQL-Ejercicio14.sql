DROP DATABASE IF EXISTS bd_recetas_cocina;
CREATE DATABASE bd_recetas_cocina;
USE bd_recetas_cocina;

CREATE TABLE MIEMBRO (
    PK_id_usuario VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contrasenia_hash VARCHAR(255) NOT NULL,
    tipo_perfil VARCHAR(50),
    fecha_registro DATE
);

CREATE TABLE INGREDIENTE (
    PK_codigo_ingrediente VARCHAR(20) PRIMARY KEY,
    nombre_ingrediente VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(30),
    calorias_por_unidad DECIMAL(10,2),
    categoria_alimento VARCHAR(50)
);

CREATE TABLE RECETA (
    PK_codigo_receta VARCHAR(20) PRIMARY KEY,
    FK_id_usuario VARCHAR(20) NOT NULL,
    titulo_receta VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tiempo_est_prep VARCHAR(30),
    porciones INT,
    dificultad VARCHAR(30),
    FOREIGN KEY (FK_id_usuario) REFERENCES MIEMBRO(PK_id_usuario)
);

CREATE TABLE DETALLE_RECETA_INGREDIENTE (
    PK_detalle VARCHAR(20) PRIMARY KEY,
    FK_codigo_receta VARCHAR(20) NOT NULL,
    FK_codigo_ingrediente VARCHAR(20) NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FK_codigo_receta) REFERENCES RECETA(PK_codigo_receta),
    FOREIGN KEY (FK_codigo_ingrediente) REFERENCES INGREDIENTE(PK_codigo_ingrediente)
);

CREATE TABLE PASO_RECETA (
    PK_id_paso VARCHAR(20) PRIMARY KEY,
    FK_codigo_receta VARCHAR(20) NOT NULL,
    numero_orden_sec INT NOT NULL,
    descripcion_instr TEXT NOT NULL,
    tiempo_aplicacion_min INT,
    imagen_opcional_url VARCHAR(255),
    FOREIGN KEY (FK_codigo_receta) REFERENCES RECETA(PK_codigo_receta)
);

CREATE TABLE RESENA (
    PK_id_resena VARCHAR(20) PRIMARY KEY,
    FK_id_usuario VARCHAR(20) NOT NULL,
    FK_codigo_receta VARCHAR(20) NOT NULL,
    puntuacion_estrellas INT NOT NULL,
    comentario_opinion TEXT,
    fecha_publicacion DATE NOT NULL,
    votos_utiles INT,
    FOREIGN KEY (FK_id_usuario) REFERENCES MIEMBRO(PK_id_usuario),
    FOREIGN KEY (FK_codigo_receta) REFERENCES RECETA(PK_codigo_receta)
);

------------------------------------------------------------------------

INSERT INTO MIEMBRO (PK_id_usuario, nombre, apellido, correo_electronico, contrasenia_hash, tipo_perfil, fecha_registro) VALUES
('USR-01', 'Lucía', 'Gomez', 'lucia.g@cocina.com', '$2a$12$e8f...hash1', 'Chef Profesional', '2026-01-10'),
('USR-02', 'Marcos', 'Pérez', 'marcos.p@cocina.com', '$2a$12$a1b...hash2', 'Amateur', '2026-02-15'),
('USR-03', 'Sofía', 'Ruiz', 'sofia.r@cocina.com', '$2a$12$d3e...hash3', 'Nutricionista', '2026-03-01'),
('USR-04', 'Esteban', 'Quito', 'esteban.q@cocina.com', '$2a$12$g5h...hash4', 'Amateur', '2026-03-20'),
('USR-05', 'Camila', 'Torres', 'camila.t@cocina.com', '$2a$12$j7k...hash5', 'Chef pastelera', '2026-04-05');

INSERT INTO INGREDIENTE (PK_codigo_ingrediente, nombre_ingrediente, unidad_medida, calorias_por_unidad, categoria_alimento) VALUES
('ING-01', 'Fideos Spaghetti', 'gramos', 3.50, 'Pastas'),
('ING-02', 'Huevo', 'unidad', 75.00, 'Huevos'),
('ING-03', 'Queso Parmesano', 'gramos', 4.30, 'Lácteos'),
('ING-04', 'Chocolate amargo', 'gramos', 5.40, 'Repostería'),
('ING-05', 'Pechuga de Pollo', 'gramos', 1.65, 'Carnes y Aves');

INSERT INTO RECETA (PK_codigo_receta, FK_id_usuario, titulo_receta, descripcion, tiempo_est_prep, porciones, dificultad) VALUES
('REC-101', 'USR-01', 'Pasta Carbonara Casera', 'Auténtica receta italiana sin crema', '25 min', 2, 'Media'),
('REC-102', 'USR-05', 'Brownie de Chocolate', 'Húmedo y con nueces', '40 min', 8, 'Baja'),
('REC-103', 'USR-03', 'Ensalada César Fit', 'Baja en calorías con pollo grillado', '15 min', 1, 'Baja'),
('REC-104', 'USR-02', 'Risotto de Hongos', 'Risotto cremoso con champignones', '35 min', 4, 'Alta'),
('REC-105', 'USR-04', 'Tacos al Pastor', 'Tacos tradicionales mexicanos', '50 min', 5, 'Media');

INSERT INTO DETALLE_RECETA_INGREDIENTE (PK_detalle, FK_codigo_receta, FK_codigo_ingrediente, cantidad_necesaria) VALUES
('DET-01', 'REC-101', 'ING-01', 200.0),
('DET-02', 'REC-101', 'ING-02', 2.0),
('DET-03', 'REC-101', 'ING-03', 50.0),
('DET-04', 'REC-102', 'ING-04', 150.0),
('DET-05', 'REC-103', 'ING-05', 200.0);

INSERT INTO PASO_RECETA (PK_id_paso, FK_codigo_receta, numero_orden_sec, descripcion_instr, tiempo_aplicacion_min, imagen_opcional_url) VALUES
('PAS-01', 'REC-101', 1, 'Hervir la pasta en agua con sal', 10, 'https://img.com/p1.jpg'),
('PAS-02', 'REC-101', 2, 'Batir yemas con queso y pimienta', 5, NULL),
('PAS-03', 'REC-102', 1, 'Fundir chocolate con manteca a baño maría', 10, 'https://img.com/p2.jpg'),
('PAS-04', 'REC-103', 1, 'Grillar la pechuga de pollo y trozar', 12, NULL),
('PAS-05', 'REC-104', 1, 'Sautear hongos con ajo y aceite de oliva', 8, 'https://img.com/p3.jpg');

INSERT INTO RESENA (PK_id_resena, FK_id_usuario, FK_codigo_receta, puntuacion_estrellas, comentario_opinion, fecha_publicacion, votos_utiles) VALUES
('RES-01', 'USR-02', 'REC-101', 5, '¡Excelente receta, salió perfecta!', '2026-10-02', 14),
('RES-02', 'USR-04', 'REC-102', 4, 'Muy rico, aunque le faltó un poco más de nuez.', '2026-10-04', 8),
('RES-03', 'USR-01', 'REC-103', 5, 'Muy fresca y práctica para la semana.', '2026-10-06', 5),
('RES-04', 'USR-03', 'REC-104', 5, 'La cremosidad quedó increíble.', '2026-10-10', 19),
('RES-05', 'USR-02', 'REC-105', 4, 'Muy sabrosos, excelente explicación.', '2026-10-12', 11);