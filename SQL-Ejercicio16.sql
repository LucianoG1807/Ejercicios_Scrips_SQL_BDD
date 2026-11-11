DROP DATABASE IF EXISTS bd_inmobiliaria;
CREATE DATABASE bd_inmobiliaria;
USE bd_inmobiliaria;

CREATE TABLE PROPIETARIO (
    PK_cuit_dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono_contacto VARCHAR(30),
    correo_electronico VARCHAR(100) NOT NULL,
    direccion_postal VARCHAR(150)
);

CREATE TABLE EMPLEADO (
    PK_legajo_empleado VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    porcentaje_comision DECIMAL(5,2) NOT NULL
);

CREATE TABLE INQUILINO (
    PK_dni_pasaporte VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono_contacto VARCHAR(30),
    correo_electronico VARCHAR(100) NOT NULL,
    garantia_respaldo VARCHAR(100)
);

CREATE TABLE PROPIEDAD (
    PK_codigo_catastral VARCHAR(20) PRIMARY KEY,
    FK_cuit_dni VARCHAR(20) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    cantidad_ambientes INT NOT NULL,
    precio_tasacion DECIMAL(12,2) NOT NULL,
    tipo_propiedad VARCHAR(50) NOT NULL,
    superficie_m2 INT NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    FOREIGN KEY (FK_cuit_dni) REFERENCES PROPIETARIO(PK_cuit_dni)
);

CREATE TABLE CONTRATO_LOCACION (
    PK_codigo_contrato VARCHAR(20) PRIMARY KEY,
    FK_codigo_catastral VARCHAR(20) NOT NULL,
    FK_legajo_empleado VARCHAR(20) NOT NULL,
    FK_dni_pasaporte VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE NOT NULL,
    monto_mensual_canon DECIMAL(12,2) NOT NULL,
    deposito_garantia DECIMAL(12,2) NOT NULL,
    modalidad_operacion VARCHAR(50),
    FOREIGN KEY (FK_codigo_catastral) REFERENCES PROPIEDAD(PK_codigo_catastral),
    FOREIGN KEY (FK_legajo_empleado) REFERENCES EMPLEADO(PK_legajo_empleado),
    FOREIGN KEY (FK_dni_pasaporte) REFERENCES INQUILINO(PK_dni_pasaporte)
);

CREATE TABLE PAGO_MENSUAL (
    PK_id_pago VARCHAR(20) PRIMARY KEY,
    FK_codigo_contrato VARCHAR(20) NOT NULL,
    periodo_abonado VARCHAR(20) NOT NULL,
    fecha_efectiva_pago DATE NOT NULL,
    monto_abonado DECIMAL(12,2) NOT NULL,
    medio_pago VARCHAR(50),
    recargo_mora DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FK_codigo_contrato) REFERENCES CONTRATO_LOCACION(PK_codigo_contrato)
);

------------------------------------------------------------------------

INSERT INTO PROPIETARIO (PK_cuit_dni, nombre, apellido, telefono_contacto, correo_electronico, direccion_postal) VALUES
('20-25444333-3', 'Alberto', 'Giménez', '011-4555-9876', 'a.gimenez@mail.com', 'Av. Santa Fe 2300'),
('27-30111222-4', 'Beatriz', 'Suárez', '011-4777-1122', 'b.suarez@mail.com', 'Arenales 1450'),
('20-18999888-1', 'Carlos', 'Paz', '0351-422-3344', 'c.paz@mail.com', 'Bv. Chacabuco 800'),
('27-24555666-9', 'Daniela', 'Ríos', '0261-429-0011', 'd.rios@mail.com', 'Emilio Civit 500'),
('20-35111444-5', 'Esteban', 'Lamothe', '0223-491-2233', 'e.lamothe@mail.com', 'Colón 1800');

INSERT INTO EMPLEADO (PK_legajo_empleado, nombre, apellido, DNI, porcentaje_comision) VALUES
('EMP-101', 'Martín', 'Fierro', '28111222', 5.0),
('EMP-102', 'Carla', 'Pérez', '32444555', 4.5),
('EMP-103', 'Lucas', 'Benítez', '25777888', 6.0),
('EMP-104', 'Valeria', 'Mazzini', '35888999', 5.5),
('EMP-105', 'Diego', 'Torres', '22999000', 4.0);

