package com.proyecto.erpventas.application.usecases.dashboard;

import com.proyecto.erpventas.application.dto.response.dashboard.VentasHoyResponse;

public interface ObtenerVentasHoyUseCase {
    VentasHoyResponse ejecutar();
}