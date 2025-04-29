---------------------------------------------------------------------
-- CARGA MASIVA PARA REPORTE DE FACTURACIÓN MENSUAL
-- Inserción exclusiva de facturas basadas en ventas ya existentes
-- 
-- Se respetan las relaciones referenciales.
-- Cada factura corresponde a una venta existente y activa.
-- Las fechas de emisión son coherentes con las fechas de venta.
---------------------------------------------------------------------

------------------------------------------------
-- FACTURAS
------------------------------------------------
-- Insertar facturas asociadas a las ventas generadas previamente
-- No se duplican datos de Usuarios, Clientes, Productos, Ventas
------------------------------------------------

INSERT INTO Facturas (ventaid, numerofactura, fechaemision, creadoPorUsuarioID)
SELECT 
    v.ventaid,
    CONCAT('FAC-', LPAD(v.ventaid::TEXT, 6, '0')), -- Genera número de factura único tipo FAC-000001
    v.fechaventa + INTERVAL '1 day',               -- Fecha de emisión: 1 día después de la venta
    v.creadoporusuarioid                            -- Creador: mismo usuario que registró la venta
FROM 
    ventas v
WHERE 
    v.activo = TRUE
ORDER BY 
    v.ventaid
LIMIT 1800;  -- Solo creamos facturas para las primeras 1800 ventas

---------------------------------------------------------------------
-- Nota:
-- - Se crean facturas para 1800 ventas de las 2000 generadas inicialmente.
-- - Esto permite que existan ventas facturadas y otras no, simulando un entorno real.
-- - El campo XMLFactura se deja NULL en esta carga inicial de pruebas.
---------------------------------------------------------------------