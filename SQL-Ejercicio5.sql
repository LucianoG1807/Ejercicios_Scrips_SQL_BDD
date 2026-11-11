CREATE DATABASE IF NOT EXISTS bd_universidad;
USE bd_universidad;

CREATE TABLE CARRERA (
    PK_codigo_carrera VARCHAR(20) PRIMARY KEY,
    nombre_carrera VARCHAR(100) NOT NULL,
    titulo_otorgado VARCHAR(100) NOT NULL,
    duracion_anios VARCHAR(20),
    resolucion_min VARCHAR(50)
);

CREATE TABLE PLAN_ESTUDIO (
    PK_codigo_plan VARCHAR(20) PRIMARY KEY,
    FK_codigo_carrera VARCHAR(20) NOT NULL,
    anio_resolucion INT,
    estado_vigencia VARCHAR(30),
    total_creditos INT,
    fecha_aprobacion DATE,
    FOREIGN KEY (FK_codigo_carrera) REFERENCES CARRERA(PK_codigo_carrera)
);

CREATE TABLE MATERIA (
    PK_codigo_materia VARCHAR(20) PRIMARY KEY,
    FK_codigo_plan VARCHAR(20) NOT NULL,
    nombre_materia VARCHAR(100) NOT NULL,
    regimen_cursada VARCHAR(30),
    carga_horaria_sem VARCHAR(30),
    anio_curricula INT,
    FOREIGN KEY (FK_codigo_plan) REFERENCES PLAN_ESTUDIO(PK_codigo_plan)
);

CREATE TABLE CORRELATIVA_DE (
    PK_id_correlativa INT PRIMARY KEY,
    FK_codigo_materia_previa VARCHAR(20) NOT NULL,
    FK_codigo_materia_siguiente VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_codigo_materia_previa) REFERENCES MATERIA(PK_codigo_materia),
    FOREIGN KEY (FK_codigo_materia_siguiente) REFERENCES MATERIA(PK_codigo_materia)
);

CREATE TABLE CICLO_LECTIVO (
    PK_anio_ciclo INT PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado_periodo VARCHAR(30),
    periodo_inscripcion VARCHAR(50)
);

CREATE TABLE PROFESOR (
    PK_legajo_docente VARCHAR(20) PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_inst VARCHAR(100),
    categoria_docente VARCHAR(50)
);

CREATE TABLE CURSADA (
    PK_cod_cursada VARCHAR(20) PRIMARY KEY,
    FK_codigo_materia VARCHAR(20) NOT NULL,
    FK_anio_ciclo INT NOT NULL,
    FK_legajo_docente VARCHAR(20) NOT NULL,
    cupo_maximo INT NOT NULL,
    turno_dictado VARCHAR(30),
    aula_asignada VARCHAR(50),
    FOREIGN KEY (FK_codigo_materia) REFERENCES MATERIA(PK_codigo_materia),
    FOREIGN KEY (FK_anio_ciclo) REFERENCES CICLO_LECTIVO(PK_anio_ciclo),
    FOREIGN KEY (FK_legajo_docente) REFERENCES PROFESOR(PK_legajo_docente)
);

CREATE TABLE ALUMNO (
    PK_num_legajo VARCHAR(20) PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    nombre_apellido VARCHAR(100) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_inst VARCHAR(100),
    fecha_ingreso DATE
);

CREATE TABLE INSCRIPCION_ALUMNO_CURSADA (
    PK_inscripcion INT PRIMARY KEY,
    FK_num_legajo VARCHAR(20) NOT NULL,
    FK_cod_cursada VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_num_legajo) REFERENCES ALUMNO(PK_num_legajo),
    FOREIGN KEY (FK_cod_cursada) REFERENCES CURSADA(PK_cod_cursada)
);

------------------------------------------------------------------------

INSERT INTO CARRERA (PK_codigo_carrera, nombre_carrera, titulo_otorgado, duracion_anios, resolucion_min) VALUES
('CARR01', 'Ing. en Sistemas', 'Ingeniero en Sistemas', '5 años', 'Res. 1234/20'),
('CARR02', 'Lic. Administración', 'Lic. en Administración', '4 años', 'Res. 5678/18'),
('CARR03', 'Abogacía', 'Abogado/a', '5 años', 'Res. 4321/19'),
('CARR04', 'Contador Público', 'Contador Público', '4 años', 'Res. 8785/21'),
('CARR05', 'Psicología', 'Lic. en Psicología', '5 años', 'Res. 3456/17');

INSERT INTO PLAN_ESTUDIO (PK_codigo_plan, FK_codigo_carrera, anio_resolucion, estado_vigencia, total_creditos, fecha_aprobacion) VALUES
('PLAN01', 'CARR01', 2020, 'Vigente', 42, '2020-03-01'),
('PLAN02', 'CARR02', 2018, 'Vigente', 38, '2018-12-15'),
('PLAN03', 'CARR03', 2019, 'Vigente', 38, '2019-02-10'),
('PLAN04', 'CARR04', 2021, 'Vigente', 35, '2021-01-20'),
('PLAN05', 'CARR05', 2017, 'No Vigente', 40, '2017-11-05');

