create database hito_4_2023;
use hito_4_2023;

create table numeros (
    numero bigint primary key not null ,
    cuadrado bigint  ,
    cubo bigint ,
    raiz_cuadrada real,
    suma_total real
);

DROP TABLE numeros;

insert into numeros(numero) values (2);
insert into numeros(numero) values (4);

select * from  numeros;


create or replace trigger tr_completa_datos
    before insert
    on numeros
    for each row
    begin
        set new.cuadrado = power(new.numero,2);
          set new.cubo = power(new.numero,3);
          set new.raiz_cuadrada = sqrt(new.numero);
        set new.suma_total = new.numero+new.cuadrado+new.cubo+new.raiz_cuadrada;
    end;
insert into numeros (numero) values (2);
insert into numeros (numero) values (3);
select * from numeros;
#insert into numeros(numero) values (4);
#select * from numeros;
show triggers ;

create or replace trigger completa_datos
     before insert
    on numeros
    for each row
    begin
        declare valor_cuadrado bigint;
        declare valor_cubo bigint;
        declare valor_raiz real;
        declare valor_total real;

         set valor_cuadrado = power(new.numero,2);
         set valor_cubo = power(new.numero,3);
         set valor_raiz = sqrt(new.numero);
         set valor_total = sqrt(new.numero);

        set new.cuadrado = valor_cuadrado;
          set new.cubo = valor_cubo;
          set new.raiz_cuadrada = valor_raiz;
        set new.suma_total = valor_total;
    end;
select *from numeros;

create table usuario(
    id_usuario int auto_increment primary key not null ,
    nombres varchar(50) not null ,
    apellidos varchar (50) not null ,
    edad int not null ,
    correo varchar(50) not null,
    password varchar (50)not null
);
drop table usuario;
insert into usuario(nombres, apellidos, edad,correo)
values ('Willam','Barras',33,'WillBa@mail.com');

create trigger genera_password
    before insert
    on usuario
    for each row
    begin
        set new.password = CONCAT(
            SUBSTRING(new.nombres,1,2),
            SUBSTRING(new.apellidos,1,2),
            new.edad
            );
    end;
insert into usuario(nombres, apellidos, edad,correo)
values ('Willam','Barras',33,'WillBa@mail.com');
select *from usuario;
####################################################    LABS-2   ###########################################################
drop trigger genera_password;
drop trigger genera_password_AFTER;

select last_insert_id();
#no se puede modificar un registro desde un trigger cuando se esta insertando

create or replace trigger genera_password_AFTER
    before insert
    on usuario
    for each row
    begin
        update  usuario set password =  CONCAT(
            SUBSTRING(nombres,1,2),
            SUBSTRING(apellidos,1,2),
            edad
            )
        where id_usuario = last_insert_id();
    end;

insert into usuario(nombres, apellidos, edad,correo)
values ();
select *from usuario;
drop table usuario;

create table usuario(
    id_usuario int auto_increment primary key not null ,
    nombres varchar(50) not null ,
    apellidos varchar (50) not null ,
    fecha_de_nacimiento date not null ,
    correo varchar(50) not null,
    password varchar (50)not null,
    edad int
);

create or replace trigger tr_calcula_pass_edad
    before insert
    on usuario
    for each row
    begin
          set new.password = lower(
              CONCAT(
            SUBSTRING(new.nombres,1,2),
            SUBSTRING(new.apellidos,1,2),
            substring(new.correo,1,2)
             ) );
          set new.edad = timestampdiff(year,new.fecha_de_nacimiento,curdate());

    end;
select timestampdiff(year,'2002-12-17',curdate()) as edad;
#esto permite determinar el formato de la fecha determinado
    select current_date;

    insert into usuario(nombres, apellidos, fecha_de_nacimiento, correo)
    values ('Pepito','Baca pereira','2000-05-20','pepebac@gmail.com');

    select * from usuario;

# creaar un trigger para la tabla usuario
#verificar si el password tiene mas de 10 caracteres
#si tiene los 10 caracteres no tocar
# si no tiene los 10 caracteres tomar los 2 ultimos caracteres de nombre y apellido y edad

create or replace trigger tr_practica1
    before insert
    on usuario
    for each row
    begin
        set new.edad = timestampdiff(year,new.fecha_de_nacimiento,curdate());
        if length(new.password) < 10 then
             set new.password = lower(
              CONCAT(
            SUBSTRING(new.nombres,-2),
            SUBSTRING(new.apellidos,-2),
                  new.edad
             ) );

        end if;
    end;

insert into usuario(nombres,apellidos,fecha_de_nacimiento,correo,password)
values ('Kikito','Baca Pereira','2001-12-20','kitbac@gmail.com','123456');

truncate table usuario;
select *from usuario;

select dayname(current_date);

insert into usuario(nombres,apellidos,fecha_de_nacimiento,correo)
values ('Kikito','Baca Pereira','2001-12-20','kitbac@gmail.com');

