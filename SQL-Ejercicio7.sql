DROP DATABASE IF EXISTS bd_hotel;
CREATE DATABASE bd_hotel;
USE bd_hotel;

CREATE TABLE HOTEL (
    PK_codigo_hotel VARCHAR(20) PRIMARY KEY,
    nombre_hotel VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    categoria_estrellas VARCHAR(30)
);

CREATE TABLE HUESPED (
    PK_num_documento VARCHAR(20) PRIMARY KEY,
    tipo_documento VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono_contacto VARCHAR(30),
    direccion_postal VARCHAR(150)
);

CREATE TABLE HABITACION (
    PK_num_habitacion INT PRIMARY KEY,
    FK_codigo_hotel VARCHAR(20) NOT NULL,
    tipo_habitacion VARCHAR(50) NOT NULL,
    piso_ubicacion VARCHAR(30),
    tarifa_diaria_base DECIMAL(10,2) NOT NULL,
    estado_limpieza VARCHAR(30),
    capacidad_max INT NOT NULL,
    FOREIGN KEY (FK_codigo_hotel) REFERENCES HOTEL(PK_codigo_hotel)
);

CREATE TABLE RESERVA (
    PK_codigo_reserva VARCHAR(20) PRIMARY KEY,
    FK_num_documento VARCHAR(20) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_inicio_estancia DATE NOT NULL,
    fecha_fin_estancia DATE NOT NULL,
    monto_total_estim DECIMAL(10,2) NOT NULL,
    estado_reserva VARCHAR(30),
    FOREIGN KEY (FK_num_documento) REFERENCES HUESPED(PK_num_documento)
);

CREATE TABLE DETALLE_RESERVA_HABITACION (
    PK_detalle_reserva_habitacion INT PRIMARY KEY,
    FK_codigo_reserva VARCHAR(20) NOT NULL,
    FK_num_habitacion INT NOT NULL,
    FOREIGN KEY (FK_codigo_reserva) REFERENCES RESERVA(PK_codigo_reserva),
    FOREIGN KEY (FK_num_habitacion) REFERENCES HABITACION(PK_num_habitacion)
);

CREATE TABLE CONSUMO (
    PK_codigo_consumo VARCHAR(20) PRIMARY KEY,
    FK_codigo_reserva VARCHAR(20) NOT NULL,
    fecha_consumo DATE NOT NULL,
    hora_consumo TIME NOT NULL,
    descripcion_serv VARCHAR(150) NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FK_codigo_reserva) REFERENCES RESERVA(PK_codigo_reserva)
);

------------------------------------------------------------------------

INSERT INTO HOTEL (PK_codigo_hotel, nombre_hotel, direccion, ciudad, pais, categoria_estrellas) VALUES
('H001', 'Gran Hotel Central', 'Av. Corrientes 500', 'Buenos Aires', 'Argentina', '4 Estrellas'),
('H002', 'Resort Playa Blanca', 'Ruta 10 Km 15', 'Punta del Este', 'Uruguay', '5 Estrellas'),
('H003', 'Hotel Andino', 'San Martín 1200', 'Mendoza', 'Argentina', '3 Estrellas'),
('H004', 'Patagonia Lodge', 'Av. Bustillo Km 4', 'Bariloche', 'Argentina', '4 Estrellas'),
('H005', 'City Express', 'Reforma 250', 'CDMX', 'México', '3 Estrellas');

INSERT INTO HUESPED (PK_num_documento, tipo_documento, nombre, apellido, telefono_contacto, direccion_postal) VALUES
('35123456', 'DNI', 'Carlos', 'Gómez', '+5491155551234', 'Av. Santa Fe 2000, CABA'),
('28987654', 'DNI', 'Lucía', 'Fernández', '+549116665678', 'Belgrano 456, Córdoba'),
('X9876543', 'Pasaporte', 'John', 'Smith', '+13055557890', '742 Evergreen Terrace, Miami'),
('18765432', 'DNI', 'Roberto', 'Sánchez', '+5492614444333', 'San Lorenzo 890, Mendoza'),
('42333444', 'DNI', 'Martina', 'López', '+5492944222111', 'Mitre 123, Bariloche');

INSERT INTO HABITACION (PK_num_habitacion, FK_codigo_hotel, tipo_habitacion, piso_ubicacion, tarifa_diaria_base, estado_limpieza, capacidad_max) VALUES
(101, 'H001', 'Single Standard', 'Piso 1', 80.00, 'Limpia', 1),
(202, 'H001', 'Doble Deluxe', 'Piso 2', 150.00, 'Limpia', 2),
(305, 'H002', 'Suite Vista al Mar', 'Piso 3', 320.00, 'Limpia', 3),
(102, 'H003', 'Doble Standard', 'Piso 1', 110.00, 'Ocupada', 2),
(401, 'H004', 'Cabaña Familiar', 'Piso 4', 250.00, 'Limpia', 5);

INSERT INTO RESERVA (PK_codigo_reserva, FK_num_documento, fecha_emision, fecha_inicio_estancia, fecha_fin_estancia, monto_total_estim, estado_reserva) VALUES
('RES-501', '35123456', '2026-10-01', '2026-11-10', '2026-11-15', 750.00, 'Confirmada'),
('RES-502', '28987654', '2026-10-05', '2026-12-01', '2026-12-07', 2240.00, 'Pendiente'),
('RES-503', 'X9876543', '2026-10-10', '2026-11-20', '2026-11-25', 1600.00, 'Confirmada'),
('RES-504', '18765432', '2026-10-12', '2026-10-25', '2026-10-28', 330.00, 'Cancelada'),
('RES-505', '42333444', '2026-10-15', '2026-12-15', '2026-12-22', 1750.00, 'Confirmada');

INSERT INTO DETALLE_RESERVA_HABITACION (PK_detalle_reserva_habitacion, FK_codigo_reserva, FK_num_habitacion) VALUES
(1, 'RES-501', 202),
(2, 'RES-502', 305),
(3, 'RES-503', 101),
(4, 'RES-504', 102),
(5, 'RES-505', 401);

INSERT INTO CONSUMO (PK_codigo_consumo, FK_codigo_reserva, fecha_consumo, hora_consumo, descripcion_serv, costo_total) VALUES
('CONS-01', 'RES-501', '2026-11-11', '20:30:00', 'Cena en Restaurante', 85.50),
('CONS-02', 'RES-501', '2026-11-12', '09:15:00', 'Desayuno Buffet', 25.00),
('CONS-03', 'RES-502', '2026-12-02', '15:45:00', 'Spa & Masajes', 120.00),
('CONS-04', 'RES-503', '2026-11-21', '18:00:00', 'Lavandería Express', 45.00),
('CONS-05', 'RES-505', '2026-12-16', '22:10:00', 'Minibar', 35.00);