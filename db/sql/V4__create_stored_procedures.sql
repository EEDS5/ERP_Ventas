---------------------------------------------------------------------
-- FUNCIONES ALMACENADAS (Stored Procedures) para manejo de borrado,
-- reactivación y obtención de registros activos
-- Se demuestra cada uno por tabla
---------------------------------------------------------------------

------------------------------------------------
-- USUARIOS
------------------------------------------------
-- BorrarUsuario(_UsuarioID) -> soft-delete
CREATE OR REPLACE FUNCTION BorrarUsuario(_UsuarioID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Usuarios SET Activo = FALSE WHERE UsuarioID = _UsuarioID;
END;
$$ LANGUAGE plpgsql;

-- ReactivarUsuario(_UsuarioID) -> set Activo=TRUE
CREATE OR REPLACE FUNCTION ReactivarUsuario(_UsuarioID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Usuarios SET Activo = TRUE WHERE UsuarioID = _UsuarioID;
END;
$$ LANGUAGE plpgsql;

-- ObtenerUsuariosActivos() -> retorna sólo los registros Activo=TRUE
CREATE OR REPLACE FUNCTION ObtenerUsuariosActivos()
RETURNS SETOF Usuarios AS $$
    SELECT * FROM Usuarios WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- CLIENTES
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarCliente(_ClienteID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Clientes SET Activo = FALSE WHERE ClienteID = _ClienteID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarCliente(_ClienteID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Clientes SET Activo = TRUE WHERE ClienteID = _ClienteID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerClientesActivos()
RETURNS SETOF Clientes AS $$
    SELECT * FROM Clientes WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- METODOSPAGO
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarMetodoPago(_MetodoPagoID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE MetodosPago SET Activo = FALSE WHERE MetodoPagoID = _MetodoPagoID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarMetodoPago(_MetodoPagoID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE MetodosPago SET Activo = TRUE WHERE MetodoPagoID = _MetodoPagoID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerMetodosPagoActivos()
RETURNS SETOF MetodosPago AS $$
    SELECT * FROM MetodosPago WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- VENTAS
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarVenta(_VentaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Ventas SET Activo = FALSE WHERE VentaID = _VentaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarVenta(_VentaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Ventas SET Activo = TRUE WHERE VentaID = _VentaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerVentasActivas()
RETURNS SETOF Ventas AS $$
    SELECT * FROM Ventas WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- PRODUCTOS
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarProducto(_ProductoID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Productos SET Activo = FALSE WHERE ProductoID = _ProductoID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarProducto(_ProductoID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Productos SET Activo = TRUE WHERE ProductoID = _ProductoID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerProductosActivos()
RETURNS SETOF Productos AS $$
    SELECT * FROM Productos WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- DETALLEVENTAS
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarDetalleVenta(_DetalleID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE DetalleVentas SET Activo = FALSE WHERE DetalleID = _DetalleID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarDetalleVenta(_DetalleID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE DetalleVentas SET Activo = TRUE WHERE DetalleID = _DetalleID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerDetalleVentasActivos()
RETURNS SETOF DetalleVentas AS $$
    SELECT * FROM DetalleVentas WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- FACTURAS
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarFactura(_FacturaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Facturas SET Activo = FALSE WHERE FacturaID = _FacturaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarFactura(_FacturaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Facturas SET Activo = TRUE WHERE FacturaID = _FacturaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerFacturasActivas()
RETURNS SETOF Facturas AS $$
    SELECT * FROM Facturas WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- CUENTASPORCOBRAR
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarCuentaPorCobrar(_CuentaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE CuentasPorCobrar SET Activo = FALSE WHERE CuentaID = _CuentaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarCuentaPorCobrar(_CuentaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE CuentasPorCobrar SET Activo = TRUE WHERE CuentaID = _CuentaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerCuentasPorCobrarActivas()
RETURNS SETOF CuentasPorCobrar AS $$
    SELECT * FROM CuentasPorCobrar WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- PAGOS
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarPago(_PagoID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Pagos SET Activo = FALSE WHERE PagoID = _PagoID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarPago(_PagoID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Pagos SET Activo = TRUE WHERE PagoID = _PagoID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerPagosActivos()
RETURNS SETOF Pagos AS $$
    SELECT * FROM Pagos WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- PASARELASPAGO
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarPasarelaPago(_PasarelaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE PasarelasPago SET Activo = FALSE WHERE PasarelaID = _PasarelaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarPasarelaPago(_PasarelaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE PasarelasPago SET Activo = TRUE WHERE PasarelaID = _PasarelaID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerPasarelasPagoActivas()
RETURNS SETOF PasarelasPago AS $$
    SELECT * FROM PasarelasPago WHERE Activo = TRUE;
$$ LANGUAGE sql;


------------------------------------------------
-- TRANSACCIONESPASARELA
------------------------------------------------
CREATE OR REPLACE FUNCTION BorrarTransaccionPasarela(_TransaccionID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE TransaccionesPasarela SET Activo = FALSE WHERE TransaccionID = _TransaccionID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ReactivarTransaccionPasarela(_TransaccionID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE TransaccionesPasarela SET Activo = TRUE WHERE TransaccionID = _TransaccionID;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerTransaccionesPasarelaActivas()
RETURNS SETOF TransaccionesPasarela AS $$
    SELECT * FROM TransaccionesPasarela WHERE Activo = TRUE;
$$ LANGUAGE sql;