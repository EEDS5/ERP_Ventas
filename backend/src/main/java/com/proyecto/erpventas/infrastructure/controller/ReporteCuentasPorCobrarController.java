package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;
import com.proyecto.erpventas.application.usecases.reportecuentas.ReporteCuentasPorCobrarUseCase;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reportes")
public class ReporteCuentasPorCobrarController {

    private final ReporteCuentasPorCobrarUseCase useCase;

    public ReporteCuentasPorCobrarController(ReporteCuentasPorCobrarUseCase useCase) {
        this.useCase = useCase;
    }

    @GetMapping("/cuentas-por-cobrar")
    public ResponseEntity<List<CuentaPorCobrarResponse>> obtenerReporte() {
        return ResponseEntity.ok(useCase.obtenerReporteCuentasPorCobrar());
    }
}