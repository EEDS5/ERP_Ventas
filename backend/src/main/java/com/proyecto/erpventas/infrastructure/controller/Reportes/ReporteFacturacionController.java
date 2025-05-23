package com.proyecto.erpventas.infrastructure.controller.Reportes;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;
import com.proyecto.erpventas.application.usecases.reportefacturacion.ReporteFacturacionUseCase;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/reportes")
public class ReporteFacturacionController {

    private final ReporteFacturacionUseCase reporteFacturacionUseCase;

    public ReporteFacturacionController(ReporteFacturacionUseCase reporteFacturacionUseCase) {
        this.reporteFacturacionUseCase = reporteFacturacionUseCase;
    }

    @GetMapping("/facturacion-mensual")
    public ResponseEntity<List<MesFacturadoResponse>> obtenerFacturacionMensual() {
        return ResponseEntity.ok(reporteFacturacionUseCase.obtenerFacturacionMensual());
    }
}