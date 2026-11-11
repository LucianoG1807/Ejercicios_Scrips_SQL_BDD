DROP DATABASE IF EXISTS bd_veterinaria;
CREATE DATABASE bd_veterinaria;
USE bd_veterinaria;

CREATE TABLE TUTOR (
    PK_DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(150),
    telefono_contacto VARCHAR(30),
    correo_electronico VARCHAR(100) NOT NULL
);

CREATE TABLE VETERINARIO (
    PK_matricula_profesional VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad_clinica VARCHAR(50),
    telefono VARCHAR(30),
    correo_electronico VARCHAR(100) NOT NULL
);

CREATE TABLE VACUNA (
    PK_codigo_vacuna VARCHAR(20) PRIMARY KEY,
    nombre_comercial VARCHAR(100) NOT NULL,
    laboratorio VARCHAR(100),
    numero_lote VARCHAR(50)
);

CREATE TABLE MASCOTA (
    PK_num_historia_clinica VARCHAR(20) PRIMARY KEY,
    FK_DNI VARCHAR(20) NOT NULL,
    nombre_mascota VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raza VARCHAR(50),
    sexo VARCHAR(20),
    fecha_nacimiento_est DATE,
    FOREIGN KEY (FK_DNI) REFERENCES TUTOR(PK_DNI)
);

CREATE TABLE CLINICA_VETERINARIA (
    PK_id_consulta VARCHAR(20) PRIMARY KEY,
    FK_num_historia_clinica VARCHAR(20) NOT NULL,
    FK_matricula_profesional VARCHAR(20) NOT NULL,
    fecha_atencion DATE NOT NULL,
    hora_atencion TIME NOT NULL,
    motivo_consulta TEXT NOT NULL,
    temperatura_corporal DECIMAL(4,1),
    peso_actual_kg DECIMAL(5,2),
    diagnostico TEXT,
    FOREIGN KEY (FK_num_historia_clinica) REFERENCES MASCOTA(PK_num_historia_clinica),
    FOREIGN KEY (FK_matricula_profesional) REFERENCES VETERINARIO(PK_matricula_profesional)
);

CREATE TABLE APLICACION_VACUNA_MASCOTA (
    PK_id_aplicacion VARCHAR(20) PRIMARY KEY,
    FK_num_historia_clinica VARCHAR(20) NOT NULL,
    FK_codigo_vacuna VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_num_historia_clinica) REFERENCES MASCOTA(PK_num_historia_clinica),
    FOREIGN KEY (FK_codigo_vacuna) REFERENCES VACUNA(PK_codigo_vacuna)
);

------------------------------------------------------------------------

INSERT INTO TUTOR (PK_DNI, nombre, apellido, direccion, telefono_contacto, correo_electronico) VALUES
('28111222', 'Mariana', 'Giménez', 'Av. Las Heras 2400', '011-4555-1234', 'mariana.g@mail.com'),
('32444555', 'Esteban', 'Quito', 'San Martín 500', '011-4777-5678', 'esteban.q@mail.com'),
('25777888', 'Florencia', 'Bertotti', 'Belgrano 1200', '0351-422-9988', 'florencia.b@mail.com'),
('35888999', 'Gonzalo', 'Higuaín', 'Emilio Civit 300', '0261-429-1122', 'gonzalo.h@mail.com'),
('22999000', 'Valeria', 'Mazzini', 'Colón 1500', '0223-491-3344', 'valeria.m@mail.com');

INSERT INTO VETERINARIO (PK_matricula_profesional, nombre, apellido, especialidad_clinica, telefono, correo_electronico) VALUES
('MP-4501', 'Carlos', 'Gutiérrez', 'Cirugía General', '011-5111-2233', 'c.gutierrez@vet.com'),
('MP-4502', 'Lucía', 'Fernández', 'Medicina Felina', '011-5333-4455', 'l.fernandez@vet.com'),
('MP-4503', 'Martín', 'Pérez', 'Animales Exóticos', '0351-566-7788', 'm.perez@vet.com'),
('MP-4504', 'Sofía', 'Díaz', 'Dermatología', '0261-588-9900', 's.diaz@vet.com'),
('MP-4505', 'Andrés', 'Silva', 'Cardiología', '0223-511-2244', 'a.silva@vet.com');

INSERT INTO VACUNA (PK_codigo_vacuna, nombre_comercial, laboratorio, numero_lote) VALUES
('VAC-01', 'Antirrábica Felina/Canina', 'Rabisin Lab', 'LOT-99881'),
('VAC-02', 'Séxtuple Canina', 'Biogenesis Bagó', 'LOT-77442'),
('VAC-03', 'Triple Felina', 'Zoetis', 'LOT-55339'),
('VAC-04', 'Tos de las Perreras', 'MSD Animal Health', 'LOT-11223'),
('VAC-05', 'Leucemia Felina', 'Boehringer Ingelheim', 'LOT-44556');

INSERT INTO MASCOTA (PK_num_historia_clinica, FK_DNI, nombre_mascota, especie, raza, sexo, fecha_nacimiento_est) VALUES
('HC-1001', '28111222', 'Simba', 'Canino', 'Golden Retriever', 'Macho', '2023-05-10'),
('HC-1002', '32444555', 'Luna', 'Felino', 'Siamés', 'Hembra', '2024-01-15'),
('HC-1003', '25777888', 'Bruno', 'Canino', 'Bulldog Francés', 'Macho', '2022-11-20'),
('HC-1004', '35888999', 'Mila', 'Felino', 'Persa', 'Hembra', '2023-08-05'),
('HC-1005', '22999000', 'Rocky', 'Canino', 'Ovejero Alemán', 'Macho', '2021-03-30');

INSERT INTO CLINICA_VETERINARIA (PK_id_consulta, FK_num_historia_clinica, FK_matricula_profesional, fecha_atencion, hora_atencion, motivo_consulta, temperatura_corporal, peso_actual_kg, diagnostico) VALUES
('CON-501', 'HC-1001', 'MP-4501', '2026-10-10', '10:30:00', 'Control anual y vacunas', 38.5, 30.5, 'Saludable'),
('CON-502', 'HC-1002', 'MP-4502', '2026-10-11', '15:00:00', 'Vómitos frecuentes', 39.1, 4.2, 'Gastroenteritis leve'),
('CON-503', 'HC-1003', 'MP-4504', '2026-10-12', '11:15:00', 'Picazón en la piel', 38.4, 12.8, 'Dermatitis alérgica'),
('CON-504', 'HC-1004', 'MP-4502', '2026-10-13', '09:45:00', 'Control de peso y castración', 38.2, 3.5, 'Apta para cirugía'),
('CON-505', 'HC-1005', 'MP-4505', '2026-10-14', '17:00:00', 'Tos seca persistente', 38.8, 36.0, 'Traqueobronquitis infecciosa');

INSERT INTO APLICACION_VACUNA_MASCOTA (PK_id_aplicacion, FK_num_historia_clinica, FK_codigo_vacuna) VALUES
('APL-01', 'HC-1001', 'VAC-01'),
('APL-02', 'HC-1001', 'VAC-02'),
('APL-03', 'HC-1002', 'VAC-03'),
('APL-04', 'HC-1003', 'VAC-04'),
('APL-05', 'HC-1004', 'VAC-05');