CREATE DATABASE dbcuentas2;
GO
USE dbcuentas2;
GO

CREATE TABLE usuarios(
	id int IDENTITY(1,1) NOT NULL,
	nom_usr varchar(20) NOT NULL,
	ci_usr varchar(20) NOT NULL,
	nombres varchar(30) NOT NULL,
	apellidos varchar(30) NOT NULL,
	pass varchar(20) NOT NULL,
	email varchar(60) NOT NULL,
	img varchar(100) NULL,
	nivel varchar(10) NOT NULL,
	estado int,
	PRIMARY KEY (id)
);


create table empleados(
  id int,
  ci_emp int,
  nombres varchar(100),
  apellidos varchar (50),
  cargo varchar (30)
  primary key  (id)
);
drop table empleados;


insert into empleados values(1,1234,'Juan','Perez','Chofer');
insert into empleados values(2,2354,'Ana','Perez','Secretaria');
insert into empleados values(3,8745,'Carla','Martines','Vendedor');
insert into empleados values(4,9635,'Hugo','Torres','Vendedor');

insert into empleados values(5,9675,'Lidia','Torrez Lopez','Vendedor');


select * from empleados;
--datos
--usuarios 
INSERT INTO usuarios VALUES ('juanp', '4477665', 'Juan', 'Perez Perez', '12345', 'juanpp@hotmail.com', 'f:\fotos\foto.jpg', 'admin',1);
INSERT INTO usuarios VALUES ('marilu', '55667788', 'Maria Lourdes', 'Morales Nina', '12345', 'marilu@gamail.com', 'f:\fotos\foto.jpg', 'user',0);
INSERT INTO usuarios VALUES ('victortc', '2233445', 'Victor Hugo', 'Ticona Chavez', '54321', 'victorhtc@gmail.com', 'f:\fotos\foto.jpg', 'admin',1);
INSERT INTO usuarios VALUES ('lidiat', '9988776', 'Lidia', 'Torrez Lopez', '54321', 'liditlo@yahoo.com', 'f:\fotos\foto.jpg', 'user',1);
INSERT INTO usuarios VALUES ('carlosp', '987122', 'Carlos Diego', 'Mamani Rivero', '12345', 'carlitos23@hotmail.com', 'f:\fotos\foto.jpg', 'user',0);


select * from usuarios;

--consultas 

-- 1crear una vista los nombres y apellidos de la tabla usuarios

create view vista_usuarios 
as
select us.nombres,us.apellidos
from usuarios as us
go

select * from vista_usuarios;

-- 2crear una vista para mostrar nombres apellidos y el nivel de usuario para los usuarios que estan activos
alter view vista_activos 
as
select us.nombres , us.apellidos , us.estado,us.nivel
from usuarios as us
where us.estado = 1;
go
select * from vista_activos;
--------------------------------------------------------
create view vista_activos1 
as
select us.nombres , us.apellidos , us.estado,us.nivel
from usuarios as us
where us.estado = 1;
go
select * from vista_activos1;

--3 crear una vista  que muestre a los empleados que tienen cargo similar a elmpleado 4
create view vista_cargo_similar
as
select *
from empleados
where cargo = (
select cargo 
from empleados
where id = 4
)
go

select * from vista_cargo_similar;

-- Consusltas sql con union 

--4 realizar y visualizar con union/ union all las tablas usuario y empleado
select * from usuarios;
select * from empleados;

select nombres,apellidos from usuarios
union 
select nombres,apellidos from empleados

select nombres,apellidos from usuarios
union all
select nombres,apellidos from empleados

-- 5crear un vista y realiza una union  las tablas usuario y empleado
create view vista_union_usuario_empleado
as
select nombres,apellidos from usuarios
union 
select nombres,apellidos from empleados
go

select * from vista_union_usuario_empleado;

