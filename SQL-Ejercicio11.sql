DROP DATABASE IF EXISTS bd_conciertos;
CREATE DATABASE bd_conciertos;
USE bd_conciertos;

CREATE TABLE RECINTO (
    PK_codigo_recinto VARCHAR(20) PRIMARY KEY,
    nombre_recinto VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    ciudad VARCHAR(50) NOT NULL,
    capacidad_max_tot INT NOT NULL
);

CREATE TABLE SECTOR (
    PK_nombre_sector VARCHAR(50) PRIMARY KEY,
    FK_codigo_recinto VARCHAR(20) NOT NULL,
    cant_localidades_disp INT NOT NULL,
    precio_base_ticket DECIMAL(10,2) NOT NULL,
    tipo_ubicacion VARCHAR(30),
    descripcion_zona VARCHAR(150),
    FOREIGN KEY (FK_codigo_recinto) REFERENCES RECINTO(PK_codigo_recinto)
);

CREATE TABLE CONCIERTO (
    PK_id_event VARCHAR(20) PRIMARY KEY,
    FK_codigo_recinto VARCHAR(20) NOT NULL,
    titulo_gira VARCHAR(100) NOT NULL,
    fecha_realiz DATE NOT NULL,
    hora_realiz TIME NOT NULL,
    estado_concierto VARCHAR(30),
    productor_resp VARCHAR(100),
    FOREIGN KEY (FK_codigo_recinto) REFERENCES RECINTO(PK_codigo_recinto)
);

CREATE TABLE CLIENTE (
    PK_DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contrasenia_hash VARCHAR(255) NOT NULL,
    fecha_registro DATE
);

CREATE TABLE COMPRA (
    PK_num_transaccion VARCHAR(20) PRIMARY KEY,
    FK_DNI VARCHAR(20) NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50),
    estado_pago VARCHAR(30),
    fecha_compra DATE NOT NULL,
    hora_compra TIME NOT NULL,
    FOREIGN KEY (FK_DNI) REFERENCES CLIENTE(PK_DNI)
);

CREATE TABLE TICKET (
    PK_codigo_ticket VARCHAR(20) PRIMARY KEY,
    FK_id_event VARCHAR(20) NOT NULL,
    FK_num_transaccion VARCHAR(20) NOT NULL,
    fecha_emision DATE NOT NULL,
    estado_ticket VARCHAR(30),
    numero_butaca_lugar VARCHAR(100),
    precio_final_pagado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FK_id_event) REFERENCES CONCIERTO(PK_id_event),
    FOREIGN KEY (FK_num_transaccion) REFERENCES COMPRA(PK_num_transaccion)
);

------------------------------------------------------------------------

INSERT INTO RECINTO (PK_codigo_recinto, nombre_recinto, direccion, ciudad, capacidad_max_tot) VALUES
('REC-01', 'Movistar Arena', 'Av. Corrientes 6090', 'Buenos Aires', 15000),
('REC-02', 'Luna Park', 'Av. Madero 420', 'Buenos Aires', 8500),
('REC-03', 'Estadio Monumental', 'Av. Figueroa Alcorta 7597', 'Buenos Aires', 84000),
('REC-04', 'Quality Espacio', 'Av. Cruz Roja 200', 'Córdoba', 5000),
('REC-05', 'Arena Maipú', 'Maza y Lateral Sur', 'Mendoza', 6500);

INSERT INTO SECTOR (PK_nombre_sector, FK_codigo_recinto, cant_localidades_disp, precio_base_ticket, tipo_ubicacion, descripcion_zona) VALUES
('Campo VIP', 'REC-01', 1200, 85000.00, 'Pie', 'Cerca del escenario'),
('Platea Baja', 'REC-01', 3500, 60000.00, 'Sentado', 'Visión lateral baja'),
('Cabecera Norte', 'REC-03', 15000, 25000.00, 'Sentado', 'Popular norte'),
('Campo General', 'REC-02', 4000, 40000.00, 'Pie', 'Sin numerar'),
('Platea Central', 'REC-04', 800, 50000.00, 'Sentado', 'Excelente visibilidad');

