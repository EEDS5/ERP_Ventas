package com.proyecto.erpventas.infrastructure.controller.Reportes;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.application.usecases.reporteventas.ReporteVentasUseCase;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/reportes")
public class ReporteVentasController {

    private final ReporteVentasUseCase reporteVentasUseCase;

    public ReporteVentasController(ReporteVentasUseCase reporteVentasUseCase) {
        this.reporteVentasUseCase = reporteVentasUseCase;
    }

    @GetMapping("/ventas-por-cliente")
    public ResponseEntity<List<VentaPorClienteResponse>> obtenerVentasPorCliente() {
        return ResponseEntity.ok(reporteVentasUseCase.obtenerHistorialVentasPorCliente());
    }

    @GetMapping("/ventas-por-cliente/pdf")
    public ResponseEntity<byte[]> generarVentasPorClientePdf() {
        byte[] pdfBytes = reporteVentasUseCase.generarReporteVentasPdf();
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=ReporteVentasPorCliente.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdfBytes);
    }
}