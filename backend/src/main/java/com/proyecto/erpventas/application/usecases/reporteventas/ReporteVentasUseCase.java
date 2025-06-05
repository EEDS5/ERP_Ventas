package com.proyecto.erpventas.application.usecases.reporteventas;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.domain.service.VentaRepository;
import com.proyecto.erpventas.infrastructure.mapper.VentaPorClienteMapper;

import net.sf.jasperreports.engine.*;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Comparator;
import java.util.stream.Collectors;

import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

@Service
public class ReporteVentasUseCase {

    private final VentaRepository ventaRepository;
    private final VentaPorClienteMapper ventaPorClienteMapper;
    private final DataSource dataSource;

    public ReporteVentasUseCase(VentaRepository ventaRepository,
            VentaPorClienteMapper ventaPorClienteMapper,
            DataSource dataSource) {
        this.ventaRepository = ventaRepository;
        this.ventaPorClienteMapper = ventaPorClienteMapper;
        this.dataSource = dataSource;
    }

    public List<VentaPorClienteResponse> obtenerHistorialVentasPorCliente() {
        return ventaRepository.obtenerVentasActivasConCliente()
                .stream()
                .map(ventaPorClienteMapper::fromVenta)
                .sorted(Comparator.comparing(VentaPorClienteResponse::getFechaVenta))
                .collect(Collectors.toList());
    }

    private JasperPrint prepararReporteVentas(Map<String, Object> params) throws JRException, SQLException {
        // 1) Cargo y compilo el JRXML
        InputStream jrxml = getClass().getClassLoader()
                .getResourceAsStream("reports/ReporteVentasPorCliente.jrxml");
        if (jrxml == null) {
            throw new RuntimeException(
                    "Plantilla JRXML no encontrada en classpath: reports/ReporteVentasPorCliente.jrxml");
        }
        JasperReport jasperReport = JasperCompileManager.compileReport(jrxml);

        // 2) Llena el reporte usando conexión JDBC
        try (Connection conn = dataSource.getConnection()) {
            return JasperFillManager.fillReport(jasperReport, params, conn);
        }
    }

    public byte[] generarReporteVentasPdf() {
        try {
            // 1) Parámetros (por ejemplo el título)
            Map<String, Object> params = new HashMap<>();
            params.put("ReportTitle", "Historial de Ventas por Cliente");

            // 2) Preparo el reporte
            JasperPrint jasperPrint = prepararReporteVentas(params);

            // 3) Exporta a PDF
            return JasperExportManager.exportReportToPdf(jasperPrint);

        } catch (Exception e) {
            // Log completo de la excepción
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            System.err.println("Error generando reporte PDF:\n" + sw);
            throw new RuntimeException("Error generando reporte PDF: " + e.getMessage(), e);
        }
    }

    /**
     * Genera un reporte de ventas por cliente en .xlsx usando la misma plantilla
     * JRXML.
     */
    public byte[] generarReporteVentasExcelConJasper() {
        try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            // 1) Parámetros
            Map<String, Object> params = new HashMap<>();
            params.put("ReportTitle", "Historial de Ventas por Cliente");

            // 2) Preparo el reporte
            JasperPrint jasperPrint = prepararReporteVentas(params);

            // 3) Configuro exportador XLSX
            JRXlsxExporter exporter = new JRXlsxExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(out));

            SimpleXlsxReportConfiguration config = new SimpleXlsxReportConfiguration();
            config.setOnePagePerSheet(false);
            config.setDetectCellType(true);
            config.setCollapseRowSpan(false);
            config.setIgnoreGraphics(false);
            exporter.setConfiguration(config);

            // 4) Exporto y retorno bytes
            exporter.exportReport();
            return out.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException("Error generando reporte Excel con Jasper: " + e.getMessage(), e);
        }
    }
}
// Este código es parte de un sistema ERP de ventas y maneja la generación de
// reportes de ventas por cliente.