-- En la primera tabla, si tiene registros, deberás eliminar algunos de ellos iniciando previamente una transacción. 
-- Si no tiene registros la tabla, reemplaza eliminación por inserción.
-- Deja en una línea siguiente, comentado la sentencia Rollback, y en una línea posterior, la sentencia Commit.
-- Si eliminas registros importantes, deja comenzado las sentencias para re-insertarlos.
Start Transaction;
-- que contiene (datos)
describe areas;
-- leo que tiene la tabla
select*from areas;
-- verifico si tiene algun registro
select count(*)from areas;
-- ELIMINO EL AREA 6
delete from areas
where id_area=6;
-- INSERTO DATOS
insert into areas(descripcion) values ('Programador Junior');
insert into areas(descripcion) values ('Programador Semi-Senior');
insert into areas(descripcion) values ('Programador Senior');
insert into areas(descripcion) values ('Data Analitics');
insert into areas(descripcion) values ('Data Science');
insert into areas(descripcion) values ('Data Enginier');
-- VERIFICO LA INSERCION DE DATOS  SI FUE EXITOSA
SELECT*FROM AREAS;
-- VUELVO PARA ATRAS LA INSERCION
ROLLBACK;
-- CONFIRMO LA TRANSACCION
COMMIT;

-- ***************************************************************************************** --

-- En la segunda tabla, inserta ocho nuevos registros iniciando también una transacción. 
-- Agrega un savepoint a posteriori de la inserción del registro #4 y otro savepoint a posteriori del registro #8
-- Agrega en una línea comentada la sentencia de eliminación del savepoint de los primeros 4 registros insertados.
START TRANSACTION; -- Iniciar transacción
select*from compras;
select count(*)from compras;
-- Insertar ocho nuevos registros en la segunda tabla

INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,12,'2021-08-12',5,2,15458);
INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,11,'2021-08-12',5,2,15458);
INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,10,'2021-08-12',5,2,15458);
INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,09,'2021-08-12',5,2,15458);
-- agrego sp luego de insercion 4
SAVEPOINT sp1;


INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,08,'2021-08-12',5,2,15458);
INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,07,'2021-08-12',5,2,15458);
INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,06,'2021-08-12',5,2,15458);
INSERT INTO compras (id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta) 
	  VALUES (1,05,'2021-08-12',5,2,15458);
-- Agregar un savepoint después de la inserción del registro #8
SAVEPOINT sp2;

select count(*)from compras;

-- Agregar en una línea comentada la sentencia de eliminación del savepoint de los primeros 4 registros insertados.
ROLLBACK TO sp1;

-- Confirmar los cambios
COMMIT;