Use comercio_polirubro;
DROP USER 'usuario1'@'localhost';
DROP USER 'usuario2'@'localhost';
-- Creo el primer usuario con permiso de lectura  (usuario1)
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'usuario1';

-- creo el usuario que puede leer, insertar y modificar (usuario2)
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'usuario2';

-- verifico que los dos usuarios fueron creados correctamente
SELECT user FROM mysql.user WHERE user = 'usuario1';
SELECT user FROM mysql.user WHERE user = 'usuario2';

-- otorgo permiso al usuario1 que se solo de lectura (select)
GRANT SELECT ON *.* TO 'usuario1'@'localhost';

-- otorgo los permiso de lectura, insercion y modificacion (select, insert, update)
GRANT SELECT, INSERT, UPDATE ON *.* TO 'usuario2'@'localhost';

-- verifico que los permisos sean tal cual los cree
 SHOW GRANTS FOR 'usuario1'@'localhost';
 SHOW GRANTS FOR 'usuario2'@'localhost';
 
 -- le aclaro que no otorge permisos de eliminado ( me aseguro que no lo tenga)
 REVOKE DELETE ON *.* FROM 'usuario1'@'localhost';
 REVOKE DELETE ON *.* FROM 'usuario2'@'localhost';

-- vuelvo a verificar los permisos, al no estar delete, no tiene el permiso
 SHOW GRANTS FOR 'usuario1'@'localhost';
 SHOW GRANTS FOR 'usuario2'@'localhost';
 
 -- *************************************************************************** --
 
-- Verficacion de usuario 1 Sobre la Tabla Proyecto Final
-- Condicion del Usuario 1:
-- Uno de los usuarios creados deberá tener permisos de sólo lectura sobre todas las tablas(ergo no tiene que funcionar insercion ni update, ni delete).

-- el permiso de lectura funciona perfecto
use proyecto_final;
select*from areas;
select*from compras;

--  valido que no funcione insercion   (validado)

Insert into areas(descripcion) values('Contador');
insert into compras(id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta)
	   values(1,2,'2021-08-11',6,2,12714);

-- -- valido que no funcione udpate  (validado)
-- prueba de actualizacion de id_area=1 de Administrativo a Administrativo Junior

Update areas set descripcion='Admistrativo Junior'
where id_area=1;

-- prueba de cambiar un nombre de un vendedor cuando el id=1
update vendedores set nombre='Pablo', apellido='Alessandrini'
where id_vendedor=1;


-- valido que no funcione delete (validado)
-- eliminar desde la tabla areas, cuando la descripcion sea Administrativo
Delete from areas 
Where descripcion='Admistrativo';

-- eliminar desde la tabla vendedores cuando la descripcion sea Maria
Delete from vendedores
where nombre='Maria';

 -- *************************************************************************** --
 
 -- Verficacion de usuario 2 Sobre la Tabla Proyecto Final
-- Condicion Usuario 2
-- Permisos de Lectura, Inserción y Modificación de datos.

use proyecto_final;
-- verifico la lectura (select)
select*from areas;
select*from compras;

--  valido que funcione insercion   (validado)

Insert into areas(descripcion) values('Contador');
insert into compras(id_producto, id_cliente, fecha_venta, id_forma_de_pago, forma_compra, monto_venta)
	   values(1,2,'2021-08-11',6,2,12714);
 
-- Verifico la carga correcta (insercion) (validacion ok)
select*from areas
Where descripcion='Contador';

-- verifico la carga de  la tabla compras (venta 1001)
select*from compras
where id_producto=1 and id_cliente=2 and fecha_venta='2021-08-11' and id_forma_de_pago=6 and forma_compra=2 and monto_venta=12714;

-- verifico que funcione la modificacion de datos

Update areas set descripcion='Admistrativo Junior'
where id_area=1;

-- verifico cambio
select*from areas
where descripcion='Admistrativo Junior';

-- prueba de cambiar un nombre de un vendedor cuando el id=1
update vendedores set nombre='Pablo', apellido='Alessandrini'
where id_vendedor=1;
-- verifico cmabio de vendedor
select*from vendedores
where id_vendedor=1;

-- valido que no funcione delete (validado)
-- eliminar desde la tabla areas, cuando la descripcion sea Administrativo Junior
Delete from areas 
Where descripcion='Admistrativo Junior';

-- eliminar desde la tabla vendedores cuando la descripcion sea Pablo
Delete from vendedores
where nombre='Pablo';
 