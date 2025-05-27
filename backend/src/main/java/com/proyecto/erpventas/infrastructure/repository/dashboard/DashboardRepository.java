package com.proyecto.erpventas.infrastructure.repository.dashboard;

import java.math.BigDecimal;
import java.util.Map;

public interface DashboardRepository {
    BigDecimal obtenerVentasHoy();
    BigDecimal obtenerFacturacionMesActual();
    Map<String, Object> obtenerResumenCuentas();
    Integer obtenerCantidadStockBajo();
    Integer obtenerCantidadUsuarios2FA();
}