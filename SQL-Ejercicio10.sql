DROP DATABASE IF EXISTS bd_flota_vehicular;
CREATE DATABASE bd_flota_vehicular;
USE bd_flota_vehicular;

CREATE TABLE VEHICULO (
    PK_patente VARCHAR(20) PRIMARY KEY,
    numero_chasis VARCHAR(50) UNIQUE NOT NULL,
    anio_fabricacion INT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    kilometraje_actual INT
);

CREATE TABLE TALLER_MECANICO (
    PK_CUIT VARCHAR(20) PRIMARY KEY,
    nombre_taller VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    contacto VARCHAR(30),
    red_social VARCHAR(50)
);

CREATE TABLE CHOFER (
    PK_legajo_chofer VARCHAR(20) PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    categoria_licencia VARCHAR(30),
    fecha_venc_licencia DATE
);

CREATE TABLE CARGA_COMBUSTIBLE (
    PK_id_carga VARCHAR(20) PRIMARY KEY,
    FK_patente VARCHAR(20) NOT NULL,
    fecha_carga DATE NOT NULL,
    hora_carga TIME NOT NULL,
    cantidad_litros DECIMAL(10,2) NOT NULL,
    costo_por_litro DECIMAL(10,2) NOT NULL,
    odometro_km INT,
    FOREIGN KEY (FK_patente) REFERENCES VEHICULO(PK_patente)
);

CREATE TABLE MANTENIMIENTO (
    PK_id_mantenimiento VARCHAR(20) PRIMARY KEY,
    FK_patente VARCHAR(20) NOT NULL,
    FK_CUIT VARCHAR(20) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    tiempo_estimado VARCHAR(30),
    costo_total_rep DECIMAL(10,2) NOT NULL,
    tipo_mantenimiento VARCHAR(30),
    fecha_entrega DATE,
    FOREIGN KEY (FK_patente) REFERENCES VEHICULO(PK_patente),
    FOREIGN KEY (FK_CUIT) REFERENCES TALLER_MECANICO(PK_CUIT)
);

CREATE TABLE VIAJE (
    PK_id_viaje VARCHAR(20) PRIMARY KEY,
    FK_patente VARCHAR(20) NOT NULL,
    fecha_salida DATE NOT NULL,
    fecha_lleg_est DATE,
    ciudad_origen VARCHAR(50) NOT NULL,
    ciudad_destino VARCHAR(50) NOT NULL,
    hora_lleg_estimada TIME,
    fecha_llegada DATE,
    FOREIGN KEY (FK_patente) REFERENCES VEHICULO(PK_patente)
);

CREATE TABLE ASIGNACION_VIAJE_CHOFER (
    PK_asignacion INT PRIMARY KEY,
    FK_id_viaje VARCHAR(20) NOT NULL,
    FK_legajo_chofer VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_viaje) REFERENCES VIAJE(PK_id_viaje),
    FOREIGN KEY (FK_legajo_chofer) REFERENCES CHOFER(PK_legajo_chofer)
);

------------------------------------------------------------------------

INSERT INTO VEHICULO (PK_patente, numero_chasis, anio_fabricacion, marca, modelo, kilometraje_actual) VALUES
('AB123CD', '8AN34982301', 2022, 'Mercedes-Benz', 'Sprinter', 45000),
('EF456GH', '9BF12345678', 2021, 'Ford', 'Transit', 68000),
('IJ789KL', '7CC98765432', 2023, 'Iveco', 'Daily', 22000),
('MN012OP', '4DD55544332', 2020, 'Renault', 'Master', 95000),
('QR345ST', '2EE11122334', 2024, 'Peugeot', 'Boxer', 12000);

INSERT INTO TALLER_MECANICO (PK_CUIT, nombre_taller, direccion, contacto, red_social) VALUES
('30-71112223-9', 'Mecánica Total S.A.', 'Av. Warnes 1200', '011-4555-1234', '@mecanicatotal'),
('30-68889994-1', 'Talleres Rápido S.R.L.', 'Juan B. Justo 450', '011-4777-5678', '@talleresrapido'),
('30-52223331-4', 'Servicios Diesel Norte', 'Panamericana Km 30', '03327-44-8899', '@dieselnorte'),
('30-71998882-5', 'Boxer Express', 'Ruta 8 Km 22', '011-4668-3322', '@boxerexpress'),
('30-61234567-8', 'Electromecánica Integral', 'Corrientes 3200', '011-4888-9900', '@electrointegral');

