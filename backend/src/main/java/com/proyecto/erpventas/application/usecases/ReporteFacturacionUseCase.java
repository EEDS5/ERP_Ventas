package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.response.MesFacturado;
import com.proyecto.erpventas.domain.service.FacturaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReporteFacturacionUseCase {

    private final FacturaRepository facturaRepository;

    public ReporteFacturacionUseCase(FacturaRepository facturaRepository) {
        this.facturaRepository = facturaRepository;
    }

    public List<MesFacturado> obtenerFacturacionMensual() {
        return facturaRepository.obtenerFacturacionMensual();
    }
}