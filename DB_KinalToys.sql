-- Drop database if exists DB_KinalToys;
create database DB_KinalToys;
use DB_KinalToys;

create table Clientes (
	codigoCliente int auto_increment,
	nombreCliente varchar(50) not null,
	apellidoCliente varchar(60) not null,
	direccionCliente varchar(100),
	telefonoCliente varchar(9),
    dpiCliente varchar(15) not null unique,
	primary key PK_codigoCliente (codigoCliente)
);

create table Empleados (
	codigoEmpleado int auto_increment,
	nombreEmpleado varchar(50) not null,
	apellidoEmpleado varchar(60) not null,
	direccionEmpleado varchar(100),
	telefonoEmpleado varchar(9),
	cargo varchar(50),
	salario decimal(10,2),
	dpiEmpleado varchar(15) not null unique,
		primary key PK_codigoEmpleado (codigoEmpleado)
);

create table Cuentas (
	codigoCuenta int auto_increment,
	rol enum('Cliente', 'Empleado') not null default 'Cliente',
	nombreCuenta varchar(50) not null,
	correoCuenta varchar(100) not null unique,
	contrasenaCuenta varchar(255) not null,
	fotoperfil varchar(255) null,
	codigoCliente int null,
	codigoEmpleado int null,
	primary key PK_codigoCuenta (codigoCuenta),
	constraint FK_Cuenta_Cliente foreign key (codigoCliente)
		references Clientes (codigoCliente),
	constraint FK_Cuenta_Empleado foreign key (codigoEmpleado)
		references Empleados (codigoEmpleado),
	constraint CHK_UnicaRelacion CHECK (
        (codigoCliente IS NOT NULL AND codigoEmpleado IS NULL) OR
        (codigoCliente IS NULL AND codigoEmpleado IS NOT NULL)
    )
);

create table Facturas (
	codigoFactura int auto_increment,
	fechaEmision datetime,
	metodoPago enum('Efectivo', 'Credito'),
	total decimal(10,2),
	codigoCliente int,
	primary key PK_codigoFactura (codigoFactura),
	constraint FK_Factura_Cliente foreign key (codigoCliente)
		references Clientes (codigoCliente)
);

create table Noticias (
	codigoNoticia int auto_increment,
	encabezado varchar(100),
	informacion varchar(250),
	categoria varchar(50),
	fechaNoticia datetime,
	primary key PK_codigoNoticia (codigoNoticia)
);

create table Proveedores (
	codigoProveedor int auto_increment,
	nombreProveedor varchar(50),
	telefonoProveedor varchar(9),
	correoProveedor varchar(100),
	direccionProveedor varchar(125),
	primary key PK_codigoProveedor (codigoProveedor)
);

create table Juguetes (
	codigoJuguete int auto_increment,
	nombreJuguete varchar(50),
	precio decimal(10,2),
	categoria varchar(50),
	marca varchar(50),
	stock int,
	codigoNoticia int,
	primary key PK_codigoJuguete (codigoJuguete),
	constraint FK_Juguete_Noticia foreign key (codigoNoticia)
		references Noticias (codigoNoticia)
);

create table Carritos (
	codigoCarrito int auto_increment,
	fechaCreacion datetime,
	estado enum('Activo', 'Comprado'),
	total decimal(10,2),
	codigoCliente int,
	primary key PK_codigoCarrito (codigoCarrito),
	constraint FK_Carrito_Cliente foreign key (codigoCliente) 
		references Clientes (codigoCliente)
);

create table DetallesCarritos (
	codigoDetalleC int auto_increment,
	cantidad int,
	subTotal decimal(10,2),
	descuentoAplicado decimal(10,2),
	codigoCarrito int,
	codigoJuguete int,
	primary key PK_codigoDetalleC (codigoDetalleC),
	constraint FK_DetalleC_Carrito foreign key (codigoCarrito) 
		references Carritos (codigoCarrito),
	constraint FK_DetalleC_Juguete foreign key (codigoJuguete) 
		references Juguetes (codigoJuguete)
);


