
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autor (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nacionalidad VARCHAR(50),
  fecha_nacimiento DATE
);

CREATE TABLE usuario (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE,
  direccion VARCHAR(100)
);

CREATE TABLE libro (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  isbn VARCHAR(20),
  fecha_publicacion DATE,
  autor_id INTEGER,
  FOREIGN KEY (autor_id) REFERENCES autor(id)
);

CREATE TABLE prestamo (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  usuario_id INTEGER REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE libro_categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  categoria_id INTEGER REFERENCES categoria(id) ON DELETE CASCADE
);
INSERT INTO autor (nombre, nacionalidad, fecha_nacimiento) VALUES
('Gabriel Garcia Marquez', 'Colombiano', '1927-03-06'),
('Mario Vargas Llosa', 'Peruano', '1936-03-28'),
('Pablo Neruda', 'Chileno', '1904-07-12'),
('Octavio Paz', 'Mexicano', '1914-03-31'),
('Jorge Luis Borges', 'Argentino', '1899-08-24');


INSERT INTO libro (titulo, isbn, fecha_publicacion, autor_id) VALUES
('Cien años de soledad', '978-0307474728', '1967-05-30', 1),
('La ciudad y los perros', '978-8466333867', '1962-10-10', 2),
('Veinte poemas de amor y una canción desesperada', '978-0307477927', '1924-08-14', 3),
('El laberinto de la soledad', '978-9681603011', '1950-01-01', 4),
('El Aleph', '978-0307950901', '1949-06-30', 5);


INSERT INTO usuario (nombre, email, fecha_nacimiento, direccion) VALUES
('Juan Perez', 'juan.perez@gmail.com', '1985-06-20', 'Calle Falsa 123'),
('Maria Rodriguez', 'maria.rodriguez@hotmail.com', '1990-03-15', 'Av. Siempreviva 456'),
('Pedro Gomez', 'pedro.gomez@yahoo.com', '1982-12-10', 'Calle 7ma 789'),
('Laura Sanchez', 'laura.sanchez@gmail.com', '1995-07-22', 'Av. Primavera 234'),
('Jorge Fernandez', 'jorge.fernandez@gmail.com', '1988-04-18', 'Calle Real 567');


INSERT INTO prestamo (fecha_inicio, fecha_fin, libro_id, usuario_id) VALUES
('2022-01-01', '2022-01-15', 1, 1),
('2022-01-03', '2022-01-18', 2, 2),
('2022-01-05', '2022-01-20', 3, 3),
('2022-01-07', '2022-01-22', 4, 4),
('2022-01-09', '2022-01-24', 5, 5);


INSERT INTO categoria (nombre) VALUES
('Novela'),
('Poesía'),
('Ensayo'),
('Ciencia Ficción'),
('Historia');

select *from libro;

INSERT INTO libro_categoria (libro_id, categoria_id) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 5),
(3, 2),
(4, 3),
(5, 4);

alter table libro add column paginas int default 20;

alter table libro add column editorial varchar(50) default 'Don Bosco';

SELECT * FROM libro;
select * from autor;

# mostrar todos los libros de los autores de nacionalidad argentino
create view libro_argetino as
select aut.nacionalidad,lib.titulo
from autor as aut
inner join libro lib on aut.id = lib.autor_id
where aut.nacionalidad= 'Argentino';
# mostrar los ibros de la categoria ciencia ficcion

create view libros_ciencia_ficcion as
select lib.titulo as libro,cat.nombre as categoria
from libro_categoria as lc
inner join libro as lib on lc.libro_id=lib.id
inner join categoria as cat on lc.categoria_id = cat.id
where cat.nombre = 'ciencia ficcion';

create view paginas_de_los_libros as
select lib.titulo as litleBook,
       lib.editorial editorialBook,
       lib.paginas pagesBook,
        (
        case
        when lib.paginas> 10 and lib.paginas <= 30 then 'contenido basico'
        when lib.paginas > 30 and lib.paginas <= 80 then 'contenido mediano'
        when lib.paginas > 80 and lib.paginas <= 150 then 'contenido superior'
        else 'contenido avanzado'
        end
        ) as contentBook
