create database empresa
use empresa;

create table empleado(
    id_empleado int auto_increment primary key not null ,
    nombre_empleado varchar (25) not null ,
    apellido_empleado varchar (25)not null ,
    edad_empleado int not null ,
    email varchar (50) not null
);
create table area (
    id_trabajo int auto_increment primary key not null ,
    nombre_del_area varchar(50) not null
);

create table empresa(
    id_empresa int auto_increment primary key not null ,
    id_empleado int not null ,
    id_trabajo int not null ,
    nombre_de_empresa varchar(50)not null ,
    foreign key (id_empleado) references empleado (id_empleado),
    foreign key (id_trabajo) references area (id_trabajo)

);

insert into empleado (nombre_empleado, apellido_empleado, edad_empleado, email)
values ('david','fernandez',20,'david21@gmail.com'),
       ('carlos','mamani',23,'carl123@gmail.com'),
       ('hugo','perez',19,'hg41@gmail.com'),
       ('felipe','ignacio',25,'feli12@gmail.com');

insert into area (nombre_del_area)
values ('supervisor'),
       ('acomodador de cajas'),
       ('maquinas'),
       ('repartidor');

insert into empresa (id_empleado, id_trabajo, nombre_de_empresa)
values (1,1,'machucadas'),
       (2,2,'cajerias'),
       (3,3,'minas'),
       (4,4,'dileveri');

select * from empleado;
select * from area;
select * from empresa;

select *
from empleado  as emp
where emp.nombre_empleado = 



