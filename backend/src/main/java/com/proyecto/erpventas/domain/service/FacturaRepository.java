package com.proyecto.erpventas.domain.service;

import java.util.List;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturado;

public interface FacturaRepository {
    List<MesFacturado> obtenerFacturacionMensual();
}