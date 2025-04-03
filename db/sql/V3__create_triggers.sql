---------------------------------------------------------------------
-- TRIGGERS para evitar borrado físico (soft-delete) en cada tabla
-- Cada trigger intercepta DELETE y lo convierte en un UPDATE Activo=FALSE
---------------------------------------------------------------------

-- 1) Usuarios
CREATE OR REPLACE FUNCTION sp_prevent_delete_Usuarios()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Usuarios SET Activo = FALSE WHERE UsuarioID = OLD.UsuarioID;
    RETURN NULL; -- Prevenimos la eliminación física
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Usuarios
BEFORE DELETE ON Usuarios
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Usuarios();


-- 2) Clientes
CREATE OR REPLACE FUNCTION sp_prevent_delete_Clientes()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Clientes SET Activo = FALSE WHERE ClienteID = OLD.ClienteID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Clientes
BEFORE DELETE ON Clientes
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Clientes();


-- 3) MetodosPago
CREATE OR REPLACE FUNCTION sp_prevent_delete_MetodosPago()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE MetodosPago SET Activo = FALSE WHERE MetodoPagoID = OLD.MetodoPagoID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_MetodosPago
BEFORE DELETE ON MetodosPago
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_MetodosPago();


-- 4) Ventas
CREATE OR REPLACE FUNCTION sp_prevent_delete_Ventas()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Ventas SET Activo = FALSE WHERE VentaID = OLD.VentaID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Ventas
BEFORE DELETE ON Ventas
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Ventas();


-- 5) Productos
CREATE OR REPLACE FUNCTION sp_prevent_delete_Productos()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Productos SET Activo = FALSE WHERE ProductoID = OLD.ProductoID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Productos
BEFORE DELETE ON Productos
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Productos();


-- 6) DetalleVentas
CREATE OR REPLACE FUNCTION sp_prevent_delete_DetalleVentas()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE DetalleVentas SET Activo = FALSE WHERE DetalleID = OLD.DetalleID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_DetalleVentas
BEFORE DELETE ON DetalleVentas
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_DetalleVentas();


-- 7) Facturas
CREATE OR REPLACE FUNCTION sp_prevent_delete_Facturas()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Facturas SET Activo = FALSE WHERE FacturaID = OLD.FacturaID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Facturas
BEFORE DELETE ON Facturas
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Facturas();


-- 8) CuentasPorCobrar
CREATE OR REPLACE FUNCTION sp_prevent_delete_CuentasPorCobrar()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE CuentasPorCobrar SET Activo = FALSE WHERE CuentaID = OLD.CuentaID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_CuentasPorCobrar
BEFORE DELETE ON CuentasPorCobrar
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_CuentasPorCobrar();


-- 9) Pagos
CREATE OR REPLACE FUNCTION sp_prevent_delete_Pagos()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Pagos SET Activo = FALSE WHERE PagoID = OLD.PagoID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Pagos
BEFORE DELETE ON Pagos
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Pagos();


-- 10) PasarelasPago
CREATE OR REPLACE FUNCTION sp_prevent_delete_PasarelasPago()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE PasarelasPago SET Activo = FALSE WHERE PasarelaID = OLD.PasarelaID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_PasarelasPago
BEFORE DELETE ON PasarelasPago
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_PasarelasPago();


-- 11) TransaccionesPasarela
CREATE OR REPLACE FUNCTION sp_prevent_delete_TransaccionesPasarela()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE TransaccionesPasarela SET Activo = FALSE WHERE TransaccionID = OLD.TransaccionID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_TransaccionesPasarela
BEFORE DELETE ON TransaccionesPasarela
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_TransaccionesPasarela();