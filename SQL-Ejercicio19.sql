DROP DATABASE IF EXISTS bd_crowdfunding;
CREATE DATABASE bd_crowdfunding;
USE bd_crowdfunding;

CREATE TABLE USUARIO_CREADOR (
    PK_id_usuario_cr VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    pais_residencia VARCHAR(50),
    datos_pago VARCHAR(100),
    datos_cobro VARCHAR(100)
);

CREATE TABLE PROYECTO (
    PK_codigo_proyecto VARCHAR(20) PRIMARY KEY,
    FK_id_usuario_cr VARCHAR(20) NOT NULL,
    titulo_proyecto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    descripcion_det TEXT,
    objetivo_financiero DECIMAL(12,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_cierre DATE NOT NULL,
    estado_financian VARCHAR(30),
    FOREIGN KEY (FK_id_usuario_cr) REFERENCES USUARIO_CREADOR(PK_id_usuario_cr)
);

CREATE TABLE RECOMPENSA_TIER (
    PK_id_recompensa VARCHAR(20) PRIMARY KEY,
    FK_codigo_proyecto VARCHAR(20) NOT NULL,
    titulo_recompensa VARCHAR(100) NOT NULL,
    descripcion_incluye TEXT,
    valor_minimo DECIMAL(10,2) NOT NULL,
    cantidad_max_unidades INT,
    fecha_estimada_entrega DATE,
    FOREIGN KEY (FK_codigo_proyecto) REFERENCES PROYECTO(PK_codigo_proyecto)
);

CREATE TABLE APORTE_PLEDGE (
    PK_id_aporte VARCHAR(20) PRIMARY KEY,
    FK_id_usuario_cr VARCHAR(20) NOT NULL,
    `FK_codigo_proyecto (Recibe)` VARCHAR(20) NOT NULL,
    fecha_trans DATE NOT NULL,
    hora_trans TIME NOT NULL,
    monto_aportado DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50),
    estado_pago VARCHAR(30),
    FOREIGN KEY (FK_id_usuario_cr) REFERENCES USUARIO_CREADOR(PK_id_usuario_cr),
    FOREIGN KEY (`FK_codigo_proyecto (Recibe)`) REFERENCES PROYECTO(PK_codigo_proyecto)
);

------------------------------------------------------------------------

INSERT INTO USUARIO_CREADOR (PK_id_usuario_cr, nombre, apellido, correo_electronico, pais_residencia, datos_pago, datos_cobro) VALUES
('USR-01', 'Martín', 'Palermo', 'martin.p@crowd.com', 'Argentina', 'Visa ending 4092', 'Stripe ACC-991'),
('USR-02', 'Romina', 'Gaetani', 'romina.g@crowd.com', 'España', 'Mastercard 8821', 'PayPal ACC-554'),
('USR-03', 'Lucas', 'Pratto', 'lucas.p@crowd.com', 'México', 'Visa ending 1104', 'Stripe ACC-123'),
('USR-04', 'Valeria', 'Bertuccelli', 'valeria.b@crowd.com', 'Chile', 'Amex ending 3012', 'PayPal ACC-778'),
('USR-05', 'Gonzalo', 'Heredia', 'gonzalo.h@crowd.com', 'Colombia', 'Visa ending 5560', 'Stripe ACC-345');

INSERT INTO PROYECTO (PK_codigo_proyecto, FK_id_usuario_cr, titulo_proyecto, categoria, descripcion_det, objetivo_financiero, fecha_inicio, fecha_cierre, estado_financian) VALUES
('PRJ-101', 'USR-01', 'Videojuego Indie RPG', 'Tecnología', 'RPG táctico en desarrollo con Unreal Engine', 50000.00, '2026-10-01', '2026-12-01', 'En Curso'),
('PRJ-102', 'USR-02', 'Documental Ecosistemas', 'Cine / Video', 'Filmación de la Patagonia Austral', 25000.00, '2026-09-15', '2026-11-15', 'En Curso'),
('PRJ-103', 'USR-03', 'Cafetera IoT Inteligente', 'Diseño / Hardware', 'Control de café por app móvil con Wi-Fi', 80000.00, '2026-08-01', '2026-10-01', 'Financiado Exitoso'),
('PRJ-104', 'USR-04', 'Novela Gráfica Sci-Fi', 'Editorial', 'Libro impreso tapa dura de 200 páginas', 15000.00, '2026-10-10', '2026-12-10', 'En Curso'),
('PRJ-105', 'USR-05', 'Zapatillas Ecológicas', 'Moda', 'Calzado fabricado con plástico reciclado del mar', 100000.00, '2026-07-01', '2026-09-01', 'Financiado Exitoso');

INSERT INTO RECOMPENSA_TIER (PK_id_recompensa, FK_codigo_proyecto, titulo_recompensa, descripcion_incluye, valor_minimo, cantidad_max_unidades, fecha_estimada_entrega) VALUES
('REC-501', 'PRJ-101', 'Copia Digital del Juego', 'Acceso anticipado Steam + Soundtrack', 25.00, 1000, '2027-03-01'),
('REC-502', 'PRJ-102', 'Proyección Exclusiva Online', 'Streaming privado y créditos del film', 15.00, 500, '2027-01-15'),
('REC-503', 'PRJ-103', 'Cafetera Edición Fundador', 'Equipo completo + 1kg de café gourmet', 150.00, 300, '2026-12-15'),
('REC-504', 'PRJ-104', 'Novela Gráfica Física', 'Libro autografiado y marcalibre de regalo', 35.00, 400, '2027-02-28'),
('REC-505', 'PRJ-105', 'Par de Zapatillas Eco', 'Envío gratis a todo el mundo + diseño a elección', 90.00, 600, '2026-11-01');

INSERT INTO APORTE_PLEDGE (PK_id_aporte, FK_id_usuario_cr, `FK_codigo_proyecto (Recibe)`, fecha_trans, hora_trans, monto_aportado, metodo_pago, estado_pago) VALUES
('APT-901', 'USR-02', 'PRJ-101', '2026-10-02', '14:20:00', 30.00, 'Tarjeta de Crédito', 'Aprobado'),
('APT-902', 'USR-03', 'PRJ-102', '2026-09-18', '09:15:00', 20.00, 'PayPal', 'Aprobado'),
('APT-903', 'USR-04', 'PRJ-103', '2026-08-05', '18:40:00', 150.00, 'Tarjeta de Crédito', 'Aprobado'),
('APT-904', 'USR-01', 'PRJ-104', '2026-10-11', '11:00:00', 50.00, 'Stripe', 'Aprobado'),
('APT-905', 'USR-05', 'PRJ-105', '2026-07-10', '16:50:00', 100.00, 'Tarjeta de Crédito', 'Aprobado');