INSERT INTO INQUILINO (PK_dni_pasaporte, nombre, apellido, telefono_contacto, correo_electronico, garantia_respaldo) VALUES
('34123456', 'Hernán', 'Crespo', '011-5111-2233', 'h.crespo@mail.com', 'Garantía Propietaria CABA'),
('29888777', 'Julieta', 'Díaz', '011-5333-4455', 'j.diaz@mail.com', 'Finaer Seguros'),
('31444555', 'Gonzalo', 'Higuaín', '0351-566-7788', 'g.higuain@mail.com', 'Caución Bancaria'),
('36777888', 'Florencia', 'Bertotti', '0261-588-9900', 'f.bertotti@mail.com', 'Garantía Propietaria Mendoza'),
('27111222', 'Pablo', 'Echarri', '0223-511-2244', 'p.echarri@mail.com', 'Alquilando SE');

INSERT INTO PROPIEDAD (PK_codigo_catastral, FK_cuit_dni, direccion, cantidad_ambientes, precio_tasacion, tipo_propiedad, superficie_m2, ciudad) VALUES
('CAT-01', '20-25444333-3', 'Paraguay 1200 4to B', 2, 120000.00, 'Departamento', 55, 'Buenos Aires'),
('CAT-02', '27-30111222-4', 'Libertador 4500 10mo A', 3, 220000.00, 'Departamento', 85, 'Buenos Aires'),
('CAT-03', '20-18999888-1', 'Obispo Trejo 300', 1, 90000.00, 'Monoambiente', 35, 'Córdoba'),
('CAT-04', '27-24555666-9', 'Belgrano 700 Casa 2', 4, 350000.00, 'Casa', 140, 'Mendoza'),
('CAT-05', '20-35111444-5', 'San Martín 900 P.B.', 2, 150000.00, 'Local Comercial', 60, 'Mar del Plata');

INSERT INTO CONTRATO_LOCACION (PK_codigo_contrato, FK_codigo_catastral, FK_legajo_empleado, FK_dni_pasaporte, fecha_inicio, fecha_finalizacion, monto_mensual_canon, deposito_garantia, modalidad_operacion) VALUES
('LOC-01', 'CAT-01', 'EMP-101', '34123456', '2026-01-01', '2028-01-01', 120000.00, 120000.00, 'Vivienda'),
('LOC-02', 'CAT-02', 'EMP-102', '29888777', '2026-02-15', '2028-02-15', 220000.00, 220000.00, 'Vivienda'),
('LOC-03', 'CAT-03', 'EMP-103', '31444555', '2026-03-01', '2028-03-01', 90000.00, 90000.00, 'Estudiantil'),
('LOC-04', 'CAT-04', 'EMP-104', '36777888', '2026-04-10', '2029-04-10', 350000.00, 350000.00, 'Vivienda'),
('LOC-05', 'CAT-05', 'EMP-105', '27111222', '2026-05-01', '2029-05-01', 150000.00, 150000.00, 'Comercial');

INSERT INTO PAGO_MENSUAL (PK_id_pago, FK_codigo_contrato, periodo_abonado, fecha_efectiva_pago, monto_abonado, medio_pago, recargo_mora) VALUES
('PAG-501', 'LOC-01', '2026-10', '2026-10-05', 120000.00, 'Transferencia', 0.00),
('PAG-502', 'LOC-02', '2026-10', '2026-10-10', 225500.00, 'Mercado Pago', 5500.00),
('PAG-503', 'LOC-03', '2026-10', '2026-10-02', 90000.00, 'Efectivo', 0.00),
('PAG-504', 'LOC-04', '2026-10', '2026-10-08', 350000.00, 'Débito Automático', 0.00),
('PAG-505', 'LOC-05', '2026-10', '2026-10-12', 158000.00, 'Transferencia', 8000.00);