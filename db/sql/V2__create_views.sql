--------------------------------------------------
-- Reporte: Historial de ventas por cliente
--------------------------------------------------
CREATE VIEW ReporteHistorialVentas AS
SELECT 
    C.ClienteID, 
    C.Nombre AS Cliente, 
    V.VentaID, 
    V.FechaVenta, 
    V.Total
FROM 
    Clientes C
JOIN 
    Ventas V ON C.ClienteID = V.ClienteID
WHERE 
    C.Activo = TRUE AND V.Activo = TRUE;

--------------------------------------------------
-- Reporte: Facturación mensual
--------------------------------------------------
CREATE VIEW ReporteFacturacionMensual AS
SELECT 
    to_char(F.FechaEmision, 'YYYY-MM') AS Mes, 
    SUM(V.Total) AS TotalFacturado
FROM 
    Facturas F
JOIN 
    Ventas V ON F.VentaID = V.VentaID
WHERE 
    F.Activo = TRUE AND V.Activo = TRUE
GROUP BY 
    to_char(F.FechaEmision, 'YYYY-MM');