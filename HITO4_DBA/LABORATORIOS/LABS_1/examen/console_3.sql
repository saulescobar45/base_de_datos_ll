create database defensa_2023_hito4;
use defensa_2023_hito4;

create table departamento(
    id_dep int  primary key ,
    nombre_dep varchar(50)
 );

create table provincia(
    id_prov int   primary key ,
     nombre_prov varchar(50) ,
     id_dep int ,
     foreign key (id_dep) references departamento (id_dep)
);

create table persona(
     id_per int  primary key  ,
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
    id_proy int  primary key ,
     nombre_proy varchar (50)  ,
    tipo_proy varchar (50)
 );

create table detalle_proyecto(
     id_depy int  primary key  ,
      id_proy int ,
      id_per int ,
      foreign key (id_proy) references  proyecto (id_proy)  ,
      foreign key (id_per) references  persona (id_per)
);

insert into departamento(id_dep,nombre_dep)
values (1,'La Paz'),(2,'El alto'),(3,'Cochabamba');

insert into provincia(id_prov,nombre_prov, id_dep)
values (1,'Inquisivi',1),(2,'Provincia Murillo',2),(3,'Chapare',3);

insert into persona(id_per,nombre, apellido, fecha_de_nac, edad, email, sexo, id_dep, id_prov)
values (1,'Vladimir','Callizaya','2002-08-29',21,'vladcg@gmail.com','masculino',1,1),
       (2,'Nataly','Pinto','2000-10-10',24,'naty@gmail.com','femenino',2,2),
       (3,'Marcos','Loza','2001-01-16',23,'marc@gmail.com','masculino',3,3);

insert into proyecto(id_proy,nombre_proy, tipo_proy)
values (1,'Mopris','Educacion'),(2,'Celestias','Forestacion'),(3,'Chuteros','Cultura');

insert into detalle_proyecto(id_depy, id_proy, id_per)
values (1,1,1),(2,2,2),(3,3,3);

select * from departamento;
select * from provincia;
select * from persona;
select * from proyecto;
select * from detalle_proyecto;

create table audit_proyect(
    id_aud int auto_increment primary key ,
    nombre_proy_anterior varchar(50),
    nombre_proy_posterior varchar(50),
    tipo_proy_amterior varchar(50),
    tipo_proy_posterior varchar(50),
    operacion varchar(50),
    userld varchar(50),
    hostname varchar(50)
);

create trigger tr_trigger_update
    AFTER UPDATE
    ON proyecto
    FOR EACH ROW
    BEGIN
        declare anterior text default CONCAT(old.id_proy,' ',old.nombre_proy,' ',old.tipo_proy);
        declare posterior text default CONCAT(old.id_proy,' ',new.nombre_proy,' ',new.tipo_proy);
        insert into audit_proyect(operacion, userld, hostname,id_aud, nombre_proy_anterior, nombre_proy_posterior, tipo_proy_amterior, tipo_proy_posterior )
        select now(),user(),@@hostname
    end;


create view reporte_proyecto as
select CONCAT(per.nombre,' ',per.apellido) as fullname,
       proy.nombre_proy = desc_proyecto,
       dep.nombre_dep = departamento,
       dep.codigo_dep = codigo_dep,
       case per.nombre
        when 'Cochabamba' then 'cbb'
        else 'a/b'
        end as codigo_dep
        from persona as per
        inner join departamento dep on dep.id_dep = dep.id_dep
        inner join proyecto as proy on proy.id_proy = proy.id_proy;

        select * from reporte_proyecto;

create or replace trigger tr_trigger_validacion
    before insert
    on proyecto
    for each row
    begin
        declare dia_de_la_semana text default ' ';
        declare mes text default '';
        declare proyecto text default '';

        set proyecto = new.tipo_proy;
        set dia_de_la_semana = dayname(current_date);
        set mes = month(current_date);

        if proyecto = 'Forestacion' and  dia_de_la_semana = 'Wednesday' and mes = 'junio' then
            signal sqlstate '45000' set
            message_text  = 'no se admitira ese dia la forestacion';
        end if;

    end;

insert into proyecto(id_proy, nombre_proy, tipo_proy)
        values(2,'Celestias','Forestacion');
insert into proyecto(id_proy, nombre_proy, tipo_proy)
        values (3,'Chuteros','Cultura');

create function diccionario_de_la_semana(semana text)
        returns  text
        begin
            declare resp text default '';

            set dias_de_la_semana = lower(dia_de_la_semana);
            set resp 




  end;







