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

