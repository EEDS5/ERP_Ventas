---------------------------------------------------------------------
-- CARGA MASIVA PARA REPORTE DE CUENTAS POR COBRAR
-- Inserción de cuentas pendientes y pagos parciales/totalmente realizados
-- 
-- Se respetan las relaciones referenciales y se simulan estados realistas.
-- Algunas ventas están totalmente pagadas, otras parcialmente y otras vencidas.
---------------------------------------------------------------------

------------------------------------------------
-- CUENTAS POR COBRAR
------------------------------------------------
-- Asociadas a las 1800 facturas existentes (una por venta)
-- Simula 3 estados: Pendiente, Pagado, Vencido
-- El MontoPendiente puede o no coincidir con el total de la venta
------------------------------------------------
INSERT INTO CuentasPorCobrar (clienteid, ventaid, montopendiente, fechavencimiento, estado)
SELECT 
    v.clienteid,
    v.ventaid,
    CASE
        WHEN (v.ventaid % 3 = 0) THEN 0                        -- Pagado
        WHEN (v.ventaid % 3 = 1) THEN v.total                 -- Pendiente
        ELSE (v.total / 2.0)::NUMERIC(10,2)                   -- Parcial (Vencido)
    END,
    v.fechaventa + INTERVAL '30 days',
    CASE
        WHEN (v.ventaid % 3 = 0) THEN 'Pagado'
        WHEN (v.ventaid % 3 = 1) THEN 'Pendiente'
        ELSE 'Vencido'
    END
FROM 
    ventas v
JOIN 
    facturas f ON v.ventaid = f.ventaid
WHERE 
    v.activo = TRUE
ORDER BY 
    v.ventaid;

------------------------------------------------
-- PAGOS
------------------------------------------------
-- Solo para algunas cuentas por cobrar con estado 'Pagado' o 'Vencido'
-- Se simulan pagos únicos o parciales
------------------------------------------------
INSERT INTO Pagos (cuentaid, fechapago, monto)
SELECT 
    c.cuentaid,
    c.fechavencimiento - INTERVAL '10 days',
    CASE
        WHEN c.estado = 'Pagado' THEN (SELECT total FROM ventas WHERE ventaid = c.ventaid)
        ELSE (SELECT (total / 2.0)::NUMERIC(10,2) FROM ventas WHERE ventaid = c.ventaid)
    END
FROM 
    CuentasPorCobrar c
WHERE 
    c.estado IN ('Pagado', 'Vencido')
ORDER BY 
    c.cuentaid;

---------------------------------------------------------------------
-- Nota:
-- - Se asigna estado 'Pagado' a 1 de cada 3 cuentas.
-- - Se asigna estado 'Pendiente' a 1 de cada 3, sin pagos.
-- - El resto está como 'Vencido', con pagos parciales.
-- - Los pagos simulan ser anteriores a la fecha de vencimiento.
---------------------------------------------------------------------