INSERT INTO CHOFER (PK_legajo_chofer, DNI, nombre, apellido, fecha_nacimiento, categoria_licencia, fecha_venc_licencia) VALUES
('CH-501', '28456789', 'Esteban', 'Quito', '1982-05-14', 'Profesional E', '2028-05-14'),
('CH-502', '32111222', 'Marcos', 'Juárez', '1988-11-20', 'Profesional D', '2027-11-20'),
('CH-503', '25789456', 'Valeria', 'Ríos', '1979-03-05', 'Profesional E', '2029-03-05'),
('CH-504', '35444555', 'Gastón', 'Peralta', '1992-08-12', 'Profesional C', '2027-08-12'),
('CH-505', '30999888', 'Lorena', 'Acosta', '1985-12-01', 'Profesional E', '2030-12-01');

INSERT INTO CARGA_COMBUSTIBLE (PK_id_carga, FK_patente, fecha_carga, hora_carga, cantidad_litros, costo_por_litro, odometro_km) VALUES
('CG-01', 'AB123CD', '2026-10-01', '08:30:00', 60.0, 1.25, 44500),
('CG-02', 'EF456GH', '2026-10-03', '14:15:00', 75.5, 1.25, 67500),
('CG-03', 'IJ789KL', '2026-10-05', '09:00:00', 50.0, 1.30, 21800),
('CG-04', 'MN012OP', '2026-10-08', '16:45:00', 80.0, 1.25, 94200),
('CG-05', 'QR345ST', '2026-10-10', '11:20:00', 40.0, 1.30, 11800);

INSERT INTO MANTENIMIENTO (PK_id_mantenimiento, FK_patente, FK_CUIT, fecha_ingreso, tiempo_estimado, costo_total_rep, tipo_mantenimiento, fecha_entrega) VALUES
('MANT-01', 'AB123CD', '30-71112223-9', '2026-09-10', '2 días', 350.00, 'Preventivo', '2026-09-12'),
('MANT-02', 'EF456GH', '30-68889994-1', '2026-09-15', '3 días', 500.00, 'Correctivo', '2026-09-18'),
('MANT-03', 'IJ789KL', '30-52223331-4', '2026-09-20', '1 día', 180.00, 'Preventivo', '2026-09-21'),
('MANT-04', 'MN012OP', '30-71998882-5', '2026-09-25', '4 días', 1200.00, 'Correctivo', '2026-09-29'),
('MANT-05', 'QR345ST', '30-61234567-8', '2026-10-02', '1 día', 220.00, 'Preventivo', '2026-10-03');

INSERT INTO VIAJE (PK_id_viaje, FK_patente, fecha_salida, fecha_lleg_est, ciudad_origen, ciudad_destino, hora_lleg_estimada, fecha_llegada) VALUES
('VIAJ-101', 'AB123CD', '2026-10-12', '2026-10-13', 'Buenos Aires', 'Rosario', '14:00:00', '2026-10-13'),
('VIAJ-102', 'EF456GH', '2026-10-14', '2026-10-16', 'Córdoba', 'Mendoza', '18:30:00', '2026-10-16'),
('VIAJ-103', 'IJ789KL', '2026-10-15', '2026-10-17', 'Buenos Aires', 'Bariloche', '12:00:00', '2026-10-17'),
('VIAJ-104', 'MN012OP', '2026-10-18', '2026-10-19', 'La Plata', 'Mar del Plata', '15:00:00', '2026-10-19'),
('VIAJ-105', 'QR345ST', '2026-10-20', '2026-10-21', 'Santa Fe', 'Corrientes', '10:00:00', '2026-10-21');

INSERT INTO ASIGNACION_VIAJE_CHOFER (PK_asignacion, FK_id_viaje, FK_legajo_chofer) VALUES
(1, 'VIAJ-101', 'CH-501'),
(2, 'VIAJ-102', 'CH-502'),
(3, 'VIAJ-103', 'CH-503'),
(4, 'VIAJ-104', 'CH-504'),
(5, 'VIAJ-105', 'CH-505');