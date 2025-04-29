package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.Factura;
import com.proyecto.erpventas.infrastructure.repository.factura.FacturaRepository;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListFacturasUseCase {

    private final FacturaRepository facturaRepository;

    public ListFacturasUseCase(FacturaRepository facturaRepository) {
        this.facturaRepository = facturaRepository;
    }

    public List<Factura> listAll() {
        return facturaRepository.findAllByActivoTrue();
    }
}
