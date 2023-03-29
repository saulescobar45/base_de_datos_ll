create database tarea_hito2;
use tarea_hito2;

create table estudiantes(
    id_est int auto_increment primary key not null ,
    nombre varchar (50) not null ,
    apellido varchar (50) not null,
    edad int not null ,
    gestion int not null ,
    fono int not null ,
    email varchar (50) not null ,
    direccion varchar (50) not null ,
    sexo varchar (50) not null
);

create table materias (
    id_mat int auto_increment primary key  not null ,
    nombre_mat varchar (50) not null ,
    cod_mat varchar (50) not null
);

create table inscripcion(
    id_ins int auto_increment primary key not null ,
    semestre varchar (50) not null ,
    gestion int not null ,
    id_est int not null ,
    id_mat int not null ,
    foreign key (id_est) references estudiantes (id_est) on delete cascade ,
    foreign key (id_mat) references  materias (id_mat) on delete cascade
);

INSERT INTO estudiantes (nombre, apellido, edad, gestion, fono, email, direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2018,2832115,'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Sandra', 'Mavir Uria', 25, 2020,2832116, 'sandra@gmail.com','Av. 6 de Agosto', 'femenino'),
('Joel', 'Adubiri Mondar', 30,2019 ,2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
('Andrea', 'Arias Ballesteros', 21,2018, 2832118,'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Santos', 'Montes Valenzuela', 24, 2021 ,2832119,'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
('Urbanismo y Diseno', 'ARQ-102'),
('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
('Matematica discreta', 'ARQ-104'),
('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
(1, 2, '2do Semestre', 2018),
(2, 4, '1er Semestre', 2019),
(2, 3, '2do Semestre', 2019),
(3, 3, '2do Semestre', 2020),
(3, 1, '3er Semestre', 2020),
(4, 4, '4to Semestre', 2021),
(5, 5, '5to Semestre', 2021);

create table dias(
    id_dias int  auto_increment primary key not null ,
    lunes varchar (20) not null ,
    martes varchar (20) not null ,
    miercoles varchar (20) not null ,
    jueves varchar (20) not null ,
    viernes varchar (20) not null
);

select est.id_est,est.nombre,est.apellido,m.nombre_mat,m.cod_mat
from estudiantes as est
inner join inscripcion as i on est.id_est = i.id_est
inner join materias m on i.id_mat = m.id_mat
where m.cod_mat = 'ARQ-105';

select  est.sexo,m.cod_mat
from estudiantes as est
inner join inscripcion i on est.id_est = i.id_est
inner join materias m on i.id_mat = m.id_mat
where m.cod_mat = 'ARQ-105' and est.sexo = 'masculino';

 CREATE  or replace FUNCTION promedio_edades (genero char(5) , codigo_materia varchar (50))
 returns DECIMAL(5,50)
 BEGIN
     DECLARE promedio DECIMAL(5,50);
     SELECT AVG(estudiantes,edad) into promedio;
     from estudiantes
     inner join inscripcion i on est.id_est = i.id_est
     inner join materias m on i.id_mat = m.id_mat
     where m.id_mat = codigo_materia and est.sexo = genero;
     RETURN promedio;
END;

select promedio_edades();

create function tres_cadenas(nombre VARCHAR(50), apellido VARCHAR(50), edad int (50))
RETURNS VARCHAR(150)
BEGIN
    DECLARE resultado VARCHAR(150);

    SET resultado = CONCAT('(', nombre, '), (', apellido, '), (', 50 , ')');

    RETURN resultado;
END;

select tres_cadenas('pepito','pep',50);

create view arquitectura as
SELECT CONCAT(' ', nombre, apellido) AS FULLNAME,
         YEAR(est.edad) AS EDAD,
       YEAR(ins.gestion) AS GESTION,
       IF( YEAR(ins.gestion) = 2021, 'LIBRE', 'NO LIBRE') AS DIA_LIBRE
FROM estudiantes as est
INNER JOIN inscripcion ins ON est.id_est = ins.id_est
INNER JOIN materias mat ON ins.id_mat = mat.id_mat
WHERE mat.nombre_mat = 'Introduccion a la Arquitectura';

create table maestros(
    id_prof int auto_increment primary key not null ,
    nombre_prof varchar (50) not null ,
    area varchar (50) not null ,
    id_est int not null ,
    id_mat int not null ,
    id_ins int not null ,
    foreign key (id_est) references estudiantes(id_est),
    foreign key (id_mat) references  materias (id_mat),
    foreign key (id_ins) references  inscripcion(id_ins)
);

insert into maestros (nombre_prof, area, id_est, id_mat, id_ins)
values ('carlos ','Dibujo y Pintura Arquitectonico',1,1,1),
       ('juan', ' Urbanismo y Diseno',2,2,2);


create view  PARALELO_DBA_I as
select i.id_ins, CONCAT(' ', est.nombre, est.apellido) AS nombre_estudiante,
       m.nombre_mat, ma2.nombre_prof, i.gestion
from estudiantes as est
inner join inscripcion i on est.id_est = i.id_est
inner join materias m on i.id_mat = m.id_mat
inner join maestros ma2 on est.id_est = ma2.id_est
where i.id_ins = 1 and est.nombre = 'Miguel' and m.nombre_mat = 'Introduccion a la Arquitectura' and ma2.nombre_prof =  'carlos ';