INSERT INTO CONCIERTO (PK_id_event, FK_codigo_recinto, titulo_gira, fecha_realiz, hora_realiz, estado_concierto, productor_resp) VALUES
('EVT-01', 'REC-01', 'World Tour 2026', '2026-11-15', '21:00:00', 'Confirmado', 'DF Entertainment'),
('EVT-02', 'REC-03', 'Rock & Stadium', '2026-12-02', '20:30:00', 'Venta Activa', 'PopArt Music'),
('EVT-03', 'REC-02', 'Acústico Íntimo', '2026-11-20', '22:00:00', 'Confirmado', 'Fenix Entertainment'),
('EVT-04', 'REC-04', 'Tour Sinfónico', '2026-12-10', '21:30:00', 'Próximamente', 'Garra Producciones'),
('EVT-05', 'REC-05', 'Electronic Night', '2026-12-28', '23:59:00', 'Confirmado', 'Time Warp Arg');

INSERT INTO CLIENTE (PK_DNI, nombre, apellido, correo_electronico, contrasenia_hash, fecha_registro) VALUES
('35123456', 'Juan', 'Pérez', 'juan.perez@gmail.com', '$2a$12$e8...hash1', '2026-01-10'),
('28987654', 'María', 'Gómez', 'maria.gomez@yahoo.com', '$2a$12$a1b...hash2', '2026-02-15'),
('32111222', 'Carlos', 'López', 'carlos.lopez@outlook.com', '$2a$12$d3e...hash3', '2026-03-01'),
('40555666', 'Ana', 'Martínez', 'ana.martinez@gmail.com', '$2a$12$g5h...hash4', '2026-03-20'),
('25789456', 'Luis', 'Rodríguez', 'luis.rodriguez@hotmail.com', '$2a$12$i7k...hash5', '2026-04-05');

INSERT INTO COMPRA (PK_num_transaccion, FK_DNI, monto_total, metodo_pago, estado_pago, fecha_compra, hora_compra) VALUES
('TRX-9001', '35123456', 170000.00, 'Tarjeta Crédito', 'Aprobado', '2026-10-01', '14:22:10'),
('TRX-9002', '28987654', 50000.00, 'Mercado Pago', 'Aprobado', '2026-10-02', '16:05:40'),
('TRX-9003', '32111222', 120000.00, 'Transferencia', 'Pendiente', '2026-10-03', '09:12:00'),
('TRX-9004', '40555666', 80000.00, 'Tarjeta Débito', 'Aprobado', '2026-10-04', '11:45:30'),
('TRX-9005', '25789456', 250000.00, 'Tarjeta Crédito', 'Aprobado', '2026-10-05', '18:30:15');

INSERT INTO TICKET (PK_codigo_ticket, FK_id_event, FK_num_transaccion, fecha_emision, estado_ticket, numero_butaca_lugar, precio_final_pagado) VALUES
('TCK-001', 'EVT-01', 'TRX-9001', '2026-10-01', 'Emitido', 'Fila 2, Asiento 12', 85000.00),
('TCK-002', 'EVT-01', 'TRX-9001', '2026-10-01', 'Emitido', 'Fila 2, Asiento 13', 85000.00),
('TCK-003', 'EVT-02', 'TRX-9002', '2026-10-02', 'Emitido', 'Sector Popular Nte', 50000.00),
('TCK-004', 'EVT-03', 'TRX-9003', '2026-10-03', 'Reservado', 'Fila 5, Asiento 4', 60000.00),
('TCK-005', 'EVT-04', 'TRX-9004', '2026-10-04', 'Emitido', 'Platea Fila 1 As 8', 80000.00);