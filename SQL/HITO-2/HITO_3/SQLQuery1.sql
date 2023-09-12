CREATE DATABASE dbempleados2;
GO
USE dbempleados2;
GO
CREATE TABLE empleados(
  nroemp INT,
  nombres VARCHAR(30),  
  apellidos VARCHAR(30),  
  salario FLOAT,
  nrodpto INT,
  cargo VARCHAR(50),
  PRIMARY KEY(nroemp) 
);

CREATE TABLE pedidos(
  nroPedido INT,
  fecha DATE,  
  detalle VARCHAR(100),
  cantidad INT,
  total FLOAT,
  idCliente INT,
  nroEmpv INT,
  PRIMARY KEY(nroPedido),
  FOREIGN KEY(nroEmpv) REFERENCES empleados(nroemp) 
);

INSERT INTO empleados VALUES(1,'Juan','Perez',2800,101,'Asistente');
INSERT INTO empleados VALUES(2,'Ana', 'Melendrez',6000,100,'Gerente');
INSERT INTO empleados VALUES(3,'Carlos','Tobar',4000,102,'Supervisor');
INSERT INTO empleados VALUES(4,'Rene','Poma',2800,102,'Asistente');
INSERT INTO empleados VALUES(5,'Jhon', 'Quino',3000,101,'Vendedor');
INSERT INTO empleados VALUES(6,'Ericka','Torrez',3500,102,'Vendedor');
INSERT INTO empleados VALUES(7,'Carmen','Ticona',3500,102,'Vendedor');
INSERT INTO empleados VALUES(8,'Hugo','Torrez',2800,102,'Asistente');
INSERT INTO empleados VALUES(9,'Fabio','Contreras',3500,103,'Vendedor');
INSERT INTO empleados VALUES(10,'Alejandro','Tellez',3500,103,'Vendedor');
INSERT INTO empleados VALUES(11,'Martin','Poma',4000,103,'Supervisor');
INSERT INTO empleados VALUES(12,'Dennis','Quijarro',2800,101,'Vendedor');
INSERT INTO empleados VALUES(13,'Elena','Morales',3200,101,'Asistente');
INSERT INTO empleados VALUES(14,'Vicente', 'Fernandez',8000,100,'Administrador');
INSERT INTO empleados VALUES(15,'Fatima', 'Lopez',1500,100,'Portero');
INSERT INTO empleados VALUES(16,'Dolores', 'Lima',1900,100,'Asistente');
INSERT INTO empleados VALUES(17,'Fernando', 'Caceres',2900,101,'Vendedor');


INSERT INTO pedidos VALUES(1,'2010-01-01','Papas fritas',10,100,1,5);
INSERT INTO pedidos VALUES(2,'2010-01-02','Caramelos',1,10,2,6);
INSERT INTO pedidos VALUES(3,'2010-01-03','Galletas',3,30,3,7);
INSERT INTO pedidos VALUES(4,'2010-01-04','Chocolate',2,50,4,9);
INSERT INTO pedidos VALUES(5,'2010-01-05','Leche',6,60,5,10);
INSERT INTO pedidos VALUES(6,'2010-01-06','Mantequilla',20,50,6,12);

INSERT INTO pedidos VALUES(7,'2010-02-01','Mantequilla',1,10,7,5);
INSERT INTO pedidos VALUES(8,'2010-02-02','Leche',10,100,8,6);
INSERT INTO pedidos VALUES(9,'2010-02-03','Chocolate',10,50,9,7);
INSERT INTO pedidos VALUES(10,'2010-02-04','Papas fritas',5,100,10,9);
INSERT INTO pedidos VALUES(11,'2010-02-05','Caramelos',10,10,11,10);
INSERT INTO pedidos VALUES(12,'2010-02-06','Galletas',5,10,12,12);

