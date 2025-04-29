package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.response.MesFacturado;
import java.util.List;

public interface FacturaRepository {
    List<MesFacturado> obtenerFacturacionMensual();
}