-- PROCEDIMIENTOS ALMACENADOS (CLIENTES) -------------------------
-- AGREGAR CLIENTE
Delimiter $
create procedure sp_AgregarClientes (
    in nombre varchar(50),
    in apellido varchar(60),
    in direccion varchar(100),
    in telefono varchar(9),
    in dpi varchar(15))
begin
    insert into Clientes (nombreCliente, apellidoCliente, direccionCliente, telefonoCliente, dpiCliente)
    values (nombre, apellido, direccion, telefono, dpi);
end$
Delimiter ;
call sp_AgregarClientes('Carlos', 'Mejía', 'Zona 10, Guatemala', '45981230', '1234567890123');
call sp_AgregarClientes('Andrea', 'Gómez', 'Zona 5, Guatemala', '55678921', '9876543210987');

-- LISTAR CLIENTES
Delimiter $$
create procedure sp_ListarClientes ()
begin
    select c.codigoCliente, c.nombreCliente, c.apellidoCliente, c.direccionCliente, c.telefonoCliente, c.dpiCliente 
    from Clientes c;
end$$
Delimiter ;
call sp_ListarClientes();

-- ELIMINAR CLIENTE
Delimiter $$
create procedure sp_EliminarCliente (
    in codCliente int)
begin
    delete from Clientes c where c.codigoCliente = codCliente;
end$$
Delimiter ;
call sp_EliminarCliente(2);

-- BUSCAR CLIENTE
Delimiter $$
create procedure sp_BuscarCliente (
    in codCliente int)
begin
    select c.codigoCliente, c.nombreCliente, c.apellidoCliente, c.direccionCliente, c.telefonoCliente, c.dpiCliente 
    from Clientes c 
    where c.codigoCliente = codCliente;
end$$
Delimiter ;
call sp_BuscarCliente(1);

-- EDITAR CLIENTE
Delimiter $
create procedure sp_EditarCliente (
    in codCliente int,
    in nombre varchar(50),
    in apellido varchar(60),
    in direccion varchar(100),
    in telefono varchar(9),
    in dpi varchar(15))
begin
    update Clientes c
    set c.nombreCliente = nombre, 
        c.apellidoCliente = apellido,
        c.direccionCliente = direccion, 
        c.telefonoCliente = telefono,
        c.dpiCliente = dpi
    where c.codigoCliente = codCliente;
end$
Delimiter ;
call sp_EditarCliente(1, 'Carlos', 'Mejía', 'Zona 14, Guatemala', '12345678', '1111111111111');

-- PROCEDIMIENTOS ALMACENADOS (EMPLEADOS) -------------------------
-- AGREGAR EMPLEADO
Delimiter $
create procedure sp_AgregarEmpleados (
    in nombre varchar(50),
    in apellido varchar(60),
    in direccion varchar(100),
    in telefono varchar(9),
    in cargo varchar(50),
    in salario decimal(10,2),
    in dpi varchar(15))
begin
    insert into Empleados (nombreEmpleado, apellidoEmpleado, direccionEmpleado, telefonoEmpleado, cargo, salario, dpiEmpleado)
    values (nombre, apellido, direccion, telefono, cargo, salario, dpi);
end$
Delimiter ;


-- LISTAR EMPLEADOS
Delimiter $$
create procedure sp_ListarEmpleados ()
begin
    select e.codigoEmpleado, 
    e.nombreEmpleado, 
    e.apellidoEmpleado,
    e.direccionEmpleado,
    e.telefonoEmpleado, 
    e.cargo, e.salario, 
    e.dpiEmpleado 
    from Empleados e;
end$$
Delimiter ;
call sp_ListarEmpleados();

-- ELIMINAR EMPLEADO
Delimiter $$
create procedure sp_EliminarEmpleado (
    in codEmpleado int)
begin
    delete from Empleados e where e.codigoEmpleado = codEmpleado;
end$$
Delimiter ;
call sp_EliminarEmpleado(2);

-- BUSCAR EMPLEADO
Delimiter $$
create procedure sp_BuscarEmpleado (
    in codEmpleado int)
