package com.proyecto.erpventas.application.usecases.reportefacturacion;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;
import com.proyecto.erpventas.domain.service.FacturaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

import java.time.YearMonth;
import java.util.Comparator;

@Service
public class ReporteFacturacionUseCase {

    private final FacturaRepository facturaRepository;

    public ReporteFacturacionUseCase(FacturaRepository facturaRepository) {
        this.facturaRepository = facturaRepository;
    }

    public List<MesFacturadoResponse> obtenerFacturacionMensual() {
        return facturaRepository.obtenerFacturacionMensual()
                .stream()
                .sorted(Comparator.comparing(m -> YearMonth.parse(m.getMes())))
                .toList();
    }
}