DROP DATABASE IF EXISTS bd_coworking;
CREATE DATABASE bd_coworking;
USE bd_coworking;

CREATE TABLE ESPACIO_TRABAJO (
    PK_codigo_espacio VARCHAR(20) PRIMARY KEY,
    nombre_espacio VARCHAR(100) NOT NULL,
    tipo_espacio VARCHAR(50) NOT NULL,
    capacidad_max INT NOT NULL,
    tarifa_hora_jornada DECIMAL(10,2) NOT NULL
);

CREATE TABLE MIEMBRO (
    PK_DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    empresa_pertenencia VARCHAR(100),
    id_tarjeta_rfid VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE RESERVA (
    PK_codigo_reserva VARCHAR(20) PRIMARY KEY,
    FK_codigo_espacio VARCHAR(20) NOT NULL,
    FK_DNI VARCHAR(20) NOT NULL,
    fecha_uso DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado_reserva VARCHAR(30),
    FOREIGN KEY (FK_codigo_espacio) REFERENCES ESPACIO_TRABAJO(PK_codigo_espacio),
    FOREIGN KEY (FK_DNI) REFERENCES MIEMBRO(PK_DNI)
);

CREATE TABLE CONTROL_ACCESO (
    PK_id_fichaje VARCHAR(20) PRIMARY KEY,
    `FK_DNI (Genera)` VARCHAR(20) NOT NULL,
    fecha_exacta DATE NOT NULL,
    hora_exacta TIME NOT NULL,
    sentido_movimiento VARCHAR(30) NOT NULL,
    codigo_tarjeta_leida VARCHAR(50) NOT NULL,
    estado_validacion VARCHAR(50),
    FOREIGN KEY (`FK_DNI (Genera)`) REFERENCES MIEMBRO(PK_DNI)
);

CREATE TABLE CONSUMO_ADICIONAL (
    PK_id_consumo VARCHAR(20) PRIMARY KEY,
    `FK_DNI (Registra)` VARCHAR(20) NOT NULL,
    descripcion_item VARCHAR(150) NOT NULL,
    cantidad_unidades INT NOT NULL,
    costo_total_item DECIMAL(10,2) NOT NULL,
    fecha_consumo DATE NOT NULL,
    hora_consumo TIME NOT NULL,
    FOREIGN KEY (`FK_DNI (Registra)`) REFERENCES MIEMBRO(PK_DNI)
);

------------------------------------------------------------------------

INSERT INTO ESPACIO_TRABAJO (PK_codigo_espacio, nombre_espacio, tipo_espacio, capacidad_max, tarifa_hora_jornada) VALUES
('ESP-01', 'Sala Innovación', 'Sala de Reuniones', 12, 15000.00),
('ESP-02', 'Escritorio Flexible A1', 'Hot Desk', 1, 3500.00),
('ESP-03', 'Oficina Privada C', 'Oficina Privada', 4, 28000.00),
('ESP-04', 'Auditorio Principal', 'Eventos', 50, 65000.00),
('ESP-05', 'Cabina Zoom 1', 'Phone Booth', 1, 4500.00);

INSERT INTO MIEMBRO (PK_DNI, nombre, apellido, correo_electronico, empresa_pertenencia, id_tarjeta_rfid) VALUES
('32111222', 'Luciano', 'Gómez', 'l.gomez@tech.com', 'TechSolutions', 'RFID-9011'),
('28444555', 'Sofía', 'Martínez', 's.martinez@design.com', 'Studio Design', 'RFID-9012'),
('25777888', 'Agustín', 'Rossi', 'a.rossi@fintech.io', 'Fintech Latam', 'RFID-9013'),
('35888999', 'Camila', 'Torres', 'c.torres@freelance.com', 'Independiente', 'RFID-9014'),
('22999000', 'Gonzalo', 'Montiel', 'g.montiel@global.com', 'Global Corp', 'RFID-9015');

INSERT INTO RESERVA (PK_codigo_reserva, FK_codigo_espacio, FK_DNI, fecha_uso, hora_inicio, hora_fin, estado_reserva) VALUES
('RES-101', 'ESP-01', '32111222', '2026-10-16', '09:00:00', '11:00:00', 'Confirmada'),
('RES-102', 'ESP-02', '28444555', '2026-10-16', '08:00:00', '17:00:00', 'En Uso'),
('RES-103', 'ESP-03', '25777888', '2026-10-17', '14:00:00', '18:00:00', 'Pendiente'),
('RES-104', 'ESP-05', '35888999', '2026-10-16', '11:30:00', '12:30:00', 'Finalizada'),
('RES-105', 'ESP-04', '22999000', '2026-10-20', '10:00:00', '13:00:00', 'Confirmada');

INSERT INTO CONTROL_ACCESO (PK_id_fichaje, `FK_DNI (Genera)`, fecha_exacta, hora_exacta, sentido_movimiento, codigo_tarjeta_leida, estado_validacion) VALUES
('ACC-501', '32111222', '2026-10-16', '08:52:10', 'Entrada', 'RFID-9011', 'Autorizado'),
('ACC-502', '28444555', '2026-10-16', '07:58:40', 'Entrada', 'RFID-9012', 'Autorizado'),
('ACC-503', '35888999', '2026-10-16', '11:25:00', 'Entrada', 'RFID-9014', 'Autorizado'),
('ACC-504', '35888999', '2026-10-16', '12:35:15', 'Salida', 'RFID-9014', 'Autorizado'),
('ACC-505', '25777888', '2026-10-16', '18:00:05', 'Entrada', 'RFID-9013', 'Rechazado (Fuera Horario)');

INSERT INTO CONSUMO_ADICIONAL (PK_id_consumo, `FK_DNI (Registra)`, descripcion_item, cantidad_unidades, costo_total_item, fecha_consumo, hora_consumo) VALUES
('CNS-701', '32111222', 'Café Espresso Doble', 2, 3600.00, '2026-10-16', '10:15:00'),
('CNS-702', '28444555', 'Impresiones Color A4', 15, 4500.00, '2026-10-16', '11:40:00'),
('CNS-703', '32111222', 'Agua Mineral 500ml', 1, 1200.00, '2026-10-16', '12:10:00'),
('CNS-704', '35888999', 'Snack Saludable Nutty', 1, 2200.00, '2026-10-16', '12:00:00'),
('CNS-705', '22999000', 'Servicio Catering Coffee Break', 1, 35000.00, '2026-10-15', '16:30:00');