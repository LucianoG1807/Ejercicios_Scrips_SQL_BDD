DROP DATABASE IF EXISTS bd_alquiler_vehiculos;
CREATE DATABASE bd_alquiler_vehiculos;
USE bd_alquiler_vehiculos;

CREATE TABLE SUCURSAL (
    PK_codigo_sucursal VARCHAR(20) PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    ciudad VARCHAR(50) NOT NULL,
    telefono_contacto VARCHAR(30)
);

CREATE TABLE VEHICULO (
    PK_patente VARCHAR(20) PRIMARY KEY,
    FK_codigo_sucursal VARCHAR(20) NOT NULL,
    numero_chasis VARCHAR(50) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    categoria_vehiculo VARCHAR(30),
    kilometraje_actual INT,
    FOREIGN KEY (FK_codigo_sucursal) REFERENCES SUCURSAL(PK_codigo_sucursal)
);

CREATE TABLE CLIENTE (
    PK_num_documento VARCHAR(20) PRIMARY KEY,
    tipo_documento VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),
    vencimiento_licencia DATE
);

CREATE TABLE CONTRATO_ALQUILER (
    PK_codigo_contrato VARCHAR(20) PRIMARY KEY,
    FK_patente VARCHAR(20) NOT NULL,
    FK_num_documento VARCHAR(20) NOT NULL,
    FK_sucursal_origen VARCHAR(20) NOT NULL,
    FK_sucursal_destino VARCHAR(20) NOT NULL,
    fecha_retiro DATE NOT NULL,
    hora_retiro TIME NOT NULL,
    fecha_devolucion_prev DATE NOT NULL,
    fecha_devolucion_real DATE,
    monto_total_contrato DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FK_patente) REFERENCES VEHICULO(PK_patente),
    FOREIGN KEY (FK_num_documento) REFERENCES CLIENTE(PK_num_documento),
    FOREIGN KEY (FK_sucursal_origen) REFERENCES SUCURSAL(PK_codigo_sucursal),
    FOREIGN KEY (FK_sucursal_destino) REFERENCES SUCURSAL(PK_codigo_sucursal)
);

CREATE TABLE SINIESTRO (
    PK_id_siniestro VARCHAR(20) PRIMARY KEY,
    FK_codigo_contrato VARCHAR(20) NOT NULL,
    fecha_siniestro DATE NOT NULL,
    hora_siniestro TIME NOT NULL,
    descripcion_danos TEXT NOT NULL,
    costo_estimado_rep DECIMAL(10,2) NOT NULL,
    compania_aseguradora VARCHAR(100),
    FOREIGN KEY (FK_codigo_contrato) REFERENCES CONTRATO_ALQUILER(PK_codigo_contrato)
);

------------------------------------------------------------------------

INSERT INTO SUCURSAL (PK_codigo_sucursal, nombre_sucursal, direccion, ciudad, telefono_contacto) VALUES
('SUC-01', 'Central Buenos Aires', 'Av. Corrientes 1500', 'Buenos Aires', '011-4333-2211'),
('SUC-02', 'Aeropuerto Ezeiza', 'Autopista Riccheri Km 33.5', 'Ezeiza', '011-5480-1100'),
('SUC-03', 'Córdoba Centro', 'Bv. San Juan 450', 'Córdoba', '0351-422-9988'),
('SUC-04', 'Mendoza Cuyo', 'Av. San Martín 800', 'Mendoza', '0261-429-3344'),
('SUC-05', 'Mar del Plata Costa', 'Av. Colón 2100', 'Mar del Plata', '0223-491-7766');

INSERT INTO VEHICULO (PK_patente, FK_codigo_sucursal, numero_chasis, marca, modelo, categoria_vehiculo, kilometraje_actual) VALUES
('AF123ZZ', 'SUC-01', '8A991203481', 'Volkswagen', 'Polo', 'Compacto', 15000),
('AG456YY', 'SUC-02', '9B112034982', 'Toyota', 'Hilux', 'Pickup', 32000),
('AH789XX', 'SUC-03', '7C554321098', 'Fiat', 'Cronos', 'Sedán', 18500),
('AI012WW', 'SUC-04', '4D887654321', 'Jeep', 'Renegade', 'SUV', 12000),
('AJ345VV', 'SUC-05', '2E334455667', 'Peugeot', '208', 'Compacto', 9500);

INSERT INTO CLIENTE (PK_num_documento, tipo_documento, nombre, apellido, telefono, vencimiento_licencia) VALUES
('32111222', 'DNI', 'Federico', 'López', '011-5555-1234', '2028-09-12'),
('28444555', 'DNI', 'Sofía', 'Díaz', '011-6666-4321', '2027-05-20'),
('25777888', 'DNI', 'Martín', 'Gómez', '0351-777-8899', '2029-01-15'),
('35888999', 'DNI', 'Lucía', 'Benítez', '0261-555-4433', '2030-11-04'),
('22999000', 'DNI', 'Andrés', 'Silva', '0223-444-1122', '2027-08-30');

INSERT INTO CONTRATO_ALQUILER (PK_codigo_contrato, FK_patente, FK_num_documento, FK_sucursal_origen, FK_sucursal_destino, fecha_retiro, hora_retiro, fecha_devolucion_prev, fecha_devolucion_real, monto_total_contrato) VALUES
('CNT-01', 'AF123ZZ', '32111222', 'SUC-01', 'SUC-02', '2026-10-01', '10:00:00', '2026-10-05', '2026-10-05', 4500.00),
('CNT-02', 'AG456YY', '28444555', 'SUC-02', 'SUC-02', '2026-10-03', '14:30:00', '2026-10-10', NULL, 9800.00),
('CNT-03', 'AH789XX', '25777888', 'SUC-03', 'SUC-03', '2026-10-06', '09:15:00', '2026-10-12', '2026-10-12', 5200.00),
('CNT-04', 'AI012WW', '35888999', 'SUC-04', 'SUC-01', '2026-10-10', '11:00:00', '2026-10-15', NULL, 7500.00),
('CNT-05', 'AJ345VV', '22999000', 'SUC-05', 'SUC-05', '2026-10-12', '16:00:00', '2026-10-18', NULL, 4900.00);

INSERT INTO SINIESTRO (PK_id_siniestro, FK_codigo_contrato, fecha_siniestro, hora_siniestro, descripcion_danos, costo_estimado_rep, compania_aseguradora) VALUES
('SIN-01', 'CNT-02', '2026-10-04', '08:15:00', 'Rayón en guardabarros trasero', 75000.00, 'Sancor Seguros'),
('SIN-02', 'CNT-04', '2026-10-11', '15:40:00', 'Rotura de parabrisas por piedra', 150000.00, 'Federación Patronal'),
('SIN-03', 'CNT-01', '2026-10-02', '19:20:00', 'Choque menor paragolpes', 120000.00, 'La Caja'),
('SIN-04', 'CNT-03', '2026-10-07', '12:00:00', 'Bollito en puerta delantera', 50000.00, 'Sancor Seguros'),
('SIN-05', 'CNT-05', '2026-10-13', '10:10:00', 'Falla de neumáticos', 90000.00, 'Zurich');