create database TAREA_FINAL_HITO4;
use TAREA_FINAL_HITO4;

create table departamento(
    id_dep int auto_increment primary key ,
    nombre_dep varchar(50)
 );
create table provincia(
    id_prov int auto_increment  primary key ,
     nombre_prov varchar(50) ,
     id_dep int ,
     foreign key (id_dep) references departamento (id_dep)
);

create table persona(
     id_per int auto_increment primary key  ,
     nombre varchar(50) ,
     apellido varchar (50) ,
     fecha_de_nac date  ,
     edad int  ,
     email varchar (100)  ,
     sexo varchar (50)  ,
     id_dep int  ,
     id_prov int  ,
     foreign key (id_dep) references  departamento (id_dep)  ,
     foreign key (id_prov) references  provincia (id_prov)
);
create table proyecto(
    id_proy int auto_increment primary key ,
     nombre_proy varchar (50)  ,
    tipo_proy varchar (50)
 );
alter table  proyecto add estado varchar (50);

create table detalle_proyecto(
     id_depy int auto_increment primary key  ,
      id_proy int ,
      id_per int ,
      foreign key (id_proy) references  proyecto (id_proy)  ,
      foreign key (id_per) references  persona (id_per)
);

insert into departamento(nombre_dep)
values ('La Paz'),('El alto'),('Cochabamba');

insert into provincia(nombre_prov, id_dep)
values ('Inquisivi',1),('Provincia Murillo',2),('Chapare',3);

insert into persona(nombre, apellido, fecha_de_nac, edad, email, sexo, id_dep, id_prov)
values ('Vladimir','Callizaya','2002-08-29',21,'vladcg@gmail.com','masculino',1,1),
       ('Nataly','Pinto','2000-10-10',24,'naty@gmail.com','femenino',2,2),
       ('Marcos','Loza','2001-01-16',23,'marc@gmail.com','masculino',3,3);

insert into proyecto(nombre_proy, tipo_proy)
values ('Mopris','Educacion'),('Celestias','Forestacion'),('Chuteros','Cultura');

insert into detalle_proyecto(id_depy, id_proy, id_per)
values (1,1,1),(2,2,2),(3,3,3);

select * from departamento;
select  * from provincia;
select * from persona;
select * from proyecto;
select * from detalle_proyecto;

create function serieFibonacci(limt int)
 returns text
begin
     declare resp text default '';
     declare num1 text default 0;
     declare num2 text default 1;
     declare num3 text default 0;
     declare cont int default 0;
      while cont < limt do
       set resp = CONCAT(resp,num3,',');
       set num1 = num2;
       set num2 = num3;
       set num3 = num1 + num2;
       set cont = cont + 1;
        end while;
      return resp;
     end;

select serieFibonacci(10);


 create or replace function suma_de_serieFibonacci(limt int)
 returns text
      begin
      declare suma int default 0;
      declare num1 text default 0;
      declare num2 text default 1;
      declare num3 text default 0;
      declare cont int default 0;
       while cont < limt do
       set suma = suma + num3;
       set num1 = num2;
       set num2 = num3;
       set num3 = num1 + num2;
       set cont = cont + 1;
       end while;
     return suma;
     end;

select serieFibonacci(10);

select suma_de_serieFibonacci(10);

CREATE or replace VIEW vista_persona AS
SELECT CONCAT(per.nombre,per.apellido) as Nombre_completo,
       per.edad as edad,
       per.fecha_de_nac as fecha_de_nacimiento,
       pro.nombre_proy as nombre_del_proyecto
FROM PERSONA AS per
inner join DETALLE_PROYECTO as de on de.id_per = per.id_per
inner join PROYECTO as pro on pro.id_proy = de.id_proy
inner join departamento as dep on per.id_dep = dep.id_dep
where per.sexo = 'femenino' and per.fecha_de_nac='2000-10-10' and dep.nombre_dep='El alto';

select * from vista_persona;

create trigger manejo_de_trigger1
    before update
    on proyecto
    for each row
    begin
        if new.tipo_proy ='Educacion' or new.tipo_proy = 'Forestacion' or new.tipo_proy ='Cultura' then
            set new.estado = 'ACTIVO';
        ELSE
            SET NEW.estado = 'INACTIVO';
        end IF;
    end;



create trigger calcularmos_edad
    before insert
    on persona
    for each row
    begin

        set new.edad = TIMESTAMPDIFF(year , new.fecha_de_nac, CURDATE());
    END;
select timestampdiff(year ,'2000-10-10',curdate()) as edad;

CREATE OR REPLACE TABLE cambios(
    nombres varchar(50),
    apellido varchar(50),
    fecha_nac date,
    edad int,
    email varchar(50),
    id_dep int,
    id_prov int,
    sexo char(1)
);
# creando trigger
create or replace trigger TRIGGER_NUEVOS_DATOS
    before insert
    on PERSONA
    for each row
    begin
    insert into NEW(NOMBRE, APELLIDO, fecha_de_nac, EDAD, EMAIL, ID_DEP, ID_PROV, SEXO)
        values (NEW.nombre,NEW.apellido,NEW.fecha_de_nac,NEW.edad,NEW.email,NEW.id_dep,new.id_prov,NEW.sexo);
    end;

select dep.nombre_dep,prov.nombre_prov,per.nombre
from persona as per
inner join departamento as dep on dep.id_dep = dep.id_dep
inner join provincia as prov on prov.id_dep = prov.id_dep
where per.sexo = 'masculino' and dep.nombre_dep = 'Cochabamba' and prov.nombre_prov = 'Chapare';

create or replace view vista_nueva as
select dep.nombre_dep,prov.nombre_prov,per.nombre
from persona as per
inner join departamento as dep on dep.id_dep = dep.id_dep
inner join provincia as prov on prov.id_dep = prov.id_dep
where per.sexo = 'masculino' and dep.nombre_dep = 'Cochabamba' and prov.nombre_prov = 'Chapare';

select * from vista_nueva;





