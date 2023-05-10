create database tarea_hito3;
use tarea_hito3;

create table estudiantes(
    id_est int auto_increment primary key not null ,
    nombres varchar(50)  not null ,
    apellidos varchar(50) not null ,
    edad int not null ,
    fono int not null ,
    email varchar (100) not null ,
    direccion varchar(100) not null ,
    sexo varchar (50) not null

);

create table materias(
    id_mat int auto_increment primary key not null ,
    nombre_mat varchar (50) not null ,
    cod_mat varchar (100) not null

);

create table inscripcion(
    id_ins int auto_increment primary key not null ,
    semestre varchar (50) not null ,
    gestion int not null ,
    id_est int not null ,
    id_mat int not null,
    foreign key (id_mat) references materias (id_mat) on delete cascade,
    foreign key (id_est) references estudiantes (id_est) on DELETE cascade
);

insert into estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
values ('Miguel','Gonzales Veliz',20,2832115,'Miguel@gmail.com','Av.6 de agosto','Masculino'),
       ('Sandra','Mavir Uria',25,2832116,'Sandra@gmail.com','Av.6 de agosto','Femenino'),
       ('Joel','Aduviri Mondar',30,2832117,'Joel@gmail.com','Av.6 de agosto','Masculino'),
       ('Andrea','Arias Ballesteros',21,2832118,'Andrea@gmail.com','Av.6 de agosto','Femenino'),
       ('Santos','Moantes Valenzuela',24,2832119,'Samtos@gmail.com','Av.6 de agosto','Masculino');

insert into materias (nombre_mat, cod_mat)
values ('Introduccion a la Arquitectura','ARQ-101'),
       ('Urbanicacion y Diseño','URB-102'),
       ('Dibujo y Pintura Arquitectonica','DPA-103'),
       ('Matematica discreta','MAT-104'),
       ('Fisica basica','FSB-105');

insert into inscripcion (semestre, gestion, id_est, id_mat)
values ('1er Semetre',2018,1,1),
       ('2do Semetre',2018,1,2),
       ('1er Semetre',2018,2,4),
       ('2do Semetre',2018,2,3),
       ('2do Semetre',2018,3,3),
       ('3ro Semetre',2018,3,1),
       ('4to Semetre',2018,4,4),
       ('5to Semetre',2018,5,5);

select * from estudiantes;
select * from materias;
select * from inscripcion;

# tarea
# Crear una función que genere la serie Fibonacci.
create function serieFibonaci(lim int)
    returns text
begin
    declare respuesta text default '';
    declare x int default 0;
    declare y int default 1;
    declare z int default 0;
    declare cont int default 0;
    while cont < lim do
        set respuesta = concat(respuesta,z,',');
        set x = y;
         set y = z;
          set z = x + y;
        SET cont  = cont + 1;
        end while;
    return respuesta;
end;
select serieFibonaci(7);

# tarea 13
# Crear una variable global a nivel BASE DE DATOS.

SET @lim = 10;
select serieFibonaci(@lim);

#tarea 14
# Crear una función no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).
create or replace function edad_Minima()
returns int
begin
    declare resp int default 0;
    select MIN(est.Edad) into RESP
    from Estudiantes AS est;
    return resp;
end;
select edad_Minima();
#CREANDO SEGUNDA FUNCION
create function par_impar()
returns  text
begin
    declare resp text default '';
     declare edad int default edad_Minima();
     declare par int default 0;
     declare impar int default edad;
    if edad mod 2 = 0 then
        while par<=edad do
            set resp = CONCAT(resp,par,',');
            set par = par + 2;
        end while;
        else if edad mod 2 = 1 then
            while impar >= 1 do
            set resp = CONCAT(resp,impar,',');
            SET impar = impar - 2;
        end while;
        end if;
    end if;
    RETURN resp;
end;
select par_impar();

# tarea 15
# .Crear una función que determina cuantas veces se repite las vocales.
create function separa_Vocales(cad text)
returns text
begin
    declare resp text default '';
     declare cont int default 0;
     declare contA int default 0;
     declare contE int default 0;
     declare contI int default 0;
     declare contO int default 0;
     declare contU int default 0;
     declare puntero char;
    while cont <=CHAR_LENGTH(cad) do
        set puntero = SUBSTRING(cad,cont,1);
        if puntero = 'a' then
            set contA = contA +1;
        end if;
         if puntero = 'e' then
            set contE = contE +1;
        end if;
         if puntero = 'i' then
            set contI = contI +1;
        end if;
         if puntero = 'o' then
            set contO = contO +1;
        end if;
         if puntero = 'u' then
            set contU = contU +1;
        end if;
            set cont = cont +1;
    end while;
    set resp = concat('a: ',contA,', e: ',contE,', i: ',contI,', o: ',contO,', u: ',contU);
    return resp;
end;
select separa_Vocales('talles de base de datos');

# tarea 16
# Crear una función que recibe un parámetro INTEGER
create function Creditos(cretid_number INT)
returns  text
begin
    declare resp text default '';
    case
        when cretid_number > 50000 then set RESP='PLATINUM';
        when cretid_number >= 10000 and cretid_number <=50000 then set resp='GOLD';
        when cretid_number < 10000 and cretid_number >=0 then set resp='SILVER';
        end case;
    return resp;
end;
select Creditos(1000);
select Creditos(999999);

#17 eliminamos las vocales

create function sin_Vocales(cad1 TEXT,cad2 TEXT)
returns text
begin
    declare resp text default '';
    declare cadena text default CONCAT(cad1,'-',cad2);
    declare puntero char;
    declare cont int default 1;
    while cont <=CHAR_LENGTH(cadena) do
        set puntero = SUBSTRING(cadena,cont,1);
        if puntero = 'a' or puntero = 'e' or puntero = 'i' or puntero = 'o' or puntero = 'u'  then
            set cont  = cont + 1;
        else if puntero = ' ' then
            set cont = cont +1;
            set resp = CONCAT(resp,puntero,' ');
        else
            set cont = cont +1;
            set resp = CONCAT(resp,puntero);
        end if;
        end if;
    end while;
    return resp;
end;
SELECT sin_Vocales('TALLER DBA II','GESTION 2023');

#tarea 18
# Crear una función que reciba un parámetro TEXT
create function letter(cad text)
returns text
begin
    declare resp text default  '';
    declare puntero text default '';
    declare cont int default 0;
    repeat
        set puntero = SUBSTRING(cad,cont);
        set resp = CONCAT(resp,puntero,',');
        set cont = cont +1;
    until cont >CHAR_LENGTH(cad)
        end repeat;
    return resp;
END;
SELECT letter('dbaii');