begin
    select e.codigoEmpleado, e.nombreEmpleado, e.apellidoEmpleado, e.direccionEmpleado, e.telefonoEmpleado, e.cargo, e.salario, e.dpiEmpleado from Empleados e where e.codigoEmpleado = codEmpleado;
end$$
Delimiter ;
call sp_BuscarEmpleado(1);

-- EDITAR EMPLEADO
Delimiter $$
create procedure sp_EditarEmpleado (
    in codEmpleado int,
    in nombre varchar(50),
    in apellido varchar(60),
    in direccion varchar(100),
    in telefono varchar(9),
    in cargo varchar(50),
    in salario decimal(10,2))
begin
    update Empleados e
    set e.nombreEmpleado = nombre, 
        e.apellidoEmpleado = apellido,
        e.direccionEmpleado = direccion, 
        e.telefonoEmpleado = telefono,
        e.cargo = cargo,
        e.salario = salario
    where e.codigoEmpleado = codEmpleado;
end$$
Delimiter ;
-- PROCEDIMIENTOS ALMACENADOS (FACTURAS) -------------------------
-- AGREGAR FACTURA
Delimiter $$
create procedure sp_AgregarFactura (
    in fecha datetime,
    in metodo enum('Efectivo', 'Credito'),
    in totalFactura decimal(10,2),
    in codCliente int)
begin
    insert into Facturas (fechaEmision, metodoPago, total, codigoCliente)
    values (fecha, metodo, totalFactura, codCliente);
end$$
Delimiter ;
call sp_AgregarFactura('2023-06-15 11:30:00', 'Efectivo', 250.75, 1);
call sp_AgregarFactura('2023-06-16 09:15:00', 'Credito', 450.00, 1);

-- LISTAR FACTURAS
Delimiter $$
create procedure sp_ListarFacturas ()
begin
    select f.codigoFactura, f.fechaEmision, f.metodoPago, f.total, f.codigoCliente 
    from Facturas f;
end$$
Delimiter ;
call sp_ListarFacturas();

-- ELIMINAR FACTURA
Delimiter $$
create procedure sp_EliminarFactura (
    in codFactura int)
begin
    delete from Facturas f 
    where f.codigoFactura = codFactura;
end$$
Delimiter ;
call sp_EliminarFactura(2);

-- BUSCAR FACTURA
Delimiter $$
create procedure sp_BuscarFactura (
    in codFactura int)
begin
    select f.codigoFactura, f.fechaEmision, f.metodoPago, f.total, f.codigoCliente
    from Facturas f 
    where f.codigoFactura = codFactura;
end$$
Delimiter ;
call sp_BuscarFactura(1);

-- EDITAR FACTURA
Delimiter $$
create procedure sp_EditarFactura (
    in codFactura int,
    in fecha datetime,
    in metodo enum('Efectivo', 'Credito'),
    in totalFactura decimal(10,2),
    in codCliente int)
begin
    update Facturas f 
    set f.fechaEmision = fecha, 
        f.metodoPago = metodo,
        f.total = totalFactura, 
        f.codigoCliente = codCliente
    where f.codigoFactura = codFactura;
end$$
Delimiter ;
call sp_EditarFactura(1, '2023-06-15 12:00:00', 'Credito', 275.00, 1);
-- PROCEDIMIENTOS ALMACENADOS (NOTICIAS) -------------------------
-- AGREGAR NOTICIA
Delimiter $$
create procedure sp_AgregarNoticia (
	in encabezadoNot varchar(100),
	in info varchar(250),
	in categoriaNot varchar(50),
	in fecha datetime)
begin
	insert into Noticias (encabezado, informacion, categoria, fechaNoticia)
	values (encabezadoNot, info, categoriaNot, fecha);
end$$
Delimiter ;
call sp_AgregarNoticia('Nueva colección de juguetes', 'La nueva colección incluye figuras exclusivas.', 'Novedades', '2023-06-01 08:00:00');
call sp_AgregarNoticia('Descuentos especiales', 'Aprovecha los descuentos del 20% en compras mayores a Q500.', 'Promoción', '2023-06-02 09:30:00');
 
