-- CREACION DE VISTAS 
    
-- Vista que me muestra la cantidad de compras hechas en base a la forma(web/presencial)
CREATE VIEW vw_cant_compras_forma as
	SELECT  fc.descripcion, 
			count(id_producto) as cantidad_compras
	FROM compras as co
	INNER JOIN forma_compra as fc
	ON co.forma_compra=fc.id_forma_compra
	GROUP BY fc.descripcion
;

-- Vista que me muestre las cantidad de ventas hechas por producto(NOMBRE)
CREATE VIEW vw_ventas_por_producto as
	SELECT p.descripcion as Producto, sum(co.monto_venta) as total_ventas
	FROM compras as co
	INNER JOIN productos as p
	ON co.id_producto=p.id_productos
	GROUP BY p.descripcion
;

-- Vista que saca la cantidad de clientes a cargo que tiene cada vendedor, para luego sacar un promedio de cuanto tienen cada uno, y al final mostrar los que estan por debajo.
CREATE VIEW vw_vendedores_bajos as 
	SELECT Concat(v.nombre,'',v.apellido) as Vendedor,
		   count(c.id_cliente) as cantidad_clientes_a_cargo
	FROM vendedores as v
	INNER JOIN clientes as c
	ON v.id_vendedor=c.id_vendedor
	GROUP BY Concat(v.nombre,'',v.apellido)
	HAVING count(c.id_cliente) <
			(
				SELECT Truncate(avg(cantidad_clientes),0) as promedio_CxV 
				FROM
				(
				 SELECT concat(v.nombre,' ',v.apellido) as nombre_vendedor,
					   count(c.id_cliente) cantidad_clientes
				 FROM vendedores as v
				 INNER JOIN clientes as c
				 ON v.id_vendedor=c.id_vendedor
				 GROUP BY concat(v.nombre,' ',v.apellido)
				 ) as SUBCONSULTA
			)
;
              
-- Vista que cuenta la cantidad de personas por area que hay para luego mostrarla con su descripcion, y ver el porcentaje sobre el total
CREATE VIEW vw_personas_por_areas as
	SELECT p.id_area,
		   a.descripcion as Area_empresa,
		   COUNT(*) as cantidad_personas,
		   ROUND(COUNT(*) / (SELECT COUNT(*) FROM personal) * 100, 1) as porcentaje
	FROM personal as p
	INNER JOIN areas as a
	ON p.id_area=a.id_area
	GROUP BY p.id_area
	ORDER BY p.id_area DESC
;
    
-- Vista que muestra los  5 mejores clientes que mas dinero mueven en las compras
CREATE VIEW vw_5_mejores_clientes as
	SELECT cl.nombre as Cliente,
		   sum(co.monto_venta) as total_dinero
	FROM clientes as cl
	INNER JOIN compras as co
	ON cl.id_cliente=co.id_cliente
	GROUP BY cl.nombre
	ORDER BY sum(co.monto_venta) DESC
	Limit 5
;