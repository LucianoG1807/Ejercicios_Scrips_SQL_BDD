CREATE DATABASE IF NOT EXISTS bd_aerolinea;
USE bd_aerolinea;

CREATE TABLE AVION (
    PK_matricula VARCHAR(20) PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    capacidad_max INT NOT NULL,
    autonomia_vuelo VARCHAR(20),
    fabricante VARCHAR(50),
    anio_fabricacion INT
);

CREATE TABLE EMPLEADO (
    PK_num_empleado VARCHAR(20) PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_ingreso DATE,
    categoria_prof VARCHAR(50)
);

CREATE TABLE PASAJERO (
    PK_id_pasajero VARCHAR(20) PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100)
);

CREATE TABLE VUELO (
    PK_codigo_vuelo VARCHAR(20) PRIMARY KEY,
    ciudades_origen VARCHAR(50),
    ciudad_destino VARCHAR(50),
    fecha_vuelo DATE,
    horario_salida TIME,
    horario_llegada TIME,
    FK_matricula VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_matricula) REFERENCES AVION(PK_matricula)
);

CREATE TABLE VUELO_EMPLEADO (
    PK_vuelo_empleado VARCHAR(20) PRIMARY KEY,
    FK_codigo_vuelo VARCHAR(20) NOT NULL,
    FK_num_empleado VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_vuelo) REFERENCES VUELO(PK_codigo_vuelo),
    FOREIGN KEY (FK_num_empleado) REFERENCES EMPLEADO(PK_num_empleado)
);

CREATE TABLE RESERVA (
    PK_id_reserva VARCHAR(20) PRIMARY KEY,
    numero_asiento VARCHAR(10),
    fecha_reserva DATE,
    estado_reserva VARCHAR(30),
    clase_asiento VARCHAR(30),
    FK_codigo_vuelo VARCHAR(20) NOT NULL,
    FK_id_pasajero VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_vuelo) REFERENCES VUELO(PK_codigo_vuelo),
    FOREIGN KEY (FK_id_pasajero) REFERENCES PASAJERO(PK_id_pasajero)
);

------------------------------------------------------------------------

INSERT INTO AVION (PK_matricula, modelo, capacidad_max, autonomia_vuelo, fabricante, anio_fabricacion) VALUES
('LV-FBR', 'Boeing 737-800', 189, '5700 km', 'Boeing', 2018),
('LV-CKP', 'Airbus A330-200', 268, '13400 km', 'Airbus', 2015),
('LV-GVA', 'Embraer E190', 96, '4500 km', 'Embraer', 2020),
('LV-HKN', 'Boeing 787-9', 290, '14100 km', 'Boeing', 2021),
('LV-XBL', 'Airbus A320neo', 186, '6500 km', 'Airbus', 2022);

INSERT INTO EMPLEADO (PK_num_empleado, DNI, nombre, apellido, fecha_ingreso, categoria_prof) VALUES
('EMP-101', '35123456', 'Carlos', 'Mendoza', '2012-03-12', 'Comandante'),
('EMP-102', '38987654', 'Lucia', 'Fernandez', '2017-06-01', 'Primer Oficial'),
('EMP-103', '40111222', 'Martin', 'Gomez', '2019-11-15', 'Jefe de Cabina'),
('EMP-104', '41555666', 'Sofia', 'Rossi', '2021-02-10', 'Tripulante Cabina'),
('EMP-105', '39444333', 'Diego', 'Torres', '2015-08-05', 'Comandante');

INSERT INTO PASAJERO (PK_id_pasajero, DNI, nombre, apellido, correo_electronico) VALUES
('PAS-001', '42111000', 'Luciano', 'Gomez', 'lucho.gomez@gmail.com'),
('PAS-002', '39222111', 'Mariana', 'Lopez', 'marian.lopez@yahoo.com'),
('PAS-003', '41333222', 'Gonzalo', 'Perez', 'gonza_perez@hotmail.com'),
('PAS-004', '38444555', 'Camila', 'Diaz', 'cami.diaz@outlook.com'),
('PAS-005', '37555666', 'Joaquin', 'Morales', 'joaco.morales@gmail.com');

INSERT INTO VUELO (PK_codigo_vuelo, ciudades_origen, ciudad_destino, fecha_vuelo, horario_salida, horario_llegada, FK_matricula) VALUES
('AR1400', 'Buenos Aires', 'Mendoza', '2026-10-20', '08:30:00', '10:20:00', 'LV-FBR'),
('AR1130', 'Buenos Aires', 'Madrid', '2026-10-21', '23:55:00', '16:10:00', 'LV-CKP'),
('AR1510', 'Cordoba', 'Bariloche', '2026-10-22', '11:00:00', '13:15:00', 'LV-GVA'),
('AR1300', 'Buenos Aires', 'Miami', '2026-10-23', '21:15:00', '06:00:00', 'LV-HKN'),
('AR1820', 'Mendoza', 'Santiago Chile', '2026-10-24', '14:00:00', '15:00:00', 'LV-XBL');

INSERT INTO VUELO_EMPLEADO (PK_vuelo_empleado, FK_codigo_vuelo, FK_num_empleado) VALUES
('VE-001', 'AR1400', 'EMP-101'),
('VE-002', 'AR1400', 'EMP-103'),
('VE-003', 'AR1130', 'EMP-105'),
('VE-004', 'AR1130', 'EMP-102'),
('VE-005', 'AR1510', 'EMP-104');

INSERT INTO RESERVA (PK_id_reserva, numero_asiento, fecha_reserva, estado_reserva, clase_asiento, FK_codigo_vuelo, FK_id_pasajero) VALUES
('RES-1001', '12A', '2026-10-01', 'Confirmada', 'Turista', 'AR1400', 'PAS-001'),
('RES-1002', '03C', '2026-10-05', 'Confirmada', 'Ejecutiva', 'AR1130', 'PAS-002'),
('RES-1003', '18F', '2026-10-10', 'Pendiente', 'Turista', 'AR1510', 'PAS-003'),
('RES-1004', '02J', '2026-10-12', 'Confirmada', 'First Class', 'AR1300', 'PAS-004'),
('RES-1005', '15B', '2026-10-14', 'Cancelada', 'Turista', 'AR1820', 'PAS-005');