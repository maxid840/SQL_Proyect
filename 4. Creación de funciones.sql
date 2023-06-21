-- fUNCION QUE INGRESANDO EL NUMERO DE COMPRA ME DICE QUE CLIENTE LA HIZO
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `cliente_por_nro_compra`(nro_compra int) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE cliente_nombre VARCHAR(50);
	SELECT c.nombre INTO cliente_nombre 
	FROM clientes as c 
	INNER JOIN compras as co
    ON co.id_cliente = c.id_cliente 
	WHERE co.id_venta= nro_compra;
	RETURN cliente_nombre;
END$$
DELIMITER ;

-- Funcion que calcula el monto total (suma de todas las compras) que hizo  un cliente (iNGRESANDO EL NUMERO DE CLIENTE )
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_total_compras`(cliente INT) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE monto_total FLOAT;
    SELECT SUM(monto_venta) INTO monto_total FROM compras WHERE id_cliente = cliente;
    RETURN monto_total;
END$$
DELIMITER ;

