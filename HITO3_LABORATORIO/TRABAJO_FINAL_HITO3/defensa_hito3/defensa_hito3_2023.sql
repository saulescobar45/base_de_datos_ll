create database defensa_hito3_2023;
use defensa_hito3_2023;



create or replace function elimina_consonates_y_numeros(cad1 text)
returns text
begin
    declare resp text default '';
    declare cont int default 0;
    declare cadena text default CONCAT(cad1,'');
    declare puntero char;

    while cont <= char_length(cadena) do
        set puntero = SUBSTRING(cadena,cont,1);
        if puntero = 'b' or puntero = 'c' or puntero = 'd' or puntero = 'f' or puntero = 'g' or puntero = 'h'or puntero = 'j'or puntero = 'k'or puntero = 'l'or puntero = 'm'or puntero = 'n'or puntero = 'p'or puntero = 'q'or puntero = 'r'or puntero = 's'or puntero = 't'or puntero = 'u'or puntero = 'v'or puntero = 'w'or puntero = 'x'or puntero = 'y'or puntero = 'z' then
            set cont = cont + 1;
            else if puntero = ' ' then
                set cont = cont + 1;
                set resp = CONCAT(resp,puntero,' ');
                else
                set cont = cont + 1;
                set resp = CONCAT(resp,puntero);
            end if;
        end if;
        end while;
    return resp;
end;
drop function elimina_consonates_y_numeros;

select elimina_consonates_y_numeros('base de datos');
select elimina_consonates_y_numeros('bb cc tt mm zzz');
select elimina_consonates_y_numeros('base de  2023');

create table clientes(
id_client int auto_increment primary key not null ,
fullname varchar(50) not null ,
last_name varchar (50) not null ,
age int not null ,
genero varchar(20) not null
);
drop table clientes;

insert into clientes(fullname,last_name,age,genero)
values ('Cristian','Santos',21,'masculino'),
       ('Maria','Ravelo',19,'femenino'),
       ('Jose','Antezana',15,'masculino');

select * from  clientes;

create or replace function  edadMaxima()
returns int
begin
        declare resp int default 0;
        select MAX(clin.age) into RESP
        from clientes as clin;
        return resp;
end;

select edadMaxima();

# siguiente funcion

create or replace function par_e_impar()
returns text
begin
    declare resp text default '';
    declare age int default edadMaxima();
    declare par int default 0;
    declare impar int default age;

    if age mod 2 = 0 then
        while par <= age do
            set resp = CONCAT(resp,par,',');
            set par = par + 1;
            end while;
        else if age mod 2 = 1 then
            while impar >=1 do
             set resp = CONCAT(resp,impar,',');
            set impar= impar - 2;
                end while;
        end if;
    end if;
    return  resp;

end;

select par_e_impar();

create or replace function serieFibonaci(limt int)
returns text
begin
    declare resp text default '';
     declare m int default 0;
    declare n int default 1;
    declare o int default 0;
    declare cont int default 0;
    while cont < limt do
        set resp = concat(resp,o,',');
        set m = n;
         set n = o;
          set o = m + n;
        SET cont  = cont + 1;
        end while;
    return resp;
end;

select serieFibonaci(7);
set @lim = 10;
select serieFibonaci(@lim);

create or replace function remplaza_Palabras(cad1 text,cad2 text,cad3 text)
returns text
begin
     declare resp text default '';
    declare cont int default 0;
    declare cadena text default CONCAT(cad1,cad2,cad3);
    declare puntero char;

    while cont <= char_length(cadena) do
        set puntero = SUBSTRING(cadena,cont,1);
        if puntero = 'Bienvenidos a Unifranz,Unifranz tiene 10 materias' then
            set cont = cont + 1;
            else if puntero = ' Unifranz ' then
                set cont = cont + 1;
                set resp = CONCAT(resp,puntero,' ');
                else if puntero = 'Univalle' then
                set cont = cont + 1;
                set resp = CONCAT(resp,puntero);
                end if;
            end if;
      end if;
          end while;
    return resp;
end;

select replace('Bienvenidos a Unifranz,Unifranz tiene 10 materias','Unifranz','Univalle');



select reverse('hola mundo');




