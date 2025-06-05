// backend/src/main/java/com/proyecto/erpventas/application/usecases/reportefacturacion/ReporteFacturacionUseCase.java
package com.proyecto.erpventas.application.usecases.reportefacturacion;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;
import com.proyecto.erpventas.domain.service.FacturaRepository;
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
import java.time.YearMonth;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReporteFacturacionUseCase {

        private final FacturaRepository facturaRepository;
        private final DataSource dataSource;

        public ReporteFacturacionUseCase(FacturaRepository facturaRepository,
                        DataSource dataSource) {
                this.facturaRepository = facturaRepository;
                this.dataSource = dataSource;
        }

        public List<MesFacturadoResponse> obtenerFacturacionMensual() {
                return facturaRepository.obtenerFacturacionMensual()
                                .stream()
                                .sorted(Comparator.comparing(m -> YearMonth.parse(m.getMes())))
                                .toList();
        }

        private JasperPrint prepararReporteFacturacion() throws JRException, SQLException {
                JasperReport jasperReport = JasperCompileManager.compileReport(
                                getClass().getResourceAsStream("/reports/ReporteFacturacionMensual.jrxml"));
                Map<String, Object> params = new HashMap<>();
                Connection conn = dataSource.getConnection();
                return JasperFillManager.fillReport(jasperReport, params, conn);
        }

        public byte[] generarPdfFacturacionMensual() throws JRException, SQLException, IOException {
                try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                                Connection conn = dataSource.getConnection()) {

                        JasperPrint jasperPrint = prepararReporteFacturacion();
                        JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
                        return outputStream.toByteArray();
                }
        }

        public byte[] generarExcelFacturacionMensual() throws JRException, SQLException, IOException {
                try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                                Connection conn = dataSource.getConnection()) {

                        JasperPrint jasperPrint = prepararReporteFacturacion();

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