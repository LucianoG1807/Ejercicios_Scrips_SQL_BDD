CREATE DATABASE IF NOT EXISTS bd_clinica;
USE bd_clinica;

CREATE TABLE PACIENTE (
    PK_num_historia_clinica VARCHAR(20) PRIMARY KEY,
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    domicilio VARCHAR(150),
    obra_social VARCHAR(50),
    DNI VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE MEDICO (
    PK_matricula_prof VARCHAR(20) PRIMARY KEY,
    nombre_medico VARCHAR(50) NOT NULL,
    apellido_medico VARCHAR(50) NOT NULL,
    telefono_contacto VARCHAR(30),
    correo_mail VARCHAR(100),
    fecha_ingreso DATE
);

CREATE TABLE ESPECIALIDAD (
    PK_id_especialidad VARCHAR(20) PRIMARY KEY,
    nombre_especialidad VARCHAR(50) NOT NULL,
    area_medica VARCHAR(50),
    descripcion VARCHAR(150)
);

CREATE TABLE MEDICO_ESPECIALIDAD (
    PK_id_medico_especialidad VARCHAR(20) PRIMARY KEY,
    FK_matricula_prof VARCHAR(20) NOT NULL,
    FK_id_especialidad VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_matricula_prof) REFERENCES MEDICO(PK_matricula_prof),
    FOREIGN KEY (FK_id_especialidad) REFERENCES ESPECIALIDAD(PK_id_especialidad)
);

CREATE TABLE MEDICAMENTO (
    PK_codigo_alfanumerico VARCHAR(20) PRIMARY KEY,
    nombre_comercial VARCHAR(100) NOT NULL,
    monodroga VARCHAR(100) NOT NULL,
    laboratorio_fabricante VARCHAR(100),
    presentacion VARCHAR(100)
);

CREATE TABLE TURNO (
    PK_id_turno VARCHAR(20) PRIMARY KEY,
    fecha_turno DATE NOT NULL,
    hora_turno TIME NOT NULL,
    estado_turno VARCHAR(30),
    diagnostico_obv TEXT,
    FK_num_historia_clinica VARCHAR(20) NOT NULL,
    FK_matricula_prof VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_num_historia_clinica) REFERENCES PACIENTE(PK_num_historia_clinica),
    FOREIGN KEY (FK_matricula_prof) REFERENCES MEDICO(PK_matricula_prof)
);

CREATE TABLE RECETA_MEDICAMENTO (
    PK_receta_medicamento VARCHAR(20) PRIMARY KEY,
    FK_id_turno VARCHAR(20) NOT NULL,
    FK_medico_especialidad VARCHAR(20) NOT NULL,
    FK_codigo_alfanumerico VARCHAR(20) NOT NULL,
    indicaciones TEXT,
    FOREIGN KEY (FK_id_turno) REFERENCES TURNO(PK_id_turno),
    FOREIGN KEY (FK_medico_especialidad) REFERENCES MEDICO_ESPECIALIDAD(PK_id_medico_especialidad),
    FOREIGN KEY (FK_codigo_alfanumerico) REFERENCES MEDICAMENTO(PK_codigo_alfanumerico)
);

------------------------------------------------------------------------

INSERT INTO PACIENTE (PK_num_historia_clinica, apellido, nombre, fecha_nacimiento, domicilio, obra_social, DNI) VALUES
('HC-001', 'Gomez', 'Luciano', '2000-07-18', 'San Martin 450', 'OSDE', '42111000'),
('HC-002', 'Perez', 'Mariana', '1995-05-12', 'Belgrano 1200', 'Swiss Medical', '39222111'),
('HC-003', 'Rodriguez', 'Carlos', '1988-11-03', 'Las Heras 890', 'Galeno', '35333444'),
('HC-004', 'Lopez', 'Sofia', '2002-01-22', 'Mitre 310', 'Medicus', '43444555'),
('HC-005', 'Diaz', 'Joaquin', '1990-09-14', 'Espana 770', 'Sancor', '37555666');

