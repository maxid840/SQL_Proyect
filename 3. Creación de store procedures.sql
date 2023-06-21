-- Procedimiento Almacenado que permite automatizar el ingreso de datos en la tabla personal
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insertar_personal`(
    IN id_area INT,
    IN nombre text,
    IN apellido text,
    IN dni VARCHAR(255),
    IN fecha_nacimiento DATE,
    IN fecha_ingreso DATE,
    IN direccion VARCHAR(255),
    IN localidad VARCHAR(255),
    IN provincia VARCHAR(255),
    IN pais VARCHAR(255),
    IN email VARCHAR(255)
)
BEGIN
    -- controlo que el id sea entre 1 y 5
    IF id_area BETWEEN 1 AND 5 THEN
        -- procedo a ingresar
        INSERT INTO Personal (Id_Area, Nombre, Apellido, DNI, Fecha_Nacimiento, Fecha_Ingreso, Direccion, Localidad, Provincia, Pais, Email)
        VALUES (id_area, nombre, apellido, dni, fecha_nacimiento, fecha_ingreso, direccion, localidad, provincia, pais, email);
    ELSE
        -- si se ingresa mal mostrar mensaje de error
        SELECT 'El valor de id_area debe estar entre 1 y 5';
    END IF;
END$$
DELIMITER ;

-- Procecimiento Almacenado que ordena la tabla segun tres parametros que voy a pasar
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ordenamiento`(
    -- parametros que ingreso 
    IN nombre_tabla VARCHAR(50), -- > nombre de la tabla que voy a reordenar
    IN columna_ordenar VARCHAR(50), -- > columna que elijo para ordenar 
    IN tipo_orden VARCHAR(4) -- > tipo de orden  asc o desc
)
BEGIN
    -- concanteno lo que obtuve para crear el Order by 
    SET @accion = CONCAT('SELECT * FROM ',nombre_tabla, ' ORDER BY ', columna_ordenar, ' ', tipo_orden);
    PREPARE stmt FROM @accion;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;
