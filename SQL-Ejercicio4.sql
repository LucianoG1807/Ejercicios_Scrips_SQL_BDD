CREATE DATABASE IF NOT EXISTS bd_ecommerce;
USE bd_ecommerce;

CREATE TABLE CATEGORIA (
    PK_id_categoria VARCHAR(20) PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150),
    nivel_jerarquico INT,
    estado_activa BOOLEAN,
    FK_id_categoria_padre VARCHAR(20),
    FOREIGN KEY (FK_id_categoria_padre) REFERENCES CATEGORIA(PK_id_categoria)
);

CREATE TABLE CLIENTE (
    PK_id_cliente VARCHAR(20) PRIMARY KEY,
    nombre_apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contrasenia_hash VARCHAR(255) NOT NULL,
    fecha_registro DATE
);

CREATE TABLE TRANSPORTISTA (
    PK_CUIT VARCHAR(20) PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    numero_guia_seg VARCHAR(50),
    telefono_atencion VARCHAR(30),
    correo_contacto VARCHAR(100),
    tiempo_prom_ent VARCHAR(30)
);

CREATE TABLE DIRECCION_ENVIO (
    PK_id_direccion VARCHAR(20) PRIMARY KEY,
    calle_y_numero VARCHAR(150) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    provincia_estado VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(20),
    FK_id_cliente VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_cliente) REFERENCES CLIENTE(PK_id_cliente)
);

CREATE TABLE PRODUCTO (
    PK_codigo_SKU VARCHAR(20) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_det VARCHAR(150),
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock_disponible INT NOT NULL,
    FK_id_categoria VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_categoria) REFERENCES CATEGORIA(PK_id_categoria)
);

CREATE TABLE PEDIDO (
    PK_numero_orden VARCHAR(20) PRIMARY KEY,
    fecha_emision DATE NOT NULL,
    hora_emision TIME NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    estado_pedido VARCHAR(30),
    metodo_pago VARCHAR(50),
    FK_id_cliente VARCHAR(20) NOT NULL,
    FK_id_direccion VARCHAR(20) NOT NULL,
    FK_CUIT VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_cliente) REFERENCES CLIENTE(PK_id_cliente),
    FOREIGN KEY (FK_id_direccion) REFERENCES DIRECCION_ENVIO(PK_id_direccion),
    FOREIGN KEY (FK_CUIT) REFERENCES TRANSPORTISTA(PK_CUIT)
);

CREATE TABLE DETALLE_PEDIDO (
    PK_detalle_pedido VARCHAR(20) PRIMARY KEY,
    FK_codigo_SKU VARCHAR(20) NOT NULL,
    FK_num_orden VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_SKU) REFERENCES PRODUCTO(PK_codigo_SKU),
    FOREIGN KEY (FK_num_orden) REFERENCES PEDIDO(PK_numero_orden)
);

------------------------------------------------------------------------

INSERT INTO CATEGORIA (PK_id_categoria, nombre_categoria, descripcion, nivel_jerarquico, estado_activa, FK_id_categoria_padre) VALUES
('CAT01', 'Informatica', 'Equipos y partes', 1, TRUE, NULL),
('CAT02', 'Laptops', 'Portatiles', 2, TRUE, 'CAT01'),
('CAT03', 'Audio', 'Sonido', 1, TRUE, NULL),
('CAT04', 'Hogar', 'Articulos', 1, TRUE, NULL),
('CAT05', 'Ropa', 'Indumentaria', 1, TRUE, NULL);

INSERT INTO CLIENTE (PK_id_cliente, nombre_apellido, correo_electronico, contrasenia_hash, fecha_registro) VALUES
('CLI01', 'Luciano Gomez', 'luciano@mail.com', 'hash_abc', '2026-01-10'),
('CLI02', 'Mariana Perez', 'mariana@mail.com', 'hash_def', '2026-02-15'),
('CLI03', 'Carlos Ruiz', 'carlos@mail.com', 'hash_ghi', '2026-03-20'),
('CLI04', 'Ana Torres', 'ana@mail.com', 'hash_jkl', '2026-04-05'),
('CLI05', 'Mateo Diaz', 'mateo@mail.com', 'hash_mno', '2026-05-12');