INSERT INTO MEDICO (PK_matricula_prof, nombre_medico, apellido_medico, telefono_contacto, correo_mail, fecha_ingreso) VALUES
('MP-4521', 'Esteban', 'Quinteros', '2815551234', 'equinteros@clinica.com', '2015-02-10'),
('MP-4890', 'Valeria', 'Sosa', '2814449878', 'vsosa@clinica.com', '2018-06-15'),
('MP-5120', 'Ramiro', 'Navarro', '2817773322', 'rnavarro@clinica.com', '2020-09-01'),
('MP-5334', 'Natalia', 'Acosta', '2813338899', 'nacosta@clinica.com', '2022-01-12'),
('MP-5891', 'Mauricio', 'Silva', '2812221100', 'msilva@clinica.com', '2023-03-20');

INSERT INTO ESPECIALIDAD (PK_id_especialidad, nombre_especialidad, area_medica, descripcion) VALUES
('ESP-01', 'Cardiologia', 'Clinica', 'Salud cardiovascular'),
('ESP-02', 'Pediatria', 'Infantil', 'Atencion infantil'),
('ESP-03', 'Traumatologia', 'Quirurgica', 'Sistema osteoarticular'),
('ESP-04', 'Dermatologia', 'Clinica', 'Cuidado de piel'),
('ESP-05', 'Oftalmologia', 'Especializada', 'Salud visual');

INSERT INTO MEDICO_ESPECIALIDAD (PK_id_medico_especialidad, FK_matricula_prof, FK_id_especialidad) VALUES
('ME-01', 'MP-4521', 'ESP-01'),
('ME-02', 'MP-4890', 'ESP-02'),
('ME-03', 'MP-5120', 'ESP-03'),
('ME-04', 'MP-5334', 'ESP-04'),
('ME-05', 'MP-5891', 'ESP-05');

INSERT INTO MEDICAMENTO (PK_codigo_alfanumerico, nombre_comercial, monodroga, laboratorio_fabricante, presentacion) VALUES
('MED-001', 'Bayer Aspirina', 'Acido Acetilsalicilico', 'Bayer', 'Comprimidos x 500mg'),
('MED-002', 'Sertal Compositum', 'Propinox + Clonixinato', 'Roemmers', 'Estuche x 20 comprimidos'),
('MED-003', 'Ibupirac 400', 'Ibuprofeno', 'Pfizer', 'Capsulas blandas x 10'),
('MED-004', 'Amoxidal 500', 'Amoxicilina', 'GlaxoSmithKline', 'Comprimidos x 21'),
('MED-005', 'Tafirol 1g', 'Paracetamol', 'Genomma Lab', 'Comprimidos x 10');

INSERT INTO TURNO (PK_id_turno, fecha_turno, hora_turno, estado_turno, diagnostico_obv, FK_num_historia_clinica, FK_matricula_prof) VALUES
('TRN-101', '2026-10-20', '09:00:00', 'Confirmado', 'Control anual', 'HC-001', 'MP-4521'),
('TRN-102', '2026-10-21', '10:30:00', 'Atendido', 'Fiebre y tos', 'HC-002', 'MP-4890'),
('TRN-103', '2026-10-22', '11:15:00', 'Pendiente', 'Dolor lumbar', 'HC-003', 'MP-5120'),
('TRN-104', '2026-10-23', '14:00:00', 'Confirmado', 'Revision cutanea', 'HC-004', 'MP-5334'),
('TRN-105', '2026-10-24', '16:30:00', 'Cancelado', 'Control visual', 'HC-005', 'MP-5891');

INSERT INTO RECETA_MEDICAMENTO (PK_receta_medicamento, FK_id_turno, FK_medico_especialidad, FK_codigo_alfanumerico, indicaciones) VALUES
('REC-501', 'TRN-101', 'ME-01', 'MED-001', '1 cada 24hs con comida'),
('REC-502', 'TRN-102', 'ME-02', 'MED-003', '1 cada 8hs si hay dolor'),
('REC-503', 'TRN-103', 'ME-03', 'MED-002', '1 cada 12hs sublingual'),
('REC-504', 'TRN-104', 'ME-04', 'MED-004', '1 cada 8hs por 7 dias'),
('REC-505', 'TRN-105', 'ME-05', 'MED-005', '1 cada 6hs ante fiebre');