create database pollos_copacabana;

use pollos_copacabana;

create table cliente(
    id_cliente int auto_increment primary key not null ,
    fullname varchar (50) not null ,
    lastname varchar (50) not null ,
    edad int not null ,
    domicilio varchar (50) not null
);
insert into cliente(fullname, lastname, edad, domicilio)
values ('fernando','flores',25,'villa adela'),('luis','ramires',30,'senkata');


create table pedido (
    id_pedido int auto_increment primary key not null ,
    articulo varchar (50) not null ,
    costo int not null ,
    fecha int not null
);
insert into  pedido(articulo, costo, fecha)
values ('combo de pollos',250,24/05/23),('alitas',50,30/05/23);


create table detalle_pedido (
    id_detalle_pedido int auto_increment primary key not null ,
    id_cliente int not null ,
    id_pedido int not null,
    foreign key (id_cliente) references cliente (id_cliente) on delete cascade ,
    foreign key (id_pedido) references  pedido (id_pedido) on delete cascade
);
insert into detalle_pedido (id_detalle_pedido, id_cliente, id_pedido)
values (1,1,1),(2,2,2);

select cl.fullname,dp.id_cliente,dp.id_detalle_pedido,p.articulo,p.costo
    from cliente as cl
inner join detalle_pedido dp on cl.id_cliente = dp.id_cliente
inner join pedido p on dp.id_pedido = p.id_pedido
where p.articulo = 'combo de pollos' ;