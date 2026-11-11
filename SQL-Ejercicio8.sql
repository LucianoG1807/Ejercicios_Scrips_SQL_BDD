DROP DATABASE IF EXISTS bd_deposito;
CREATE DATABASE bd_deposito;
USE bd_deposito;

CREATE TABLE DEPOSITO (
    PK_num_deposito VARCHAR(20) PRIMARY KEY,
    nombre_deposito VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    responsable_cargo VARCHAR(100),
    superficie_m2 INT
);

CREATE TABLE PRODUCTO (
    PK_codigo_barras VARCHAR(20) PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL,
    peso VARCHAR(20),
    dimensiones VARCHAR(50),
    fecha_elaboracion DATE,
    fecha_vencimiento DATE
);

CREATE TABLE PROVEEDOR (
    PK_cuit_proveedor VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    razon_social VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100),
    num_contacto VARCHAR(30)
);

CREATE TABLE ORDEN_COMPRA (
    PK_numero_orden VARCHAR(20) PRIMARY KEY,
    FK_cuit_proveedor VARCHAR(20) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_entrega_est DATE NOT NULL,
    monto_total_orden DECIMAL(10,2) NOT NULL,
    estado_orden VARCHAR(30),
    FOREIGN KEY (FK_cuit_proveedor) REFERENCES PROVEEDOR(PK_cuit_proveedor)
);

CREATE TABLE STOCK_DEPOSITO_PRODUCTO (
    PK_stock INT PRIMARY KEY,
    FK_num_deposito VARCHAR(20) NOT NULL,
    FK_codigo_barras VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_num_deposito) REFERENCES DEPOSITO(PK_num_deposito),
    FOREIGN KEY (FK_codigo_barras) REFERENCES PRODUCTO(PK_codigo_barras)
);

CREATE TABLE CATALOGO_PROVEEDOR_PRODUCTO (
    PK_catalogo VARCHAR(20) PRIMARY KEY,
    FK_codigo_barras VARCHAR(20) NOT NULL,
    FK_cuit_proveedor VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_barras) REFERENCES PRODUCTO(PK_codigo_barras),
    FOREIGN KEY (FK_cuit_proveedor) REFERENCES PROVEEDOR(PK_cuit_proveedor)
);

CREATE TABLE DETALLE_ORDEN_PRODUCTO (
    PK_detalle INT PRIMARY KEY,
    FK_numero_orden VARCHAR(20) NOT NULL,
    FK_codigo_barras VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_numero_orden) REFERENCES ORDEN_COMPRA(PK_numero_orden),
    FOREIGN KEY (FK_codigo_barras) REFERENCES PRODUCTO(PK_codigo_barras)
);

------------------------------------------------------------------------

INSERT INTO DEPOSITO (PK_num_deposito, nombre_deposito, direccion, responsable_cargo, superficie_m2) VALUES
('DEP01', 'Depósito Central', 'Ruta 9 Km 42', 'Esteban Quito', 2500),
('DEP02', 'Depósito Norte', 'Av. Circunvalación 800', 'Mario Bros', 1800),
('DEP03', 'Depósito Sur', 'Parque Industrial Lote 5', 'Ana Gómez', 3200),
('DEP04', 'Depósito Oeste', 'Acceso Oeste Km 25', 'Luis Fonsi', 1500),
('DEP05', 'Depósito Este', 'Ruta 2 Km 30', 'Carla Pérez', 2100);

INSERT INTO PRODUCTO (PK_codigo_barras, descripcion, peso, dimensiones, fecha_elaboracion, fecha_vencimiento) VALUES
('7791234567890', 'Café Molido 500g', '0.50 kg', '10x15x5 cm', '2026-01-10', '2027-01-10'),
('7799876543210', 'Yerba Mate 1kg', '1.00 kg', '20x10x10 cm', '2026-02-15', '2028-02-15'),
('7794561237890', 'Galletitas de Agua 300g', '0.30 kg', '15x15x5 cm', '2026-03-01', '2026-12-01'),
('7797894561230', 'Leche Descremada 1L', '1.03 kg', '7x7x20 cm', '2026-10-01', '2026-11-01'),
('7793216549870', 'Aceite de Girasol 1.5L', '1.40 kg', '10x10x25 cm', '2026-05-10', '2027-05-10');

INSERT INTO PROVEEDOR (PK_cuit_proveedor, nombre, razon_social, correo_electronico, num_contacto) VALUES
('30-71112223-9', 'Distribuidora Alimentos S.A.', 'Alimentos SA', 'contacto@alimentos.com', '011-4444-5555'),
('30-68889994-1', 'Molinos Arg S.R.L.', 'Molinos SRL', 'ventas@molinos.com.ar', '011-5555-6666'),
('30-52223331-4', 'Lácteos del Sur', 'Lácteos Sur SA', 'info@lacteossur.com', '0351-422-3344'),
('30-71998882-5', 'Aceitera General', 'Aceitera SAIC', 'comercial@aceitera.com', '0341-477-8899'),
('30-61234567-8', 'Importadora Global', 'Global Imp SRL', 'contacto@globalimp.com', '011-7777-8888');

INSERT INTO ORDEN_COMPRA (PK_numero_orden, FK_cuit_proveedor, fecha_emision, fecha_entrega_est, monto_total_orden, estado_orden) VALUES
('OC-1001', '30-71112223-9', '2026-10-01', '2026-10-10', 12500.00, 'Aprobada'),
('OC-1002', '30-68889994-1', '2026-10-03', '2026-10-12', 8400.50, 'Pendiente'),
('OC-1003', '30-52223331-4', '2026-10-05', '2026-10-08', 15200.00, 'Entregada'),
('OC-1004', '30-71998882-5', '2026-10-08', '2026-10-18', 9300.00, 'Emitida'),
('OC-1005', '30-61234567-8', '2026-10-10', '2026-10-20', 21000.00, 'Aprobada');

INSERT INTO STOCK_DEPOSITO_PRODUCTO (PK_stock, FK_num_deposito, FK_codigo_barras) VALUES
(1, 'DEP01', '7791234567890'),
(2, 'DEP01', '7799876543210'),
(3, 'DEP02', '7794561237890'),
(4, 'DEP03', '7797894561230'),
(5, 'DEP04', '7793216549870');

INSERT INTO CATALOGO_PROVEEDOR_PRODUCTO (PK_catalogo, FK_codigo_barras, FK_cuit_proveedor) VALUES
('CAT-01', '7791234567890', '30-71112223-9'),
('CAT-02', '7799876543210', '30-68889994-1'),
('CAT-03', '7794561237890', '30-52223331-4'),
('CAT-04', '7797894561230', '30-71998882-5'),
('CAT-05', '7793216549870', '30-61234567-8');

INSERT INTO DETALLE_ORDEN_PRODUCTO (PK_detalle, FK_numero_orden, FK_codigo_barras) VALUES
(1, 'OC-1001', '7791234567890'),
(2, 'OC-1002', '7799876543210'),
(3, 'OC-1003', '7794561237890'),
(4, 'OC-1004', '7797894561230'),
(5, 'OC-1005', '7793216549870');