-- LISTAR NOTICIAS
Delimiter $$
create procedure sp_ListarNoticias ()
begin
    select n.codigoNoticia, n.encabezado, n.informacion, n.categoria, n.fechaNoticia 
    from Noticias n;
end$$
Delimiter ;
call sp_ListarNoticias();
 
-- ELIMINAR NOTICIA
Delimiter $$
create procedure sp_EliminarNoticia (
	in codNoticia int)
begin
	delete from Noticias where codigoNoticia = codNoticia;
end$$
Delimiter ;
call sp_EliminarNoticia(2);
 
-- BUSCAR NOTICIA
Delimiter $$
create procedure sp_BuscarNoticia (
    in codNoticia int)
begin
    select n.codigoNoticia, n.encabezado, n.informacion, n.categoria, n.fechaNoticia 
    from Noticias n 
    where n.codigoNoticia = codNoticia;
end$$
Delimiter ;
call sp_BuscarNoticia(1);
 
-- EDITAR NOTICIA
Delimiter $$
create procedure sp_EditarNoticia (
	in codNoticia int,
	in encabezadoNot varchar(100),
	in info varchar(250),
	in categoriaNot varchar(50),
	in fecha datetime)
begin
	update Noticias set encabezado = encabezadoNot, informacion = info,
		categoria = categoriaNot, fechaNoticia = fecha
	where codigoNoticia = codNoticia;
end$$
Delimiter ;
call sp_EditarNoticia(1, 'Colección actualizada', 'Ahora con más figuras disponibles.', 'Novedades', '2023-06-03 10:00:00');

-- PROCEDIMIENTOS ALMACENADOS (PROVEEDORES) -------------------------
-- AGREGAR PROVEEDOR
Delimiter $$
create procedure sp_AgregarProveedor (
	in nombreProv varchar(50),
	in telefonoProv varchar(9),
	in correoProv varchar(100),
	in direccionProv varchar(125))
begin
	insert into Proveedores (nombreProveedor, telefonoProveedor, correoProveedor, direccionProveedor)
	values (nombreProv, telefonoProv, correoProv, direccionProv);
end$$
Delimiter ;
call sp_AgregarProveedor('Distribuciones GT', '78451230', 'contacto@gt.com', 'Zona 1, Guatemala');
call sp_AgregarProveedor('Juguetón', '45678912', 'ventas@jugueton.com', 'Zona 12, Guatemala');
 
-- LISTAR PROVEEDORES
Delimiter $$
create procedure sp_ListarProveedores ()
begin
    select p.codigoProveedor, p.nombreProveedor, p.telefonoProveedor, p.correoProveedor, p.direccionProveedor 
    from Proveedores p;
end$$
Delimiter ;
call sp_ListarProveedores();
 
-- ELIMINAR PROVEEDOR
Delimiter $$
create procedure sp_EliminarProveedor (
	in codProveedor int)
begin
	delete from Proveedores where codigoProveedor = codProveedor;
end$$
Delimiter ;
call sp_EliminarProveedor(2);
 
-- BUSCAR PROVEEDOR
Delimiter $$
create procedure sp_BuscarProveedor (
    in codProveedor int)
begin
    select p.codigoProveedor, p.nombreProveedor, p.telefonoProveedor, p.correoProveedor, p.direccionProveedor 
    from Proveedores p 
    where p.codigoProveedor = codProveedor;
end$$
Delimiter ;
call sp_BuscarProveedor(1);
 
-- EDITAR PROVEEDOR
Delimiter $$
create procedure sp_EditarProveedor (
	in codProveedor int,
	in nombreProv varchar(50),
	in telefonoProv varchar(9),
	in correoProv varchar(100),
	in direccionProv varchar(125))
begin
	update Proveedores set nombreProveedor = nombreProv,
		telefonoProveedor = telefonoProv, correoProveedor = correoProv,
		direccionProveedor = direccionProv
	where codigoProveedor = codProveedor;
