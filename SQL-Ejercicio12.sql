DROP DATABASE IF EXISTS bd_red_social;
CREATE DATABASE bd_red_social;
USE bd_red_social;

CREATE TABLE USUARIO (
    PK_username VARCHAR(50) PRIMARY KEY,
    correo_electronico VARCHAR(100) NOT NULL,
    contrasenia_hash VARCHAR(255) NOT NULL,
    biografia TEXT,
    fecha_alta DATE
);

CREATE TABLE ETIQUETA (
    PK_nombre_hashtag VARCHAR(50) PRIMARY KEY,
    cantidad_usos INT,
    categoria_tematica VARCHAR(50),
    estado_tendencia VARCHAR(30),
    fecha_creacion DATE
);

CREATE TABLE PUBLICACION (
    PK_id_publicacion VARCHAR(20) PRIMARY KEY,
    FK_username VARCHAR(50) NOT NULL,
    FK_nombre_hashtag VARCHAR(50) NOT NULL,
    leyenda_descripcion TEXT,
    ubicacion_geo VARCHAR(100),
    url_archivo_imagen VARCHAR(255),
    fecha_pub DATE NOT NULL,
    hora_pub TIME NOT NULL,
    FOREIGN KEY (FK_username) REFERENCES USUARIO(PK_username),
    FOREIGN KEY (FK_nombre_hashtag) REFERENCES ETIQUETA(PK_nombre_hashtag)
);

CREATE TABLE USUARIO_SIGUE_USUARIO (
    PK_seguimiento VARCHAR(20) PRIMARY KEY,
    FK_username_seguidor VARCHAR(50) NOT NULL,
    FK_username_seguido VARCHAR(50) NOT NULL,
    FOREIGN KEY (FK_username_seguidor) REFERENCES USUARIO(PK_username),
    FOREIGN KEY (FK_username_seguido) REFERENCES USUARIO(PK_username)
);

CREATE TABLE COMENTARIO (
    PK_id_comentario VARCHAR(20) PRIMARY KEY,
    FK_id_publicacion VARCHAR(20) NOT NULL,
    FK_id_comentario_padre VARCHAR(20),
    texto_comentario TEXT NOT NULL,
    cantidad_likes INT,
    estado_moderacion VARCHAR(30),
    fecha_emision DATE NOT NULL,
    hora_emision TIME NOT NULL,
    FOREIGN KEY (FK_id_publicacion) REFERENCES PUBLICACION(PK_id_publicacion),
    FOREIGN KEY (FK_id_comentario_padre) REFERENCES COMENTARIO(PK_id_comentario)
);

CREATE TABLE REACCION_USUARIO_PUBLICACION (
    PK_reaccion VARCHAR(20) PRIMARY KEY,
    FK_username VARCHAR(50) NOT NULL,
    FK_id_publicacion VARCHAR(20) NOT NULL,
    tipo_reaccion VARCHAR(30),
    FOREIGN KEY (FK_username) REFERENCES USUARIO(PK_username),
    FOREIGN KEY (FK_id_publicacion) REFERENCES PUBLICACION(PK_id_publicacion)
);

------------------------------------------------------------------------

INSERT INTO USUARIO (PK_username, correo_electronico, contrasenia_hash, biografia, fecha_alta) VALUES
('juan_dev', 'juan@mail.com', '$2a$12$e8f...hash1', 'Desarrollador de software', '2026-01-10'),
('maria_design', 'maria@mail.com', '$2a$12$a1b...hash2', 'Diseñadora UI/UX', '2026-01-15'),
('carlos_photo', 'carlos@mail.com', '$2a$12$d3e...hash3', 'Fotógrafo de paisajes', '2026-02-01'),
('ana_tech', 'ana@mail.com', '$2a$12$g5h...hash4', 'Entusiasta de la IA', '2026-02-12'),
('luis_gamer', 'luis@mail.com', '$2a$12$j7k...hash5', 'Streamer y creador', '2026-03-05');

INSERT INTO ETIQUETA (PK_nombre_hashtag, cantidad_usos, categoria_tematica, estado_tendencia, fecha_creacion) VALUES
('#coding', 12500, 'Tecnología', 'Alta', '2025-05-10'),
('#design', 8400, 'Arte & Diseño', 'Media', '2025-06-12'),
('#nature', 34000, 'Fotografía', 'Alta', '2024-11-20'),
('#ai', 52000, 'Tecnología', 'Muy Alta', '2025-01-01'),
('#gaming', 29000, 'Entretenimiento', 'Alta', '2025-03-15');

INSERT INTO PUBLICACION (PK_id_publicacion, FK_username, FK_nombre_hashtag, leyenda_descripcion, ubicacion_geo, url_archivo_imagen, fecha_pub, hora_pub) VALUES
('PUB-101', 'juan_dev', '#coding', 'Nuevo proyecto listo', 'Buenos Aires', 'https://img.com/p1.jpg', '2028-10-01', '14:30:00'),
('PUB-102', 'maria_design', '#design', 'Rediseño de interfaz', 'Córdoba', 'https://img.com/p2.jpg', '2028-10-02', '09:15:00'),
('PUB-103', 'carlos_photo', '#nature', 'Atardecer en la montaña', 'Mendoza', 'https://img.com/p3.jpg', '2028-10-03', '18:45:00'),
('PUB-104', 'ana_tech', '#ai', 'Avances en LLMs', 'Rosario', 'https://img.com/p4.jpg', '2028-10-04', '11:20:00'),
('PUB-105', 'luis_gamer', '#gaming', 'Setup actualizado', 'La Plata', 'https://img.com/p5.jpg', '2028-10-05', '22:10:00');

INSERT INTO USUARIO_SIGUE_USUARIO (PK_seguimiento, FK_username_seguidor, FK_username_seguido) VALUES
('SEG-01', 'juan_dev', 'maria_design'),
('SEG-02', 'maria_design', 'carlos_photo'),
('SEG-03', 'carlos_photo', 'ana_tech'),
('SEG-04', 'ana_tech', 'luis_gamer'),
('SEG-05', 'luis_gamer', 'juan_dev');

INSERT INTO COMENTARIO (PK_id_comentario, FK_id_publicacion, FK_id_comentario_padre, texto_comentario, cantidad_likes, estado_moderacion, fecha_emision, hora_emision) VALUES
('COM-01', 'PUB-101', NULL, '¡Excelente trabajo!', 12, 'Aprobado', '2028-10-01', '15:00:00'),
('COM-02', 'PUB-101', 'COM-01', '¡Muchas gracias!', 4, 'Aprobado', '2028-10-01', '15:10:00'),
('COM-03', 'PUB-102', NULL, 'Me encantaron los colores', 8, 'Aprobado', '2028-10-02', '10:00:00'),
('COM-04', 'PUB-103', NULL, '¿Qué cámara usaste?', 2, 'Aprobado', '2028-10-03', '19:00:00'),
('COM-05', 'PUB-105', NULL, 'Increíble monitor', 15, 'Aprobado', '2028-10-05', '22:30:00');

INSERT INTO REACCION_USUARIO_PUBLICACION (PK_reaccion, FK_username, FK_id_publicacion, tipo_reaccion) VALUES
('REAC-01', 'maria_design', 'PUB-101', 'Me gusta'),
('REAC-02', 'carlos_photo', 'PUB-101', 'Me encanta'),
('REAC-03', 'juan_dev', 'PUB-102', 'Me gusta'),
('REAC-04', 'ana_tech', 'PUB-103', 'Me asombra'),
('REAC-05', 'luis_gamer', 'PUB-104', 'Me encanta');