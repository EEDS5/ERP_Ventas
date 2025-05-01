package com.proyecto.erpventas.application.usecases.reporteventas;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.application.dto.response.VentaPorClienteReport;
import com.proyecto.erpventas.domain.service.VentaRepository;
import com.proyecto.erpventas.infrastructure.mapper.VentaPorClienteMapper;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;
import java.util.stream.Collectors;

@Service
public class ReporteVentasUseCase {

    private final VentaRepository ventaRepository;
    private final VentaPorClienteMapper ventaPorClienteMapper;

    public ReporteVentasUseCase(VentaRepository ventaRepository, VentaPorClienteMapper ventaPorClienteMapper) {
        this.ventaRepository = ventaRepository;
        this.ventaPorClienteMapper = ventaPorClienteMapper;
    }

    public List<VentaPorClienteResponse> obtenerHistorialVentasPorCliente() {
        return ventaRepository.obtenerVentasActivasConCliente()
                .stream()
                .map(ventaPorClienteMapper::fromVenta)
                .collect(Collectors.toList());
    }

    public byte[] generarReporteVentasPdf() {
        try {
            // 1) Cargo y compilo el JRXML
            InputStream jrxml = getClass().getClassLoader()
                .getResourceAsStream("reports/ReporteVentasPorCliente.jrxml");
            if (jrxml == null) 
                throw new RuntimeException("Plantilla JRXML no encontrada");
            JasperReport jasperReport = JasperCompileManager.compileReport(jrxml);
    
            // 2) Traigo tu lista original de DTOs
            List<VentaPorClienteResponse> raw = obtenerHistorialVentasPorCliente();
    
            // 3) La transformo a la lista de beans con java.util.Date
            List<VentaPorClienteReport> records = raw.stream()
                .map(r -> new VentaPorClienteReport(
                    r.getClienteId(),
                    r.getClienteNombre(),
                    r.getVentaId(),
                    Date.from(r.getFechaVenta()
                              .atZone(ZoneId.systemDefault()).toInstant()),
                    r.getTotalVenta()
                ))
                .collect(Collectors.toList());
    
            // 4) JRBeanCollectionDataSource SÓLO sobre beans
            JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(records);
    
            // 5) Parámetros
            Map<String,Object> params = new HashMap<>();
            params.put("ReportTitle", "Historial de Ventas por Cliente");
    
            // 6) Lleno y exporto
            JasperPrint jasperPrint = JasperFillManager.fillReport(
                jasperReport, params, ds);
            return JasperExportManager.exportReportToPdf(jasperPrint);
    
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error generando reporte PDF", e);
        }
    }
}