end$$
Delimiter ;
call sp_EditarProveedor(1, 'Distribuciones GT', '12345678', 'nuevo@gt.com', 'Zona 10, Guatemala');

-- PROCEDIMIENTOS ALMACENADOS (JUGUETES) -------------------------
-- AGREGAR JUGUETE
Delimiter $$
create procedure sp_AgregarJuguete (
	in nombreJuguete varchar(50),
	in precioJuguete decimal(10,2),
	in categoriaJuguete varchar(50),
	in marcaJuguete varchar(50),
	in stockJuguete int,
	in codNoticia int)
begin
	insert into Juguetes (nombreJuguete, precio, categoria, marca, stock, codigoNoticia)
	values (nombreJuguete, precioJuguete, categoriaJuguete, marcaJuguete, stockJuguete, codNoticia);
end$$
Delimiter ;
call sp_AgregarJuguete('Batman', 150.00, 'Figuras', 'DC', 20, 1);
call sp_AgregarJuguete('Buzz Lightyear', 180.00, 'Figuras', 'Pixar', 15, 1);
 
-- LISTAR JUGUETES
Delimiter $$
create procedure sp_ListarJuguetes ()
begin
    select j.codigoJuguete, j.nombreJuguete, j.precio, j.categoria, j.marca, j.stock, j.codigoNoticia 
    from Juguetes j;
end$$
Delimiter ;
call sp_ListarJuguetes();
 
-- ELIMINAR JUGUETE
Delimiter $$
create procedure sp_EliminarJuguete (
	in codJuguete int)
begin
	delete from Juguetes where codigoJuguete = codJuguete;
end$$
Delimiter ;
call sp_EliminarJuguete(2);
 
-- BUSCAR JUGUETE
Delimiter $$
create procedure sp_BuscarJuguete (
    in codJuguete int)
begin
    select j.codigoJuguete, j.nombreJuguete, j.precio, j.categoria, j.marca, j.stock, j.codigoNoticia 
    from Juguetes j 
    where j.codigoJuguete = codJuguete;
end$$
Delimiter ;
call sp_BuscarJuguete(1);
 
-- EDITAR JUGUETE
Delimiter $$
create procedure sp_EditarJuguete (
	in codJuguete int,
	in nombreJuguete varchar(50),
	in precioJuguete decimal(10,2),
	in categoriaJuguete varchar(50),
	in marcaJuguete varchar(50),
	in stockJuguete int,
	in codNoticia int)
begin
	update Juguetes set nombreJuguete = nombreJuguete, precio = precioJuguete,
		categoria = categoriaJuguete, marca = marcaJuguete, stock = stockJuguete,
		codigoNoticia = codNoticia
	where codigoJuguete = codJuguete;
end$$
Delimiter ;
call sp_EditarJuguete(1, 'Batman Deluxe', 160.00, 'Figuras', 'DC Comics', 25, 1);

-- PROCEDIMIENTOS ALMACENADOS (CUENTAS) -------------------------
-- AGREGAR CUENTA
Delimiter $$
create procedure sp_AgregarCuenta (
    in rol enum('Cliente', 'Empleado'),
    in nombre varchar(50),
    in correo varchar(100),
    in contrasena varchar(255),
    in fotoperfil varchar(255),
    in codCliente int,
    in codEmpleado int)
begin
    insert into Cuentas (rol, nombreCuenta, correoCuenta, contrasenaCuenta, fotoperfil, codigoCliente, codigoEmpleado)
    values (rol, nombre, correo, contrasena, fotoperfil, codCliente, codEmpleado);
end$$
Delimiter ;
call sp_AgregarCuenta('Cliente', 'Proxy549', 'proxy549@gmail.com', 'admin', null, 1, null);


-- LISTAR CUENTAS
Delimiter $$
create procedure sp_ListarCuentas ()
begin
    select c.codigoCuenta, c.rol, c.nombreCuenta, c.correoCuenta, c.contrasenaCuenta, c.fotoperfil, c.codigoCliente, c.codigoEmpleado 
    from Cuentas c;
