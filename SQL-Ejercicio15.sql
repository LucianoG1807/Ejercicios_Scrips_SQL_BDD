DROP DATABASE IF EXISTS bd_esports;
CREATE DATABASE bd_esports;
USE bd_esports;

CREATE TABLE VIDEOJUEGO (
    PK_codigo_videojuego VARCHAR(20) PRIMARY KEY,
    nombre_juego VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    desarrollador VARCHAR(50),
    plataforma_principal VARCHAR(50)
);

CREATE TABLE EQUIPO (
    PK_id_equipo VARCHAR(20) PRIMARY KEY,
    nombre_equipo VARCHAR(100) NOT NULL,
    razon_social VARCHAR(100),
    fecha_fundacion DATE,
    sitio_web_oficial VARCHAR(150),
    apodo_equipo VARCHAR(50)
);

CREATE TABLE TORNEO (
    PK_id_torneo VARCHAR(20) PRIMARY KEY,
    FK_codigo_videojuego VARCHAR(20) NOT NULL,
    nombre_torneo VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    premio_acumulado DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (FK_codigo_videojuego) REFERENCES VIDEOJUEGO(PK_codigo_videojuego)
);

CREATE TABLE JUGADOR (
    PK_id_jugador VARCHAR(20) PRIMARY KEY,
    FK_id_equipo VARCHAR(20) NOT NULL,
    nickname VARCHAR(50) NOT NULL,
    nombre_real VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol_en_juego VARCHAR(50),
    nacionalidad VARCHAR(50),
    FOREIGN KEY (FK_id_equipo) REFERENCES EQUIPO(PK_id_equipo)
);

CREATE TABLE PARTIDO (
    PK_id_partido VARCHAR(20) PRIMARY KEY,
    FK_id_torneo VARCHAR(20) NOT NULL,
    fecha_juego DATE NOT NULL,
    hora_juego TIME NOT NULL,
    sets_ganados_eq1 INT NOT NULL,
    sets_ganados_eq2 INT NOT NULL,
    mapa_escenario VARCHAR(100),
    FOREIGN KEY (FK_id_torneo) REFERENCES TORNEO(PK_id_torneo)
);

CREATE TABLE ESTADISTICA_JUGADOR (
    PK_id_estadistica VARCHAR(20) PRIMARY KEY,
    FK_id_jugador VARCHAR(20) NOT NULL,
    FK_id_partido VARCHAR(20) NOT NULL,
    bajas_kills INT,
    muertes_deaths INT,
    asistencias_assists INT,
    dano_total_infligido DECIMAL(10,2),
    FOREIGN KEY (FK_id_jugador) REFERENCES JUGADOR(PK_id_jugador),
    FOREIGN KEY (FK_id_partido) REFERENCES PARTIDO(PK_id_partido)
);

CREATE TABLE FICHA_TORNEO_EQUIPO (
    PK_id_ficha VARCHAR(20) PRIMARY KEY,
    FK_id_torneo VARCHAR(20) NOT NULL,
    FK_id_equipo VARCHAR(20) NOT NULL,
    FOREIGN KEY (FK_id_torneo) REFERENCES TORNEO(PK_id_torneo),
    FOREIGN KEY (FK_id_equipo) REFERENCES EQUIPO(PK_id_equipo)
);

------------------------------------------------------------------------

INSERT INTO VIDEOJUEGO (PK_codigo_videojuego, nombre_juego, genero, desarrollador, plataforma_principal) VALUES
('VID-01', 'Counter-Strike 2', 'Shooter táctico', 'Valve', 'PC'),
('VID-02', 'League of Legends', 'MOBA', 'Riot Games', 'PC'),
('VID-03', 'Valorant', 'Shooter táctico', 'Riot Games', 'PC'),
('VID-04', 'Rocket League', 'Deportivos / Acción', 'Psyonix', 'Multiplataforma'),
('VID-05', 'Dota 2', 'MOBA', 'Valve', 'PC');

