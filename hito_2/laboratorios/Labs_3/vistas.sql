create database hito_2_v2;
use hito_2_v2;

create table usuario(
    id_usuario int auto_increment primary key not null ,
    nombres varchar (50) not null ,
    apellidos varchar (50) not null,
    edad int not null ,
    email varchar (50) not null
);

insert into  usuario(nombres, apellidos, edad, email)
values ('nombres1','apellidos2',20,'nom1gamil.com'),
       ('nombres2','apellidos2',24,'nom2gamai.com'),
       ('nombres3','apellidos3',35,'nom3gmail.com');

select * from usuario;

create view mayores_A_35 as
select  us.*
from usuario as us
where us.edad > 35;

alter view mayores_A_35 as
    select  us.nombres,us.apellidos,us.edad,us.email
    from usuario as us
    where us.edad>35;

alter view mayores_A_35 as
    select us.nombres,us.apellidos as 'fuck',us.edad,us.email
    from usuario as us
    where us.edad > 35;

alter view mayores_A_35 as
    select  CONCAT (us.nombres,us.apellidos) as 'fullname', (us.edad) as 'edad de usuario', (us.email) as 'email del usuario'
    from usuario as us
    where us.edad > 35;

select  m.fullname
        m.edad_usuario
        m.email_del_usuario
from mayores_A_35 as m
where m.fullname like '%3';





