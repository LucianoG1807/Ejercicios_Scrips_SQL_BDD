DROP DATABASE IF EXISTS bd_produccion_industrial;
CREATE DATABASE bd_produccion_industrial;
USE bd_produccion_industrial;

CREATE TABLE PRODUCTO (
    PK_codigo_articulo VARCHAR(20) PRIMARY KEY,
    nombre_comercial VARCHAR(100) NOT NULL,
    descripcion_tecnica TEXT,
    tiempo_est_fab INT,
    peso_unitario_kg DECIMAL(10,2)
);

CREATE TABLE LINEA_MONTAJE (
    PK_codigo_linea VARCHAR(20) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    capacidad_diaria INT,
    ubicacion_nave VARCHAR(100)
);

CREATE TABLE COMPONENTE_PIEZA (
    PK_codigo_componente VARCHAR(20) PRIMARY KEY,
    nombre_pieza VARCHAR(100) NOT NULL,
    tipo_material VARCHAR(50),
    stock_actual INT,
    costo_unitario DECIMAL(10,2) NOT NULL,
    FK_componente_padre VARCHAR(20),
    FOREIGN KEY (FK_componente_padre) REFERENCES COMPONENTE_PIEZA(PK_codigo_componente)
);

CREATE TABLE EMPLEADO (
    PK_legajo_empleado VARCHAR(20) PRIMARY KEY,
    FK_codigo_linea VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    rol_laboral VARCHAR(50),
    salario DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (FK_codigo_linea) REFERENCES LINEA_MONTAJE(PK_codigo_linea)
);

CREATE TABLE ORDEN_FABRICACION (
    PK_numero_orden VARCHAR(20) PRIMARY KEY,
    FK_codigo_articulo VARCHAR(20) NOT NULL,
    FK_codigo_linea VARCHAR(20) NOT NULL,
    fecha_emision DATE NOT NULL,
    cantidad_planificada INT NOT NULL,
    fecha_limite_entrega DATE NOT NULL,
    estado_orden VARCHAR(30),
    FOREIGN KEY (FK_codigo_articulo) REFERENCES PRODUCTO(PK_codigo_articulo),
    FOREIGN KEY (FK_codigo_linea) REFERENCES LINEA_MONTAJE(PK_codigo_linea)
);

CREATE TABLE ESTRUCTURA_BOM (
    PK_estructura VARCHAR(20) PRIMARY KEY,
    FK_codigo_articulo VARCHAR(20) NOT NULL,
    FK_codigo_componente VARCHAR(20) NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (FK_codigo_articulo) REFERENCES PRODUCTO(PK_codigo_articulo),
    FOREIGN KEY (FK_codigo_componente) REFERENCES COMPONENTE_PIEZA(PK_codigo_componente)
);

CREATE TABLE INSPECCION_CALIDAD (
    PK_id_inspeccion VARCHAR(20) PRIMARY KEY,
    FK_numero_orden VARCHAR(20) NOT NULL,
    FK_legajo_empleado VARCHAR(20) NOT NULL,
    fecha_control DATE NOT NULL,
    hora_control TIME NOT NULL,
    resultado_prueba VARCHAR(30),
    motivos_falla_det TEXT,
    lote_inspeccionado VARCHAR(50),
    FOREIGN KEY (FK_numero_orden) REFERENCES ORDEN_FABRICACION(PK_numero_orden),
    FOREIGN KEY (FK_legajo_empleado) REFERENCES EMPLEADO(PK_legajo_empleado)
);

------------------------------------------------------------------------

INSERT INTO PRODUCTO (PK_codigo_articulo, nombre_comercial, descripcion_tecnica, tiempo_est_fab, peso_unitario_kg) VALUES
('ART-101', 'Motor Industrial V8', 'Motor de combustión 5.0L', 120, 210.5),
('ART-102', 'Compresor de Aire 50L', 'Compresor bicilíndrico', 80, 45.0),
('ART-103', 'Bomba Hidráulica P2', 'Bomba de engranajes alta presión', 60, 18.2),
('ART-104', 'Generador Eléctrico 5kW', 'Generador a gasolina monofásico', 95, 68.0),
('ART-105', 'Caja de Transmisión T4', 'Transmisión manual 5 marchas', 110, 95.4);