INSERT INTO TRANSPORTISTA (PK_CUIT, razon_social, numero_guia_seg, telefono_atencion, correo_contacto, tiempo_prom_ent) VALUES
('CUIT01', 'OCA Logistica', 'GUIA-001', '0800-999', 'atencion@oca.com', '3 dias'),
('CUIT02', 'Correo Argentino', 'GUIA-002', '0800-777', 'contacto@correo.com', '5 dias'),
('CUIT03', 'Andreani', 'GUIA-003', '0810-122', 'info@andreani.com', '2 dias'),
('CUIT04', 'Femsa Express', 'GUIA-004', '0800-444', 'soporte@femsa.com', '4 dias'),
('CUIT05', 'Urbano Envios', 'GUIA-005', '0800-222', 'ayuda@urbano.com', '1 dia');

INSERT INTO DIRECCION_ENVIO (PK_id_direccion, calle_y_numero, ciudad, provincia_estado, codigo_postal, FK_id_cliente) VALUES
('DIR01', 'San Martin', 'Mendoza', 'Mendoza', '5500', 'CLI01'),
('DIR02', 'Belgrano', 'Cordoba', 'Cordoba', '5000', 'CLI02'),
('DIR03', 'Rivadavia', 'Rosario', 'Santa Fe', '2000', 'CLI03'),
('DIR04', 'Mitre', 'La Plata', 'Buenos Aires', '1900', 'CLI04'),
('DIR05', 'Alem', 'Parana', 'Entre Rios', '3100', 'CLI05');

INSERT INTO PRODUCTO (PK_codigo_SKU, nombre_producto, descripcion_det, precio_unitario, stock_disponible, FK_id_categoria) VALUES
('SKU001', 'Notebook', '16GB RAM', 1200.50, 15, 'CAT02'),
('SKU002', 'Auriculares', 'Bluetooth', 150.00, 40, 'CAT03'),
('SKU003', 'Cafetera', '20 bares', 250.00, 25, 'CAT04'),
('SKU004', 'Campera', 'Talle L', 85.00, 50, 'CAT05'),
('SKU005', 'Mouse', 'Inalambrico', 25.00, 80, 'CAT01');

INSERT INTO PEDIDO (PK_numero_orden, fecha_emision, hora_emision, monto_total, estado_pedido, metodo_pago, FK_id_cliente, FK_id_direccion, FK_CUIT) VALUES
('ORD001', '2026-06-01', '10:30:00', 1200.50, 'Completado', 'Tarjeta', 'CLI01', 'DIR01', 'CUIT01'),
('ORD002', '2026-06-02', '14:15:00', 150.00, 'Procesando', 'Mercado Pago', 'CLI02', 'DIR02', 'CUIT02'),
('ORD003', '2026-06-03', '09:00:00', 250.00, 'Enviado', 'Transferencia', 'CLI03', 'DIR03', 'CUIT03'),
('ORD004', '2026-06-04', '16:45:00', 85.00, 'Pendiente', 'Debito', 'CLI04', 'DIR04', 'CUIT04'),
('ORD005', '2026-06-05', '11:20:00', 25.00, 'Entregado', 'Mercado Pago', 'CLI05', 'DIR05', 'CUIT05');

INSERT INTO DETALLE_PEDIDO (PK_detalle_pedido, FK_codigo_SKU, FK_num_orden) VALUES
('DET001', 'SKU001', 'ORD001'),
('DET002', 'SKU002', 'ORD002'),
('DET003', 'SKU003', 'ORD003'),
('DET004', 'SKU004', 'ORD004'),
('DET005', 'SKU005', 'ORD005');