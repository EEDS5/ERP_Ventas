// backend/src/main/java/com/proyecto/erpventas/infrastructure/controller/Reportes/ReporteFacturacionController.java
package com.proyecto.erpventas.infrastructure.controller.Reportes;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;
import com.proyecto.erpventas.application.usecases.reportefacturacion.ReporteFacturacionUseCase;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
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

    @GetMapping(value = "/facturacion-mensual/pdf", produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> descargarPdf()
            throws JRException, SQLException, IOException {
        byte[] pdf = reporteFacturacionUseCase.generarPdfFacturacionMensual();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(
            ContentDisposition.attachment().filename("FacturacionMensual.pdf").build()
        );
        return ResponseEntity.ok().headers(headers).body(pdf);
    }

    @GetMapping(value = "/facturacion-mensual/excel", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<byte[]> descargarExcel()
            throws JRException, SQLException, IOException {
        byte[] excel = reporteFacturacionUseCase.generarExcelFacturacionMensual();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(
            ContentDisposition.attachment().filename("FacturacionMensual.xlsx").build()
        );
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return ResponseEntity.ok().headers(headers).body(excel);
    }
}