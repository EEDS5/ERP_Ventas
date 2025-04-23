package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.UpdateFacturaDTO;
import com.proyecto.erpventas.domain.model.sales.Factura;
import com.proyecto.erpventas.infrastructure.repository.FacturaRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateFacturaUseCase {

    private final FacturaRepository facturaRepository;

    public UpdateFacturaUseCase(FacturaRepository facturaRepository) {
        this.facturaRepository = facturaRepository;
    }

    public Factura update(Integer id, UpdateFacturaDTO dto) {
        Factura existing = facturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada"));
        existing.setXmlFactura(dto.getXmlFactura());
        return facturaRepository.save(existing);
    }
}