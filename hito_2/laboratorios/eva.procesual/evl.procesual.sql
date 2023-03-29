create database defensa_hito_2;
use defensa_hito_2;

CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);

CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);


INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);


INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');

create view usuarios as
select u.id_user,u.fullname,b.editorial
from book as b
inner join category c on b.id_book = c.id_book
inner join users u on b.id_book = u.id_user
inner join autor a on b.id_autor = a.id_autor
where u.fullname  and u.id_user and b.editorial ;

CREATE OR REPLACE VIEW Mostrar_categoria as
SELECT us.ci as CI_USER,
    CONCAT(us.fullname,' ',us.lastname) as NOMBRE_COMPLETO,
    bo.title as LIBRO_PRESTADO,
    cat.type as CATEGORIA
FROM users as us
INNER JOIN prestamos as pres on us.id_user = pres.id_prestamo
INNER JOIN category as cat on pres.id_prestamo = cat.id_cat
INNER JOIN book as bo on cat.id_cat = bo.id_book
WHERE cat.type = 'COMEDIA' or cat.type = 'MANGA';

SELECT * FROM Mostrar_categoria;
 CREATE VIEW vista AS
SELECT e.ci AS CI_USER,
       CONCAT(e.fullname,' ',e.lastname) AS NOMBRE_COMPLETO,
       b.title AS LIBRO_PRESTADO,
       c.type AS CATEGORIA
FROM users as e
    INNER JOIN prestamos p on e.id_user = p.id_user
    INNER JOIN category c on p.id_book = c.id_book
    INNER JOIN book b on c.id_book = b.id_book
WHERE c.type = 'COMEDIA' OR c.type = 'MANGA';

select description(bo.editorial, cat.type) as DESCRIPTION, NUMERO(bo.pages) as PAGES
    from users as us
inner join prestamos as pres on pres.id_user = us.id_user
inner join book as bo on bo.id_book = pres.id_book
inner join category as cat on cat.id_book = bo.id_book
where bo.editorial = 'IBRANI' and cat.type = 'MANGA' ;

CREATE FUNCTION description(editorial varchar(50), categoria varchar(50))
    returns varchar(100)
    begin
        declare resp varchar(100);

        set resp = concat('Editorial: ', editorial, ', Categoria: ', categoria);

        return resp;
    end;




create or replace function NUMERO(page integer)
returns varchar(100)
begin
    declare respuesta varchar(30);

    if page %2 = 0 then
        set respuesta = concat('Par: ', page);…
 create or replace function FECHA()
    returns integer
begin
    declare resp integer ;
    select count(boo.id_book) into resp
    from book as boo inner join prestamos as p on boo.id_book = p.id_book
    where year(p.fec_prestamo)=2017 or year(p.fec_prestamo)=2018;
    return resp;
end;


select FECHA() as Fecha
#
# select b.editorial
# from book as b
# INNER JOIN book b2 on b.id_book = b2.id_book
# where b.editorial = 'IBRANI' ;
#
# # create function usersIBRANIand90(editorialbook varchar(50),pagesbook int(1))
# # returns varchar (50)
# # begin
# #     declare resultado varchar (50);
# #     SET resultado = concat('(', editorialbook, '), (', 90, ')');
# #     return resultado;
# # end;
# #
# # select usersIBRANIand90();
#
# select C.type,B.editorial
# from book as b
# inner join category c on b.id_book = c.id_book
# inner join prestamos p on b.id_book = p.id_book
# inner join users u on p.id_user = u.id_user
# where c.type ='MANGA' and b.editorial = 'IBRANI';
#
#
#
# drop function concatenar;
# create function concatenar()
# returns varchar (100)
# begin
#     declare respuesta varchar(100);
#     set respuesta = (select concat('editorial: ', b.editorial,' categoriba: ',c.type) as descripcion
#     from book as b
# inner join category c on b.id_book = c.id_book
# inner join prestamos p on b.id_book = p.id_book
# inner join users u on p.id_user = u.id_user
# where c.type ='MANGA' and b.editorial = 'IBRANI');
#     return  respuesta;
#
# end;
#
# select concatenar();
#
# select YEAR(fec_prestamo) AS FECHA,
#  if(year(ps.fec_prestamo) = '2017','2018') as fecha_prest
# from prestamos as ps
# where PS.fec_prestamo = '2017' and '2018';
#
# create function usuariogestion_2017_2018(prestamo varchar(50))
# returns varchar (50)
# begin
#     declare respuesta varchar (50);
#     select YEAR(ps.fec_prestamo) AS FECHA,
#            if(year(ps.fec_prestamo) = '2017','2018') as fecha_prest
# from prestamos as ps
# where PS.fec_prestamo = '2017-10-20' AND PS.fec_prestamo = '2018-12-20';
#         return  respuesta;
#
# end;







