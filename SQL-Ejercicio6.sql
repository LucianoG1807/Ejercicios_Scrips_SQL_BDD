DROP DATABASE IF EXISTS bd_gestion_proyectos;
CREATE DATABASE bd_gestion_proyectos;
USE bd_gestion_proyectos;

CREATE TABLE PROYECTO (
    PK_codigo_proyecto VARCHAR(20) PRIMARY KEY,
    nombre_comercial VARCHAR(100) NOT NULL,
    descripcion_obj VARCHAR(150),
    fecha_inicio_prev DATE,
    fecha_fin_estim DATE,
    presupuesto_asig DECIMAL(12,2) NOT NULL
);

CREATE TABLE RECURSO_MATERIAL (
    PK_num_inventario VARCHAR(20) PRIMARY KEY,
    tipo_recurso VARCHAR(50) NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    numero_serie VARCHAR(50)
);

CREATE TABLE EMPLEADO (
    PK_legajo_empleado VARCHAR(20) PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    nombre_empleado VARCHAR(50) NOT NULL,
    apellido_empleado VARCHAR(50) NOT NULL,
    categoria_laboral VARCHAR(50),
    perfil_tecnico VARCHAR(50),
    correo_inst VARCHAR(100)
);

CREATE TABLE FASE_PROYECTO (
    PK_id_fase VARCHAR(20) PRIMARY KEY,
    nombre_fase VARCHAR(50) NOT NULL,
    orden_secuencia INT,
    fecha_inicio_fase DATE,
    fecha_fin_fase DATE,
    estado_fase VARCHAR(30),
    FK_codigo_proy VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_proy) REFERENCES PROYECTO(PK_codigo_proyecto)
);

CREATE TABLE TAREA (
    PK_id_tarea VARCHAR(20) PRIMARY KEY,
    descripcion_tarea VARCHAR(150) NOT NULL,
    estado_tarea VARCHAR(30),
    estimacion_horas INT,
    complejidad VARCHAR(30),
    prioridad VARCHAR(30),
    FK_id_fase VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_fase) REFERENCES FASE_PROYECTO(PK_id_fase)
);

CREATE TABLE PROYECTO_RECURSO (
    PK_id_proy_recurso VARCHAR(20) PRIMARY KEY,
    FK_codigo_proyecto VARCHAR(20) NOT NULL,
    FK_num_inventario VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_proyecto) REFERENCES PROYECTO(PK_codigo_proyecto),
    FOREIGN KEY (FK_num_inventario) REFERENCES RECURSO_MATERIAL(PK_num_inventario)
);

CREATE TABLE ASIGNACION_TAREA_EMPLEADO (
    PK_id_asignacion VARCHAR(20) PRIMARY KEY,
    FK_id_tarea VARCHAR(20) NOT NULL,
    FK_legajo_empleado VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_tarea) REFERENCES TAREA(PK_id_tarea),
    FOREIGN KEY (FK_legajo_empleado) REFERENCES EMPLEADO(PK_legajo_empleado)
);

------------------------------------------------------------------------

INSERT INTO PROYECTO (PK_codigo_proyecto, nombre_comercial, descripcion_obj, fecha_inicio_prev, fecha_fin_estim, presupuesto_asig) VALUES
('PR001', 'Sistema ERP', 'Gestion Integral', '2026-02-01', '2026-12-01', 5000000.00),
('PR002', 'App Mobile', 'Clientes iOS/Android', '2026-03-15', '2026-09-15', 2500000.00),
('PR003', 'E-Commerce', 'Tienda Online', '2026-05-01', '2026-11-30', 3800000.00),
('PR004', 'Portal B2B', 'Plataforma Proveedores', '2026-06-10', '2027-01-10', 4200000.00),
('PR005', 'Red de Datos', 'Infraestructura IT', '2026-08-01', '2027-02-28', 1800000.00);

INSERT INTO RECURSO_MATERIAL (PK_num_inventario, tipo_recurso, marca, modelo, numero_serie) VALUES
('INV001', 'Servidor', 'Dell', 'PowerEdge R740', 'SN-998811'),
('INV002', 'Notebook', 'Lenovo', 'ThinkPad E14', 'SN-445522'),
('INV003', 'Switch Red', 'Cisco', 'Catalyst 2960', 'SN-112233'),
('INV004', 'Licencia SW', 'Microsoft', 'SQL Server 2022', 'LIC-887766'),
('INV005', 'Tablet Test', 'Apple', 'iPad Air 5', 'SN-332211');

INSERT INTO EMPLEADO (PK_legajo_empleado, DNI, nombre_empleado, apellido_empleado, categoria_laboral, perfil_tecnico, correo_inst) VALUES
('E001', '38111222', 'Luciano', 'Gomez', 'Senior', 'Analista Sistemas', 'lgomez@emp.com'),
('E002', '40333444', 'Mariana', 'Perez', 'Semi Senior', 'Diseñadora UI/UX', 'mperez@emp.com'),
('E003', '39555666', 'Carlos', 'Ruiz', 'Senior', 'Desarrollador Java', 'cruiz@emp.com'),
('E004', '41777888', 'Ana', 'Torres', 'Junior', 'Frontend React', 'atorres@emp.com'),
('E005', '37999000', 'Mateo', 'Diaz', 'Senior', 'Ingeniero Redes', 'mdiaz@emp.com');

INSERT INTO FASE_PROYECTO (PK_id_fase, nombre_fase, orden_secuencia, fecha_inicio_fase, fecha_fin_fase, estado_fase, FK_codigo_proy) VALUES
('FA001', 'Análisis', 1, '2026-02-01', '2026-02-28', 'Finalizada', 'PR001'),
('FA002', 'Diseño', 2, '2026-03-01', '2026-04-15', 'En Curso', 'PR001'),
('FA003', 'Desarrollo UI', 1, '2026-03-15', '2026-05-30', 'En Curso', 'PR002'),
('FA004', 'Maquetado', 1, '2026-05-01', '2026-07-15', 'Planificada', 'PR003'),
('FA005', 'Cableado', 1, '2026-08-01', '2026-09-30', 'Planificada', 'PR005');

INSERT INTO TAREA (PK_id_tarea, descripcion_tarea, estado_tarea, estimacion_horas, complejidad, prioridad, FK_id_fase) VALUES
('TAR001', 'Entrevistas', 'Completada', 40, 'Media', 'Alta', 'FA001'),
('TAR002', 'Diagrama DER', 'En Proceso', 60, 'Alta', 'Alta', 'FA002'),
('TAR003', 'Wireframes', 'En Proceso', 30, 'Baja', 'Media', 'FA003'),
('TAR004', 'Layout CSS', 'Pendiente', 50, 'Media', 'Media', 'FA004'),
('TAR005', 'Instalacion Rack', 'Pendiente', 25, 'Alta', 'Alta', 'FA005');

INSERT INTO PROYECTO_RECURSO (PK_id_proy_recurso, FK_codigo_proyecto, FK_num_inventario) VALUES
('PRR001', 'PR001', 'INV001'),
('PRR002', 'PR001', 'INV004'),
('PRR003', 'PR002', 'INV002'),
('PRR004', 'PR002', 'INV005'),
('PRR005', 'PR005', 'INV003');

INSERT INTO ASIGNACION_TAREA_EMPLEADO (PK_id_asignacion, FK_id_tarea, FK_legajo_empleado) VALUES
('ASG001', 'TAR001', 'E001'),
('ASG002', 'TAR002', 'E001'),
('ASG003', 'TAR003', 'E002'),
('ASG004', 'TAR004', 'E004'),
('ASG005', 'TAR005', 'E005');