INSERT INTO pedidos VALUES(13,'2010-03-01','Caramelos',5,5,1,5);
INSERT INTO pedidos VALUES(14,'2010-03-02','Galletas',1,2,2,6);
INSERT INTO pedidos VALUES(15,'2010-03-03','Chocolate',2,5,3,7);
INSERT INTO pedidos VALUES(16,'2010-03-04','Leche',3,18,4,9);
INSERT INTO pedidos VALUES(17,'2010-03-05','Mantequilla',5,50,5,10);
INSERT INTO pedidos VALUES(18,'2010-03-06','Papas fritas',5,50,6,12);

select * from empleados;
select * from pedidos;

--SUBCOSULTAS EN LA LISTA DE SELECCION
--Listar los id, nombres y fecha del primer pedido que realiz  cada empleado. 
SELECT nroemp, nombres, (SELECT MIN(fecha) FROM pedidos WHERE nroEmpv = nroemp) AS Fecha1raVenta
FROM empleados
WHERE cargo='Vendedor' ;

-- practica
select nroemp,nombres,(select min(fecha)from pedidos where nroEmpv = nroemp) as fecha_1ra_Venta
from empleados
where cargo = 'Vendedor';

--Otra forma sin subconsulta en la seleccion
SELECT A.nroemp, A.nombres, MIN(B.fecha) AS Fecha1raVenta
FROM empleados A INNER JOIN pedidos B ON A.nroemp = B.nroempv
GROUP BY A.nroemp, A.nombres;

select *
from empleados
where cargo = (
select cargo
from empleados
where nroemp = 12)
and
salario >(
select salario
from empleados
where nroemp = 17);

--practica

select A.nroemp,A.nombres,min(P.fecha)as fecha_1ra_Venta
from empleados A 
inner join pedidos P on A.nroemp = P.nroEmpv
group by A.nroemp,A.nombres;


--SUBCONSULTAS EN EL FROM
--Este ejemplo muestra los nombres, salarios, num departamento y media de salarios, 
--de todos los empleados que cobran m s que la media de salarios de su departamento.
SELECT A.nombres, A.salario, A.nrodpto, A.salario, B.SalarioPromDpto 
FROM empleados A, (SELECT B.nrodpto, AVG(salario) AS SalarioPromDpto FROM empleados B GROUP BY B.nrodpto) B
WHERE (A.salario > B.SalarioPromDpto) AND (A.nrodpto=B.nrodpto);

-- 

--SUBCONSULTAS EN EL INSERT
--Inserta un registro a la tabla TIPOS_TITULO con los valores: titulo_cd (cuyo titulo se obtendr  del idTitulo 108 de la tabla INVENTARIO_TITULOS) y tipocd 'Popular'  
INSERT INTO TIPOS_TITULO VALUES( 
 (SELECT TITULO FROM INVENTARIO_TITULOS WHERE ID_TITULO = 108 ),'Popular' 
);

--SUBCONSULTAS EN EL UPDATE
--Subconsulta en la clasula WHERE
--Se quiere actualizar el valor Both Sides Now que fue insertado en el ejemplo anterior de instrucci n INSERT.
UPDATE TIPOS_TITULO SET CD_TYPE = 'Folk' WHERE TITULO_CD IN (
  SELECT TITULO
  FROM INVENTARIO_TITULOS
  WHERE TITLE_ID = 108 
);

--Subconsulta en la clausula SET 
--Se quiere actualizar una vez m s actualizar el valor Both Sides Now que fue insertado en el ejemplo anterior de instrucci n INSERT
UPDATE TIPOS_TITULO SET TITULO_CD = ( 
  SELECT TITULO
  FROM INVENTARIO_TITULOS
  WHERE ID_TITULO = 108)
WHERE TITULO_CD = 'Both Sides Now';

--SUBCONSULTA CON DELETE
--Se quiere borrar el valor Both Sides Now que se modific  en el ejemplo anterior de instrucci n UPDATE. 
--Para determinar cu l fila debe eliminarse, se utiliza una subconsulta para arrojar el valor apropiado 
--TITULO de la tabla INVENTARIO_TITULOS.
DELETE FROM TIPOS_TITULO WHERE TITULO_CD IN (
  SELECT TITLE
  FROM INVENTARIO_TITULOS
  WHERE TITLE_ID = 108
);