create or replace trigger tr_usuario_mantenimiento
    before insert
    on usuario
    for each row
    begin
        declare dia_de_la_semana text default '';
        set dia_de_la_semana = dayname(current_date);

        if dia_de_la_semana = 'Wednesday' then
            signal sqlstate '45000'
            set message_text = 'anda pa sha bobo anda pa sha esta base de datos en mantenimiento';
        end if;
    end;
drop trigger tr_usuario_mantenimiento;

insert into usuario(nombres,apellidos,fecha_de_nacimiento,correo)
values ('Kikito','Baca Pereira','2001-12-20','kitbac@gmail.com');

alter table usuario add column nacionalidad varchar (50);
select *from usuario;

create or replace trigger tr_mostrando_nacionalidad
    before insert
    on usuario
    for each row
    begin
        declare mostrando_nacionalidad text default '';


        if mostrando_nacionalidad = 'Bolivia,Argentina,Paraguay' then
            signal sqlstate '45000'
            set message_text = 'la nacionalidad no pertenece';
        end if;
    end;
insert into usuario(nombres,apellidos,fecha_de_nacimiento,correo,nacionalidad)
values ('juan','perez','2002-10-02','juaper@gmail.com','Chile');
select * from usuario;
select 'Bolivia' in ('Argentina0','Bolivia','PAraguay');

select *from usuario;

create table usuario_v2(
    id_usr int primary key not null ,
    nombre_completo varchar(50) not null ,
    fecha_nac date not null ,
    correo varchar (50) not null ,
    password varchar (100)
);

select current_date;

insert into usuario_v2(id_usr, nombre_completo, fecha_nac, correo, password)
values (12345,'William Barras','1990-01-01','bw@gmail.com','1234567');

select *from usuario_v2;

# como hacer la fecha actual
select current_date;
select now();

# me permite tener el usuario logueado
select user();

# me premite obtener el hostname
select @@hostname;
#este comando me permite ver las variables de la based de datos
show variables ;

create table audit_usuario_v2(
    fecha_mod text not null ,
    usuario_log text not null ,
    hostname text not null ,
    accion text not null ,

    id_usr text not null ,
    nombre_completo text not null ,
    passwoed text not null
);

create trigger tr_audit_usuario_v2
    after delete
    on usuario_v2
    for each row
    begin
        declare id_usuario text;
        declare nombres text;
        declare password1 text;

        set id_usuario = old.id_usr;
        set nombres = old.nombre_completo;
        set password1 = old.password;

        insert into audit_usuario_v2(fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, passwoed)
            select now(),user(),@@hostname,'delete',id_usuario,nombres,password1;
    end;
insert into usuario_v2(id_usr, nombre_completo, fecha_nac, correo, password)
values (987451,'Juakin','2002-05-10','pt@gmail.com','987456');

select *from usuario_v2;
select * from audit_usuario_v2;

create or replace trigger tr_audit_usuario_v2
    after insert
    on usuario_v2
    for each row
    begin

        insert into audit_usuario_v2(fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, passwoed)
            select now(),user(),@@hostname,'insert',new.id_usr,new.nombre_completo,new.password;
    end;

insert into usuario_v2(id_usr, nombre_completo, fecha_nac, correo, password)
values (654123,'Pepito','2003-05-12','ppt@gmail.com','258741');

insert into usuario_v2(id_usr, nombre_completo, fecha_nac, correo, password)
values (3697412,'Charlitos','2000-05-12','cht@gmail.com','2482638');

select *from usuario_v2;

select * from audit_usuario_v2;

# crear un trigger update para la tabla usuario-v2
# agregar dos campos adicionales
# antes del cambio = concat(id_user nombre fecha nac )
# despues del cambio = concat (id_usur - nombre - fecha nac)

create table audit_usuario_v3(
    fecha_mod text not null ,
    usuario_log text not null ,
    hostname text not null ,
    accion text not null ,
    antes_del_cambio text not null ,
    despues_del_cambio text not null
);

create or replace trigger tr_audit_usuario_v3
    after update
    on usuario_v2
    for each row
    begin
       declare antes text default CONCAT(old.id_usr,' ',old.nombre_completo,' ',old.correo);
        declare despues text default CONCAT(old.id_usr,' ',new.nombre_completo,' ',new.correo);

        insert into audit_usuario_v3(fecha_mod, usuario_log, hostname, accion, antes_del_cambio, despues_del_cambio)
            select now(),user(),@@hostname,'update',antes,despues;

    end;

select * from usuario_v2;

select * from audit_usuario_v3;

create or replace procedure insertar_dato(fecha text,usuario text,hostname text,accion text,antes text , despues text)
begin

     insert into audit_usuario_v3(fecha_mod, usuario_log, hostname, accion, antes_del_cambio, despues_del_cambio)
            values (fecha,usuario,hostname,accion,antes,despues);

     call insertar_dato(now(),user(),@@hostname,'update',antes , despues);
end;
select *from usuario_v2;
select * from audit_usuario_v3;