INSERT INTO MATERIA (PK_codigo_materia, FK_codigo_plan, nombre_materia, regimen_cursada, carga_horaria_sem, anio_curricula) VALUES
('MAT01', 'PLAN01', 'Algoritmos y Estructuras', 'Anual', '8 hrs', 1),
('MAT02', 'PLAN01', 'Matemática Discreta', 'Cuatrimestral', '6 hrs', 1),
('MAT03', 'PLAN02', 'Administración General', 'Cuatrimestral', '5 hrs', 1),
('MAT04', 'PLAN03', 'Derecho Civil I', 'Anual', '6 hrs', 1),
('MAT05', 'PLAN04', 'Contabilidad Básica', 'Cuatrimestral', '6 hrs', 1);

INSERT INTO CORRELATIVA_DE (PK_id_correlativa, FK_codigo_materia_previa, FK_codigo_materia_siguiente) VALUES
(1, 'MAT01', 'MAT02'),
(2, 'MAT02', 'MAT01'),
(3, 'MAT04', 'MAT04'),
(4, 'MAT05', 'MAT05'),
(5, 'MAT01', 'MAT03');

INSERT INTO CICLO_LECTIVO (PK_anio_ciclo, fecha_inicio, fecha_fin, estado_periodo, periodo_inscripcion) VALUES
(2026, '2026-03-10', '2026-11-30', 'Activo', 'Feb 2026'),
(2025, '2025-03-10', '2025-11-30', 'Cerrado', 'Feb 2025'),
(2024, '2024-03-11', '2024-11-29', 'Cerrado', 'Feb 2024'),
(2023, '2023-03-13', '2023-11-30', 'Cerrado', 'Feb 2023'),
(2022, '2022-03-14', '2022-12-02', 'Cerrado', 'Feb 2022');

INSERT INTO PROFESOR (PK_legajo_docente, DNI, nombre, apellido, correo_inst, categoria_docente) VALUES
('LEG101', '25487965', 'Roberto', 'Gomez', 'r.gomez@univ.edu', 'Titular'),
('LEG102', '22333444', 'Marcela', 'Fernandez', 'm.fernandez@univ.edu', 'Asociado'),
('LEG103', '27888999', 'Esteban', 'Quito', 'e.quito@univ.edu', 'Adjunto'),
('LEG104', '20111222', 'Laura', 'Peralta', 'l.peralta@univ.edu', 'JTP'),
('LEG105', '24555666', 'Sergio', 'Ramirez', 's.ramirez@univ.edu', 'Adjunto');

INSERT INTO CURSADA (PK_cod_cursada, FK_codigo_materia, FK_anio_ciclo, FK_legajo_docente, cupo_maximo, turno_dictado, aula_asignada) VALUES
('CUR01', 'MAT01', 2026, 'LEG101', 80, 'Mañana', 'Aula 204'),
('CUR02', 'MAT02', 2026, 'LEG102', 50, 'Tarde', 'Aula 102'),
('CUR03', 'MAT03', 2026, 'LEG103', 80, 'Noche', 'Aula Magna'),
('CUR04', 'MAT04', 2026, 'LEG104', 45, 'Mañana', 'Aula 305'),
('CUR05', 'MAT05', 2026, 'LEG105', 55, 'Tarde', 'Aula 108');

INSERT INTO ALUMNO (PK_num_legajo, DNI, nombre_apellido, apellido, correo_inst, fecha_ingreso) VALUES
('LEG8001', '42111222', 'Sofia Benítez', 'Benitez', 's.benitez@alumno.edu', '2024-02-15'),
('LEG8002', '43222333', 'Mateo Rossi', 'Rossi', 'm.rossi@alumno.edu', '2023-02-20'),
('LEG8003', '41333444', 'Valentina Ruiz', 'Ruiz', 'v.ruiz@alumno.edu', '2025-02-10'),
('LEG8004', '44444555', 'Lucas Giménez', 'Gimenez', 'l.gimenez@alumno.edu', '2022-02-18'),
('LEG8005', '40555666', 'Camila Torres', 'Torres', 'c.torres@alumno.edu', '2024-02-12');

INSERT INTO INSCRIPCION_ALUMNO_CURSADA (PK_inscripcion, FK_num_legajo, FK_cod_cursada) VALUES
(1001, 'LEG8001', 'CUR01'),
(1002, 'LEG8002', 'CUR02'),
(1003, 'LEG8003', 'CUR03'),
(1004, 'LEG8004', 'CUR04'),
(1005, 'LEG8005', 'CUR05');