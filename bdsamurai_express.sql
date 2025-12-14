select name
from sys.databases;
go

use master;
go

select name
from sys.tables;
go

create database bdsamurai;
go

use bdsamurai;
go

create table clientes (
 id int identity(1,1) primary key,
 nombre Nvarchar(30) not null,
 apellidos Nvarchar(30) not null,
 dni nvarchar(30) not null,
 telefono nvarchar(30));
 go

 -- creacion de las tablas en bdsamurai

 create table categorias(
 id int identity(1,1) primary key,
 nombre nvarchar(30) not null,
 descripcion nvarchar(200));
 go
 create table productos (
 id int identity(1,1) primary key,
 codigo nvarchar(30) not null,
 nombreProducto nvarchar(30) not null,
 idcategoria int not null,
 constraint fkproductos_categorias
 foreign key(idcategoria)
 references categorias(id));
 go

 select name
 from sys.tables;
 go	

  create table inventarios (
 id int identity(1,1) primary key,
 cantidad int not null,
 precio int not null,
 idproducto int not null,
 constraint fkinventarios_productos
 foreign key(idproducto)
 references productos(id));
 go

 create table pedidos(
 id int identity(1,1) primary key,
 fecha date default CAST(getdate() as date),
 idcliente int not null,
 total decimal(10,2),
 constraint fkpedidos_clientes
 foreign key (idcliente)
 references clientes (id));
 go

 create table detallepedidos (
 id int identity(1,1) primary key,
 idpedido int not null,
 idproducto int not null,
 cantidad int not null,
 precio decimal(10,2) not null,
 constraint fkdtpedidos_pedidos
 foreign key (idpedido)
 references pedidos(id),
 constraint fkdtpedidos_productos
 foreign key (idproducto)
 references productos(id));
 go

 insert into clientes(nombre,apellidos,dni,telefono) values ('mario','guarnizo','16258234','3182584725');
 go

 select * from clientes;
 go


 sp_help pedidos;
 go

 insert into categorias(nombre,descripcion) values ('electronica','componentes  estudiantes');
 go

 insert into productos(codigo,nombreproducto,idcategoria)values('ard001','arduino uno R3',1);
 go

 select * from productos
 INNER JOIN categorias on productos.idcategoria = CATEGORIAS.id; 
 go


 -- insercion de datos en  la tabla inventarios


 insert into inventarios(cantidad,precio,idproducto) values (70,28000,1);

 select p.nombreProducto, i.cantidad,i.precio from inventarios i
 inner join productos p on i.idproducto = p.id;


 truncate table inventarios;


 --insercion de datos en la tabla pedidos


 insert into pedidos(idcliente,total) values (1,20);

 sp_help detallepedidos;

 insert into detallepedidos(idpedido,idproducto,cantidad,precio) values(1,1,20,28000);

 select * from detallepedidos;

 update pedidos
 set total = 560000
 where id = 1;

 select * from pedidos;