end$$
Delimiter ;
call sp_ListarCuentas();

-- ELIMINAR CUENTA
Delimiter $$
create procedure sp_EliminarCuenta (
    in codCuenta int)
begin
    delete from Cuentas c where c.codigoCuenta = codCuenta;
end$$
Delimiter ;

-- BUSCAR CUENTA
Delimiter $$
create procedure sp_BuscarCuenta (
    in codCuenta int)
begin
    select c.codigoCuenta, c.rol, c.nombreCuenta, c.correoCuenta, c.contrasenaCuenta, c.fotoperfil, c.codigoCliente, c.codigoEmpleado 
    from Cuentas c 
    where c.codigoCuenta = codCuenta;
end$$
Delimiter ;
call sp_BuscarCuenta(1);

-- EDITAR CUENTA
Delimiter $$
create procedure sp_EditarCuenta (
    in codCuenta int,
    in rol enum('Cliente', 'Empleado'),
    in nombre varchar(50),
    in correo varchar(100),
    in contrasena varchar(255),
    in fotoperfil varchar(255),
    in codCliente int,
    in codEmpleado int)
begin
    update Cuentas c
    set c.rol = rol, 
        c.nombreCuenta = nombre, 
        c.correoCuenta = correo, 
        c.contrasenaCuenta = contrasena, 
        c.fotoperfil = fotoperfil,
        c.codigoCliente = codCliente,
        c.codigoEmpleado = codEmpleado
    where c.codigoCuenta = codCuenta;
end$$
Delimiter ;
call sp_EditarCuenta(1, 'Cliente', 'Realiquez', 'jrealiquez@gmail.com', '1980', null, 1, null);

-- PROCEDIMIENTOS ALMACENADOS (CARRITOS) -------------------------
-- AGREGAR CARRITO
Delimiter $$
create procedure sp_AgregarCarrito (
    in fecha datetime,
    in estadoCarrito enum('Activo', 'Comprado'),
    in totalCarrito decimal(10,2),
    in codCliente int)
begin
    insert into Carritos (fechaCreacion, estado, total, codigoCliente)
    values (fecha, estadoCarrito, totalCarrito, codCliente);
end$$
Delimiter ;
call sp_AgregarCarrito('2023-06-20 09:00:00', 'Activo', 300.00, 1);
call sp_AgregarCarrito('2023-06-21 10:30:00', 'Comprado', 450.00, 1);

-- LISTAR CARRITOS
Delimiter $$
create procedure sp_ListarCarritos ()
begin
    select c.codigoCarrito, c.fechaCreacion, c.estado, c.total, c.codigoCliente 
    from Carritos c;
end$$
Delimiter ;
call sp_ListarCarritos();

-- ELIMINAR CARRITO
Delimiter $$
create procedure sp_EliminarCarrito (
    in codCarrito int)
begin
    delete from Carritos c 
    where c.codigoCarrito = codCarrito;
end$$
Delimiter ;
call sp_EliminarCarrito(2);

-- BUSCAR CARRITO
Delimiter $$
create procedure sp_BuscarCarrito (
    in codCarrito int)
begin
    select c.codigoCarrito, c.fechaCreacion, c.estado, c.total, c.codigoCliente 
    from Carritos c 
    where c.codigoCarrito = codCarrito;
end$$
Delimiter ;
call sp_BuscarCarrito(1);

-- EDITAR CARRITO
Delimiter $$
create procedure sp_EditarCarrito (
    in codCarrito int,
    in fecha datetime,
    in estadoCarrito enum('Activo', 'Comprado'),
    in totalCarrito decimal(10,2),
    in codCliente int)
begin
    update Carritos c 
    set c.fechaCreacion = fecha,
        c.estado = estadoCarrito, 
        c.total = totalCarrito,
        c.codigoCliente = codCliente
    where c.codigoCarrito = codCarrito;
end$$
Delimiter ;
call sp_EditarCarrito(1, '2023-06-20 09:30:00', 'Comprado', 320.00, 1);

