show databases;

create database hito_2;

create database ejemplos;

drop database ejemplos;

use hito_2;


create table estudiante
(
    nombre   varchar(25) primary key not null,
    apellido varchar(25) not null,
    edad     int
);

insert into estudiante(nombre,apellido,edad)
values ('juan','perez',20);

select* from estudiante;
drop database if exists hito_2;
drop table  if exists estudiante;
create database hito_2;
create database universidad;
use hito_2;
create table estudiantes(
    id_est int auto_increment primary key not null ,
    nombres varchar (100) not null ,
    apellidos varchar (100) not null ,
    edad int not null ,
    fono int not null ,
    email varchar (50) not null
);
insert into estudiantes (nombres, apellidos, edad, fono, email)
values ('nombre1','apellido1',1,11111,'user1@gmail.com'),('nombre2','apellido2',2,22222,'user2@gmail.com'),('nombre3','apellido3',3,33333,'user3@gmail.com');
select * from estudiantes;

describe estudiantes;

alter table estudiantes
add column direccion varchar (25) default 'el alto';

alter table estudiantes
drop column direccion;