INSERT INTO EQUIPO (PK_id_equipo, nombre_equipo, razon_social, fecha_fundacion, sitio_web_oficial, apodo_equipo) VALUES
('EQ-01', 'KRÜ Esports', 'KRÜ Esports S.A.', '2020-10-15', 'https://kruesports.gg', 'La Agonía'),
('EQ-02', 'Leviatán', 'Leviatán Esports LLC', '2021-03-10', 'https://leviatan.gg', 'La Ola Turquesa'),
('EQ-03', 'Furia Esports', 'Furia Gaming Ltd.', '2017-08-04', 'https://furia.gg', 'Panteras'),
('EQ-04', 'Cloud9', 'Cloud9 Esports Inc.', '2013-09-01', 'https://cloud9.gg', 'C9'),
('EQ-05', 'Fnatic', 'Fnatic Ltd.', '2004-07-23', 'https://fnatic.com', 'Orange');

INSERT INTO TORNEO (PK_id_torneo, FK_codigo_videojuego, nombre_torneo, fecha_inicio, fecha_fin, premio_acumulado) VALUES
('TRN-01', 'VID-01', 'Major World Series', '2026-11-01', '2026-11-15', 1250000.00),
('TRN-02', 'VID-02', 'Championship Series', '2026-10-10', '2026-10-30', 2000000.00),
('TRN-03', 'VID-03', 'Masters Cup', '2026-12-01', '2026-12-10', 500000.00),
('TRN-04', 'VID-04', 'Rocket Invitational', '2026-09-15', '2026-09-22', 250000.00),
('TRN-05', 'VID-05', 'The International Latam', '2026-08-01', '2026-08-20', 3000000.00);

INSERT INTO JUGADOR (PK_id_jugador, FK_id_equipo, nickname, nombre_real, apellido, rol_en_juego, nacionalidad) VALUES
('JUG-01', 'EQ-01', 'keznit', 'Ángel', 'Mori', 'Duelist', 'Chilena'),
('JUG-02', 'EQ-02', 'kiNgg', 'Francisco', 'Aravena', 'IGL / Controller', 'Chilena'),
('JUG-03', 'EQ-03', 'yuurih', 'Yuri', 'Santos', 'Rifler', 'Brasileña'),
('JUG-04', 'EQ-04', 'Leaf', 'Nathan', 'Orf', 'Initiator', 'Estadounidense'),
('JUG-05', 'EQ-05', 'Boaster', 'Jake', 'Howlett', 'IGL', 'Británica');

INSERT INTO PARTIDO (PK_id_partido, FK_id_torneo, fecha_juego, hora_juego, sets_ganados_eq1, sets_ganados_eq2, mapa_escenario) VALUES
('PAR-01', 'TRN-01', '2026-11-02', '16:00:00', 2, 1, 'Inferno / Mirage / Nuke'),
('PAR-02', 'TRN-02', '2026-10-12', '19:30:00', 3, 0, 'Summoner''s Rift'),
('PAR-03', 'TRN-03', '2026-12-02', '18:00:00', 2, 2, 'Ascent / Bind / Haven'),
('PAR-04', 'TRN-04', '2026-09-16', '15:00:00', 4, 2, 'DFH Stadium'),
('PAR-05', 'TRN-05', '2026-08-05', '14:00:00', 2, 0, 'Dota 2 Map');

INSERT INTO ESTADISTICA_JUGADOR (PK_id_estadistica, FK_id_jugador, FK_id_partido, bajas_kills, muertes_deaths, asistencias_assists, dano_total_infligido) VALUES
('EST-01', 'JUG-01', 'PAR-01', 24, 15, 6, 4500.0),
('EST-02', 'JUG-02', 'PAR-01', 18, 14, 12, 3800.0),
('EST-03', 'JUG-03', 'PAR-02', 12, 3, 8, 21000.0),
('EST-04', 'JUG-04', 'PAR-03', 20, 18, 9, 4100.0),
('EST-05', 'JUG-05', 'PAR-04', 15, 12, 10, 3200.0);

INSERT INTO FICHA_TORNEO_EQUIPO (PK_id_ficha, FK_id_torneo, FK_id_equipo) VALUES
('FIC-01', 'TRN-01', 'EQ-01'),
('FIC-02', 'TRN-01', 'EQ-02'),
('FIC-03', 'TRN-02', 'EQ-03'),
('FIC-04', 'TRN-03', 'EQ-04'),
('FIC-05', 'TRN-05', 'EQ-05');