INSERT INTO LINEA_MONTAJE (PK_codigo_linea, descripcion, capacidad_diaria, ubicacion_nave) VALUES
('LIN-01', 'Línea de Motores Pesados', 40, 'Nave A - Sector 1'),
('LIN-02', 'Línea de Compresores', 75, 'Nave A - Sector 2'),
('LIN-03', 'Línea Hidráulica', 90, 'Nave B - Sector 1'),
('LIN-04', 'Línea de Generadores', 50, 'Nave B - Sector 2'),
('LIN-05', 'Línea de Transmisiones', 60, 'Nave C - Sector 1');

INSERT INTO COMPONENTE_PIEZA (PK_codigo_componente, nombre_pieza, tipo_material, stock_actual, costo_unitario, FK_componente_padre) VALUES
('CMP-01', 'Pistón de aluminio', 'Aleación Al-Si', 500, 2500.00, NULL),
('CMP-02', 'Cigüeñal forjado', 'Acero al carbono', 120, 18000.00, NULL),
('CMP-03', 'Válvula de admisión', 'Acero inoxidable', 850, 1200.00, NULL),
('CMP-04', 'Filtro de aire principal', 'Celulosa sintética', 400, 4500.00, NULL),
('CMP-05', 'Engranaje helicoidal', 'Acero templado', 300, 3100.00, NULL);

INSERT INTO EMPLEADO (PK_legajo_empleado, FK_codigo_linea, nombre, apellido, DNI, rol_laboral, salario) VALUES
('EMP-501', 'LIN-01', 'Roberto', 'Ayala', '24111222', 'Supervisor', 950000.00),
('EMP-502', 'LIN-02', 'Marcela', 'Acuña', '27444555', 'Control Calidad', 850000.00),
('EMP-503', 'LIN-03', 'Gabriel', 'Batistuta', '22777888', 'Supervisor', 980000.00),
('EMP-504', 'LIN-04', 'Javier', 'Zanetti', '20888999', 'Inspector Calidad', 890000.00),
('EMP-505', 'LIN-05', 'Pablo', 'Aimar', '25999000', 'Técnico Montaje', 820000.00);

INSERT INTO ORDEN_FABRICACION (PK_numero_orden, FK_codigo_articulo, FK_codigo_linea, fecha_emision, cantidad_planificada, fecha_limite_entrega, estado_orden) VALUES
('ORD-901', 'ART-101', 'LIN-01', '2026-10-01', 30, '2026-10-20', 'En Proceso'),
('ORD-902', 'ART-102', 'LIN-02', '2026-10-03', 50, '2026-10-18', 'Completada'),
('ORD-903', 'ART-103', 'LIN-03', '2026-10-05', 80, '2026-10-25', 'Pendiente'),
('ORD-904', 'ART-104', 'LIN-04', '2026-10-08', 40, '2026-10-28', 'En Proceso'),
('ORD-905', 'ART-105', 'LIN-05', '2026-10-10', 45, '2026-11-02', 'Pendiente');

INSERT INTO ESTRUCTURA_BOM (PK_estructura, FK_codigo_articulo, FK_codigo_componente, cantidad_necesaria) VALUES
('BOM-01', 'ART-101', 'CMP-01', 8.0),
('BOM-02', 'ART-101', 'CMP-02', 1.0),
('BOM-03', 'ART-101', 'CMP-03', 16.0),
('BOM-04', 'ART-102', 'CMP-04', 2.0),
('BOM-05', 'ART-105', 'CMP-05', 5.0);

INSERT INTO INSPECCION_CALIDAD (PK_id_inspeccion, FK_numero_orden, FK_legajo_empleado, fecha_control, hora_control, resultado_prueba, motivos_falla_det, lote_inspeccionado) VALUES
('INS-701', 'ORD-901', 'EMP-502', '2026-10-04', '14:30:00', 'Aprobado', 'Ninguno', 'LOT-A01'),
('INS-702', 'ORD-902', 'EMP-504', '2026-10-10', '10:15:00', 'Aprobado', 'Ninguno', 'LOT-B02'),
('INS-703', 'ORD-903', 'EMP-502', '2026-10-12', '16:00:00', 'Rechazado', 'Fuga de presión hidráulica', 'LOT-C03'),
('INS-704', 'ORD-904', 'EMP-504', '2026-10-14', '11:00:00', 'Aprobado', 'Ninguno', 'LOT-D04'),
('INS-705', 'ORD-905', 'EMP-502', '2026-10-15', '09:30:00', 'Aprobado', 'Ninguno', 'LOT-E05');