package com.proyecto.erpventas.domain.service;

import java.util.List;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;

public interface FacturaRepository {
    List<MesFacturadoResponse> obtenerFacturacionMensual();
}