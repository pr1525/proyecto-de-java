

CREATE DATABASE IF NOT EXISTS cafeteria;
USE cafeteria;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;


CREATE TABLE productos (
  id int NOT NULL AUTO_INCREMENT,
  nombre varchar(45) NOT NULL,
  precio int NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO productos VALUES (1,'Tinto',2000),(2,'Cafe con leche',3500),(3,'Capuchino',5000),(4,'Jugo natural',4500),(5,'Empanada',3000),(6,'Sandwich',8000);

CREATE TABLE ventas (
  id int NOT NULL AUTO_INCREMENT,
  producto int NOT NULL,
  cantidad int NOT NULL,
  precio int NOT NULL,
  total int NOT NULL,
  fecha datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  cajero varchar(45) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_ventas_producto_idx (producto),
  CONSTRAINT fk_ventas_producto FOREIGN KEY (producto) REFERENCES productos (id)
);


INSERT INTO ventas (producto, cantidad, precio, total, cajero) VALUES (1,3,2000,6000,'CAJERO'),(5,5,3000,15000,'CAJERO'),(1,1,2000,2000,'CAJERO');



DROP PROCEDURE IF EXISTS mostrarProductos;
DROP PROCEDURE IF EXISTS guardarVenta;
DROP PROCEDURE IF EXISTS mostrarVentas;
DROP PROCEDURE IF EXISTS ventasPeriodo;
DROP PROCEDURE IF EXISTS masVendidos;
DROP PROCEDURE IF EXISTS ingresosProducto;

DELIMITER ;;
CREATE PROCEDURE mostrarProductos()
BEGIN
	select id, nombre, precio from productos order by id;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE guardarVenta(prod int, cant int, prec int, caj varchar(45))
BEGIN
	insert into ventas(producto, cantidad, precio, total, cajero) values (prod, cant, prec, cant * prec, caj);
END ;;
DELIMITER ;

-- Informe de ventas
DELIMITER ;;
CREATE PROCEDURE mostrarVentas()
BEGIN
	select p.nombre as 'Producto', v.cantidad as 'Cantidad', v.precio as 'Precio', v.total as 'Total', date_format(v.fecha, '%d/%m/%Y %H:%i:%s') as 'Fecha', v.cajero as 'Cajero' from ventas v inner join productos p on v.producto = p.id
    order by v.id;
END ;;
DELIMITER ;


DELIMITER ;;
CREATE PROCEDURE ventasPeriodo(desde varchar(10), hasta varchar(10))
BEGIN
	select p.nombre as 'Producto', v.cantidad as 'Cantidad', v.precio as 'Precio', v.total as 'Total', date_format(v.fecha, '%d/%m/%Y %H:%i:%s') as 'Fecha', v.cajero as 'Cajero' from ventas v inner join productos p on v.producto = p.id
    where date(v.fecha) between str_to_date(desde, '%d/%m/%Y') and str_to_date(hasta, '%d/%m/%Y')
    order by v.id;
END ;;
DELIMITER ;


DELIMITER ;;
CREATE PROCEDURE masVendidos()
BEGIN
	select p.nombre as 'Producto', sum(v.cantidad) as 'Unidades vendidas' from ventas v inner join productos p on v.producto = p.id
    group by p.id, p.nombre
    order by sum(v.cantidad) desc;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE ingresosProducto()
BEGIN
	select p.nombre as 'Producto', sum(v.total) as 'Ingresos' from ventas v inner join productos p on v.producto = p.id
    group by p.id, p.nombre
    order by sum(v.total) desc;
END ;;
DELIMITER ;
