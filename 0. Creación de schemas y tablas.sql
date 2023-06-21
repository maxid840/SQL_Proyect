-- Creo el schema
CREATE SCHEMA Comercio_Polirubro;

-- Realizo la conexion al schema 
 use Comercio_Polirubro;
   
-- Realizo la creación de tablas    
CREATE TABLE Medios_de_Pago(
	id_formas_de_pago		int not null auto_increment primary key,
	descripción 			varchar(255)
);
    
CREATE TABLE forma_compra (
	id_forma_compra			int not null auto_increment primary key,
	descripcion 			varchar (100)
);

CREATE TABLE productos (
	id_productos 			int not null auto_increment primary key,
	descripcion 			varchar (100)
);

CREATE TABLE areas (
	id_area 				int not null auto_increment primary key,
	descripcion 			varchar (255)
);

CREATE TABLE Personal(
    id_personal 			int not null auto_increment primary key,
    id_area 				int not null ,
    nombre text,
    apellido text,
    dni varchar(255),
    fecha_nacimiento date,
    fecha_ingreso date,
    direccion varchar(255),
    localidad varchar(255),
    provincia varchar(255),
    pais varchar(255),
    email varchar(255)
); 

CREATE TABLE Vendedores(
	id_vendedor 			int not null auto_increment primary key,
	id_personal 			int not null,
	nombre 					text,
	apellido 				text,
	FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

CREATE TABLE Clientes(
	id_cliente 				int not null auto_increment primary key,
	fecha_alta 				date,
	nombre 					varchar(255),
	direccion 				text,
	id_vendedor 			int not null,
	localidad 				varchar(255),
	provincia 				varchar(255),
	país 					varchar(255),
	telefono 				varchar(255), 
	mail 					varchar(255),
	contacto_personal 		varchar(255),
	usuario_web 			varchar(255),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id_vendedor)
);
    
CREATE TABLE compras(
		id_venta 			int not null auto_increment primary key,
		id_producto			int not null, 
		id_cliente  		int not null,
        fecha_venta 		date,
		id_forma_de_pago 	int not null,
		forma_compra 		int not null,
		monto_venta 		float,
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
        FOREIGN KEY (id_producto) references productos (id_productos),
        FOREIGN KEY (id_forma_de_pago) REFERENCES Medios_de_Pago(id_formas_de_pago),
        FOREIGN KEY (forma_compra ) REFERENCES forma_compra(id_forma_compra)
);
