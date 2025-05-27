package com.proyecto.erpventas.application.usecases.reportecuentas;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;
import com.proyecto.erpventas.domain.service.CuentaPorCobrarRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReporteCuentasPorCobrarUseCase {

    private final CuentaPorCobrarRepository cuentaPorCobrarRepository;
    private final DataSource dataSource;

    public ReporteCuentasPorCobrarUseCase(CuentaPorCobrarRepository cuentaPorCobrarRepository,
                                          DataSource dataSource) {
        this.cuentaPorCobrarRepository = cuentaPorCobrarRepository;
        this.dataSource = dataSource;
    }

    public List<CuentaPorCobrarResponse> obtenerReporteCuentasPorCobrar() {
        return cuentaPorCobrarRepository.obtenerReporteCuentasPorCobrar()
                .stream()
                .sorted(Comparator.comparing(CuentaPorCobrarResponse::getFechaVencimiento))
                .toList();
    }

    public byte[] generarPdfCuentasPorCobrar()
            throws JRException, SQLException, IOException {
        JasperReport jasperReport = JasperCompileManager.compileReport(
                getClass().getResourceAsStream("/reports/ReporteCuentasPorCobrar.jrxml"));

        Map<String, Object> params = new HashMap<>();
        try (Connection conn = dataSource.getConnection();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            JasperPrint jasperPrint = JasperFillManager.fillReport(
                    jasperReport, params, conn);
            JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
            return outputStream.toByteArray();
        }
    }

    public byte[] generarExcelCuentasPorCobrar()
            throws JRException, SQLException, IOException {
        JasperReport jasperReport = JasperCompileManager.compileReport(
                getClass().getResourceAsStream("/reports/ReporteCuentasPorCobrar.jrxml"));

        Map<String, Object> params = new HashMap<>();
        try (Connection conn = dataSource.getConnection();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            JasperPrint jasperPrint = JasperFillManager.fillReport(
                    jasperReport, params, conn);

            JRXlsxExporter exporter = new JRXlsxExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));

            SimpleXlsxReportConfiguration config = new SimpleXlsxReportConfiguration();
            config.setDetectCellType(true);
            config.setCollapseRowSpan(false);
            exporter.setConfiguration(config);

            exporter.exportReport();
            return outputStream.toByteArray();
        }
    }
}