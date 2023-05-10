create database MANEJO_DE_CONCEPTOS;
USE MANEJO_DE_CONCEPTOS;
# manejo de cadenas
create OR REPLACE function manejo_concat(cad1 text,cad2 text,cad3 text)
returns text
begin
    declare resp text default ' ';
    set resp = concat(cad1,cad2,cad3);
    return resp;
end;
select manejo_de_concat(' HOLA ',' mundo ',' 2002 ');

drop function manejo_concat;

#manejo de substring
create function manejoSubstring(cad text)
returns text
begin
    declare resp text default ' ';
    declare cont int default locate(' ',cad);
    set resp = substring(cad,1,cont);
    return resp;
end;
select manejo_de_substring('XIMENA CONDORI MAR');

# Para qué sirve la funcion STRCMP
create or replace function manejo_Strcmp(cad1 text,cad2 text,cad3 text)
returns text
begin
    declare resp text default ' ';
    if strcmp(cad1,cad2)=0 then
        set resp = 'las dos  cadenas son iguales';
    else if strcmp(cad2,cad3)=0 then
        set resp = 'las dos cadenas son iguales';
        else if strcmp(cad1,cad3)=0 then
              set resp = 'las dos cadenas son iguales';
              else set resp = 'ninguno de las cadenas es igual';
        end if;
    end if;
    end if;
    return resp;
end;
select manejo_Strcmp('MOSTER','MOUNSTRO','MOSTER1');

# Para qué sirve la función CHAR_LENGTH y LOCATE
create or replace function manejo_Locate(cad text, poro char)
returns text
 begin
     declare resp text default ' ';
     declare cont int default 0;
     declare Nveces int default 0;
     declare puntero1 char;
     if locate(poro,cad) > 0 then
         while cont <= char_length(cad) do
             set puntero1 = substring(cad,cont,1);
             if puntero1 = poro then
                 set nVeces = nVeces + 1 ;
             end if;
             set cont = cont + 1;
             end while;
         set resp = concat('En la cadena ',cad,' la letra ', poro,' se repite ',Nveces);
     end if;
     return resp;
 end;
select manejo_Locate('LIT KHILLA','L');

