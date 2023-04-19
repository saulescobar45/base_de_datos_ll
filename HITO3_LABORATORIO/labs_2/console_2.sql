create database hito_3_2023;
use hito_3_2023;
######### declaramos variables ############
set @usuario = 'ADMIN';
SET @locacion = ' EL ALTO';
####### selecionamos la variable#######
SELECT @usuario;
select @locacion;

create function variable()
returns text
begin
    return @usuario;
end;
select variable();

set @hito3 = 'ADMIN';
######### una funcion con if #######
create function valida_usuario()
returns varchar (50)
begin
    declare respuesta varchar (50);
    if @hito3 = 'ADMIN' THEN
        set respuesta = 'Usuario ADMIN';
        else
        set respuesta = 'Usuario Invitado';
        end if;
    return respuesta;
end;

select valida_usuario()
############# una funcion con case #############
create function valida_usuario2 ()
returns varchar (50)
begin
    declare resp varchar (50);
    case @hito3
        when 'ADMIN' then set resp = 'Usuario ADMIN';
        else set resp = 'Usuario Invitado';
        end case;
    return  resp;
end;

select  valida_usuario2()

#generar los numeros naturales

create function numeros_naturales(limite int)
returns text
begin
    declare cont int default 1;
     declare respuesta text default '';
    while cont <= limite do
    set respuesta = CONCAT(respuesta,cont,' , ');
    set cont = cont + 1;
        end while;
    return respuesta;
end;

select numeros_naturales(10);

create function numeros_pares(limt int)
returns text
begin
    declare cont int default 2;
    declare resp text default '';
    while cont <= limt do
        set resp = CONCAT(resp,cont,',');
        set cont = cont + 2;
        end while;
    return resp;
end;
select numeros_pares(10)

set @numeros = '2,1,4,3,6,5,8,7';

create function gerar_numerosfeo(limt int)
returns text
    begin


        return @numeros;

end;
select gerar_numerosfeo()
 # ######### generar numeros pares e impares###########
create function pares_impares(limt int)
returns text
begin
    declare pares int default 2;
    declare impares int default 1;
    declare cont int default 1;
    declare resp text default '';

    while cont <= limt do
        if cont %2 = 1 then
            set resp = CONCAT(resp,pares,',');
            set pares = pares + 2;
            else
            set resp = CONCAT(resp,impares,',');
            set impares = impares + 2;
        end if;
        set cont = cont + 1;
        end while;
    return resp;
end;

select  pares_impares(8)

create or replace function manejo_de_repeat(x int)
returns text
begin
    declare str text default '';
    repeat
    set str = CONCAT(str , x , ',');
    set x = x - 1;
    until x <= 0 end repeat;
    return str;
end;

select manejo_de_repeat(10)

create or replace function manejo_de_repeatv2(x int )
returns text
begin
     declare str text default '';
    repeat
        if x%2 = 0 then
            set str = CONCAT(str , x ,'-AA-');
            ELSE
            set str = CONCAT( str , x , '-BB-');
        end if;
    set str = CONCAT(str , x , ',');
    set x = x - 1;
    until x <= 0 end repeat;
    return str;
end;

select manejo_de_repeatv2(10)

create function manejo_de_loop(x int)
returns text
begin
    declare resp text default '';
    DBAII:loop
    IF X > 0 THEN
        LEAVE   DBAII;

end if;
    set resp = CONCAT(resp, x , ',');
    set x = x + 1;
    iterate DBAII;
    end loop;
    return resp;
end;

select manejo_de_loop (-10);

create function manejo_de_loopv2(x int)
returns text
begin
    declare resp text default '';
    DBAII:loop
    IF X > 0 THEN
        LEAVE   DBAII;
         end if;
    if x%2 = 0 then
            set resp = CONCAT(resp , x ,'-AA-');
            ELSE
            set resp = CONCAT( resp , x , '-BB-');
        end if;
    set resp = CONCAT(resp, x , ',');
    set x = x + 1;
    iterate DBAII;
    end loop;
    return resp;
end;

select manejo_de_loopv2(-10);

create function credit_number(x int)
returns text
begin
    declare resp text default '';
    if x = 50000 then
        set resp = ( 'PLATINIUM');
    end if;
    if x = 10000 then
        set resp = ('GOLD');
    end if;
    if x = 1000 then
        set resp =( 'SILVER');
    end if;
    RETURN resp;
end;

SELECT credit_number(10000);

create function credit_numberV2(x int)
returns text
begin
    declare resp text default '';
    if x > 50000 then
        set resp = ( 'PLATINIUM');
    end if;
    if x >= 10000  and  x <= 50000 then
        set resp = ('GOLD');
    end if;
    if x < 1000 and x >= 0 then
        set resp =( 'SILVER');
    end if;
    RETURN resp;
end;
SELECT credit_numberV2(50000);
SELECT credit_numberV2(10000);
SELECT credit_numberV2(1000);

create function credit_numberV3(x int)
returns text
begin
    declare resp text default '';
    if x > 50000 then
        set resp = ( 'PLATINIUM');
    end if;
    if x >= 10000  and  x <= 50000 then
        set resp = ('GOLD');
    end if;
    if x < 1000 and x >= 0 then
        set resp =( 'SILVER');
    end if;
    RETURN resp;
end;

select credit_numberV3(10000);
select credit_numberV3(999);

# uso del charlength
# nos permite contar cuantas palabras tien un caracter
 select char_length('DBAII 2023');

create function valida_length_7(password int)
returns text
begin
    declare resp text default '';
    if char_length(password) > 7 then
        set resp = 'PASSED';
        else
        set resp = 'FAILED';
    end if;
    RETURN resp;
end;

select valida_length_7(12345678);

# compararcion de cadenas
# es saber que dos cadenas son iguales

select strcmp('DBAII 2023','DBAII 2023');

create or replace function cadenas(CADENA1 TEXT , CADENA2 TEXT)
returns text
begin
    declare resp text default  '';
    IF strcmp(CADENA1,CADENA2)= 0 THEN ;
    SET resp = ' cadenas iguales';
    else
        set resp = 'cadenas distintas';
        end if;
    return resp;
end;

select cadenas('dbaii','dbai');


