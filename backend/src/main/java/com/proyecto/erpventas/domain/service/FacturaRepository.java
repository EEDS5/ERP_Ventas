package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.response.FacturacionMensualResponse;
import java.util.List;

public interface FacturaRepository {
    List<FacturacionMensualResponse> obtenerFacturacionMensual();
}