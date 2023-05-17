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
