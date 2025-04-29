package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.Factura;
import com.proyecto.erpventas.infrastructure.repository.factura.FacturaRepository;

import org.springframework.stereotype.Service;

@Service
public class DeleteFacturaUseCase {

    private final FacturaRepository facturaRepository;

    public DeleteFacturaUseCase(FacturaRepository facturaRepository) {
        this.facturaRepository = facturaRepository;
    }

    public void delete(Integer id) {
        Factura f = facturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada"));
        f.setActivo(false);
        facturaRepository.save(f);
    }
}