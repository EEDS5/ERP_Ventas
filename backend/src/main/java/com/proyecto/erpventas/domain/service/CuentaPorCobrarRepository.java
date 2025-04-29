package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.response.CuentaPorCobrarResponse;
import java.util.List;

public interface CuentaPorCobrarRepository {
    List<CuentaPorCobrarResponse> obtenerReporteCuentasPorCobrar();
}