from libro as lib;
# de acuerdo a la vista creada
# contar cuantos libros son de contenido medio

 select *
     from paginas_de_los_libros where contentBook = 'contenido medio';

# creando una vista con dos tablas reacionadas
create view Book_and_Autor as
select concat(lib.titulo,' - ',lib.editorial,' - ',cat.nombre) as Book_detail,
        concat(aut.nombre,' - ',aut.nacionalidad) as Autor_Detail
from libro as lib
inner join autor as aut on lib.autor_id = aut.id
inner join libro_categoria as lc on lib.id = lc.libro_id
inner join categoria as cat on lc.categoria_id = cat.id;

# de acuerdo a la vista creada generar lo siguiente
# si el book_detail este la editorial "nova"
# generar una columna que diga "en venta"
# caso contrario colocar en "proceso"


#categoria libro  autor categoria libro

select cat.nombre as category,
         a.nombre as autor,
        a.nacionalidad as nacionalidad
from libro as lib
inner join autor as a on lib.autor_id = a.id
inner join libro_categoria as lc on lib.id = lc.libro_id
inner join categoria as  cat on lc.categoria_id = cat.id
where cat.nombre = 'Historia' and a.nacionalidad = 'Peruano';
# funcion que retorna mi nombre
create or replace function fullname()
    returns varchar(30)
    begin
        return 'Saul Escobar Serrano';
    end;
 select fullname();

create function numero()
returns int
begin
    return 10;
end;
select numero();
    #crear una funcion que reciba un parametro de tipo cadena
create or replace function getNombreCompleto(nombres varchar(30))
returns varchar (30)
begin
    return nombres;
end;
select getNombreCompleto('Saul Escobar Serrano');

# crear una funcion que sume tres numero  la funcion recibe 3 parametros entereos
 create or replace function suma_de_tres_num(num1 int,num2 int,num3 int)
returns int
begin
    declare result int;
    set result = num1 + num2+num3;
    return result;
end;
select suma_de_tres_num(5,4,6);

 create or replace function suma_de_tres_num_v1(num1 int,num2 int,num3 int)
returns int
begin

    return num1 + num2+num3;
end;
select suma_de_tres_num_v1(5,6,7);

# crear una funcion de nombre calculadora
# la funcion recie 3 parametros
# dos int y un varchar
# si el 3 parametro es suma = retornar la suma de los 2 primeros numeros
# si el 3 parametro es resta = retornar la resta de los 2 primeros numeros
# si el 3 parametro es multiplicacion = retornar la multiplicacion de los 2 primeros numeros
# si el 3 parametro es division = retornar la division de los 2 primeros numeros
create  function calculadora(a int ,b int ,accion varchar(30))
returns int
begin

    if  accion = 'suma' then
        	return   a + b;
		if accion ='resta'
			return a - b;
		IF accion= 'multiplicacion'
			return  a * b;
		IF accion = 'division'
			return  a/ b;
			RETURN 1;
end;
select calculadora(5,6,'suma');
select calculadora(8,9,'multiplicaion');


create function calcuadora_v1(a int , b int, tipo varchar(30))
returns int
begin
    declare resp int default 0;
    case tipo
        when 'suma' then set resp = a + b;
         when 'resta' then set resp = a - b;
          when 'multiplicacion' then set resp = a * b;
           when 'division' then set resp = a / b;
        else set resp = 0;
        end case;
    return resp;
end;
select calcuadora_v1(5,9,'suma');

create function valida_Historia_Peru(cat varchar(30),nac varchar (30))
    returns bool
    begin
        declare resp bool default  false;
        if cat = 'Historia' and nac = 'Peruano' then
            set resp = true;
        end if;
        return resp;
    end;


select cat.nombre as category,
         a.nombre as autor,
        a.nacionalidad as nacionalidad
from libro as lib
inner join autor as a on lib.autor_id = a.id
inner join libro_categoria as lc on lib.id = lc.libro_id
inner join categoria as  cat on lc.categoria_id = cat.id
where valida_Historia_Peru(cat.nombre,a.nacionalidad);


