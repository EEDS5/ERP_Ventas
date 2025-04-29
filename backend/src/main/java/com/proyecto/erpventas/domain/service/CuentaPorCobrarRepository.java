package com.proyecto.erpventas.domain.service;

import java.util.List;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;

public interface CuentaPorCobrarRepository {
    List<CuentaPorCobrarResponse> obtenerReporteCuentasPorCobrar();
}