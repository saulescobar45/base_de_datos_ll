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
values ('nombre1','apellido1',1,11111,'user1@gmail.com'),
       ('nombre2','apellido2',2,22222,'user2@gmail.com'),
       ('nombre3','apellido3',3,33333,'user3@gmail.com');

select * from estudiantes;
# muestra los detalles de una tabla
describe estudiantes;

alter table estudiantes
add column direccion varchar (25) default 'el alto';

alter table estudiantes
drop column direccion;

#  para agregar campos a una tabla sin la necesidad de eliminar la tabla

alter table estudiantes
add column fax varchar (20),
add column genero varchar (20);
# para eliminar datos de una tabla
alter table estudiantes
drop column fax;

select *
from estudiantes as est
where est.nombres = 'nombre4';

select est.nombres,
       est.apellidos as 'apellidos de las personas'
       ,est.edad
from estudiantes as est
where est.edad >'18';

select *
from estudiantes as est
where est.id_est mod 2 = 1;

drop table estudiantes;

create table estudiantes(
    id_est int auto_increment primary key not null ,
    nombres varchar(25) not null ,
    apellidos varchar(25) not null ,
    edad int not null ,
    fono int not null ,
    email varchar(50) not null
);
create table materias(
    id_mat int auto_increment primary key not null ,
    nombre_mat varchar(50) not null ,
    cod_mat varchar(50)not null
);
create table inscripcion(
    id_ins int auto_increment primary key not null ,
    id_est int not null ,
    id_mat int not null ,
    foreign key (id_est) references estudiantes(id_est),
    foreign key (id_mat) references materias(id_mat)
);

create table categortias (
    id_cat int auto_increment primary key not null ,
    nombre_cat varchar (50) not null
);

create table publicaciones(
    id_publ int auto_increment primary key not null,
    nombre_publ varchar(25)not null
);

create table libro(
    id_lib int auto_increment primary key not null ,
    titulo varchar(25) not null ,
    isbn varchar (25)not null ,
    published_date date not null ,
    descripcion varchar(25) not null,
    id_cat int not null ,
    id_publ int not null ,
    foreign key (id_cat) references categortias(id_cat),
    foreign key (id_publ ) references  publicaciones(id_publ)
);

create database EMPRESA
drop database EMPRESA;