-- PROCEDIMIENTOS ALMACENADOS (DETALLESCARRITOS) -------------------------
-- AGREGAR DETALLE CARRITO
Delimiter $$
create procedure sp_AgregarDetalleCarrito (
    in cantidad int,
    in subTotal decimal(10,2),
    in descuento decimal(10,2),
    in codCarrito int,
    in codJuguete int)
begin
    insert into DetallesCarritos (cantidad, subTotal, descuentoAplicado, codigoCarrito, codigoJuguete)
    values (cantidad, subTotal, descuento, codCarrito, codJuguete);
end$$
Delimiter ;
call sp_AgregarDetalleCarrito(2, 300.00, 20.00, 1, 1);
call sp_AgregarDetalleCarrito(1, 150.00, 0.00, 1, 1);

-- LISTAR DETALLES CARRITOS
Delimiter $$
create procedure sp_ListarDetallesCarritos ()
begin
    select dc.codigoDetalleC,
           dc.cantidad,
           dc.subTotal,
           dc.descuentoAplicado,
           dc.codigoCarrito,
           dc.codigoJuguete
    from DetallesCarritos dc;
end$$
Delimiter ;
call sp_ListarDetallesCarritos();

-- ELIMINAR DETALLE CARRITO
Delimiter $$
create procedure sp_EliminarDetalleCarrito (
    in codDetalle int)
begin
    delete from DetallesCarritos dc where dc.codigoDetalleC = codDetalle;
end$$
Delimiter ;
call sp_EliminarDetalleCarrito(2);

-- BUSCAR DETALLE CARRITO
Delimiter $$
create procedure sp_BuscarDetalleCarrito (
    in codDetalle int)
begin
    select dc.codigoDetalleC,
           dc.cantidad,
           dc.subTotal,
           dc.descuentoAplicado,
           dc.codigoCarrito,
           dc.codigoJuguete
    from DetallesCarritos dc where dc.codigoDetalleC = codDetalle;
end$$
Delimiter ;
call sp_BuscarDetalleCarrito(1);

-- EDITAR DETALLE CARRITO
Delimiter $$
create procedure sp_EditarDetalleCarrito (
    in codDetalle int,
    in cantidad int,
    in subTotal decimal(10,2),
    in descuento decimal(10,2),
    in codCarrito int,
    in codJuguete int)
begin
    update DetallesCarritos dc 
    set dc.cantidad = cantidad,
        dc.subTotal = subTotal, 
        dc.descuentoAplicado = descuento,
        dc.codigoCarrito = codCarrito, 
        dc.codigoJuguete = codJuguete
    where dc.codigoDetalleC = codDetalle;
end$$
Delimiter ;
call sp_EditarDetalleCarrito(1, 3, 450.00, 30.00, 1, 1);

-- VALIDACION DE CUENTA
Delimiter $
create procedure sp_validarCuentas(
    in dpi varchar(15),
    in correo varchar(100),
    in password varchar(255)
)
begin
    select 
        c.codigoCuenta,
        c.rol,
        c.nombreCuenta,
        c.correoCuenta,
        c.contrasenaCuenta,
        c.fotoperfil,
        c.codigoCliente,
        c.codigoEmpleado
    from Cuentas c
    LEFT JOIN Clientes cl ON c.codigoCliente = cl.codigoCliente
    LEFT JOIN Empleados e ON c.codigoEmpleado = e.codigoEmpleado
    where c.correoCuenta = correo
      and c.contrasenaCuenta = password
      and (
          (c.rol = 'Cliente' and cl.dpiCliente = dpi) or
          (c.rol = 'Empleado' and e.dpiEmpleado = dpi)
      );
end$
Delimiter ;

call sp_AgregarEmpleados('Edvin leonel', 'Cujcuj', 'Zona 1, Guatemala', '12345678', 'Gerente', 5000.00, '1');
call sp_AgregarCuenta('Empleado', 'Leonel', 'ecujcuj@gmail.com', '1', null, null, 1);

call sp_validarCuentas('1', 'ecujcuj@gmail.com', '1');

