package com.proyecto.erpventas.infrastructure.controller.Reportes;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;
import com.proyecto.erpventas.application.usecases.reportecuentas.ReporteCuentasPorCobrarUseCase;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
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

    @GetMapping(value = "/cuentas-por-cobrar/pdf", produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> descargarPdf()
            throws JRException, SQLException, IOException {
        byte[] pdf = useCase.generarPdfCuentasPorCobrar();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(
            ContentDisposition.attachment().filename("CuentasPorCobrar.pdf").build()
        );
        return ResponseEntity.ok().headers(headers).body(pdf);
    }

    @GetMapping(value = "/cuentas-por-cobrar/excel", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<byte[]> descargarExcel()
            throws JRException, SQLException, IOException {
        byte[] excel = useCase.generarExcelCuentasPorCobrar();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(
            ContentDisposition.attachment().filename("CuentasPorCobrar.xlsx").build()
        );
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return ResponseEntity.ok().headers(headers).body(excel);
    }
}