CREATE DATABASE dbFabricantes_1;

USE dbFabricantes_1;

CREATE TABLE fabricantes(
	codigoFab INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	PRIMARY KEY (codigoFab)
);

CREATE TABLE articulos(
	codigoArt INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	precio INT NOT NULL,
	codigoFab INT NOT NULL,
	PRIMARY KEY (codigoArt),
	FOREIGN KEY (codigoFab) REFERENCES fabricantes(codigoFab)	
);

--DATOS
INSERT INTO fabricantes(codigoFab,nombre) VALUES
(1,'Intel'),
(2,'Asrock'),
(3,'AMD'),
(4,'Creative'),
(5,'LG'),
(6,'Genius'),
(7,'Western Digital'),
(8,'Samsung');

INSERT INTO articulos(codigoArt,nombre,precio,codigoFab) VALUES
(1,'Tarjeta Madre',270,2),
(2,'Microprocesador Core I7 64bits 2.5 Ghz',450,1),
(3,'Microprocesador Ryzen 7 2.5 Ghz',450,3),
(4,'Parlantes 7.1',10,6),
(5,'Teclado 105 teclado ingles',10,6),
(6,'Case Combo',70,6),
(7,'Disco Duro 1 TB',80,7),
(8,'Disco Duro 500 GB',75,7),
(9,'Fuentes de poder 600w',15,4),
(10,'Monitor 21pulg',110,5),
(11,'Monitor 27pulg',110,4);


--1.	Obtener los nombres de los productos de la tienda.
select *from fabricantes;

select * from articulos;
--2.	Obtener los nombres y los precios de los productos de la tienda.
select *
from fabricantes
where codigoFab = '1' and nombre = 'Intel';

--2.	Obtener los nombres y los precios de los productos de la tienda.
select nombre,precio
from articulos
where nombre = 'Monitor 21pulg' and precio = 110;

--Obtener el nombre de los productos cuyo precio sea menor o igual a 200 $Bs.
--4.	Obtener todos los datos de los artículos cuyo precio esté entre los 60 $Bs y los 120 $Bs (ambas cantidades incluidas).
select *
from articulos
where precio <= 200;

--4.	Obtener todos los datos de los artículos cuyo precio esté entre los 60 $Bs y los 120 $Bs (ambas cantidades incluidas).

--5.	Obtener el nombre y el precio en $US (es decir, el precio en $ multiplicado por 6,93)
select *
from articulos
where precio between 60 and 120;

--5.	Obtener el nombre y el precio en $US (es decir, el precio en $ multiplicado por 6,93)

select nombre,precio * 6.93 as dolares
from articulos
--6.	Seleccionar el precio medio de todos los productos.

select AVG (precio) as precio_medio
from articulos

--7.	Obtener el precio medio de los artículos cuyo código de fabricante sea 2.

select AVG (precio) as precio_medio
from articulos
where codigoFab = 2;

 --8.	Obtener el número de artículos cuyo precio sea mayor o igual a 180 $Bs.
select *
from articulos
where precio >= 120 ;

--9.	Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180 $Bs y ordenarlos descendentemente por precio, y luego ascendentemente por nombre.

select nombre,precio
from articulos
where precio >= 180 order by precio desc,nombre asc;

--10.	Obtener un listado completo de artículos, incluyendo por cada articulo los datos del articulo y de su fabricante.

select 
--11.	Obtener un listado de artículos, incluyendo el nombre del artículo, su precio, y el nombre de su fabricante.------
--12.	Obtener el precio medio de los productos de cada fabricante, mostrando solo los códigos de fabricante.
--13.	Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante.
--14.	Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150 $Bs.
--15.	Obtener el nombre y precio del artículo más barato.
--16.	Añadir un nuevo producto: Altavoces de 70 $Bs (del fabricante 2)
--17.	Cambiar el nombre del producto 8 a 'Impresora Láser’
--18.	Aplicar un descuento del 10 % (multiplicar el precio por 0,10) a todos los productos.
--19.	Aplicar un descuento de 10 $Bs a todos los productos cuyo precio sea mayor o igual a 120 $Bs.


