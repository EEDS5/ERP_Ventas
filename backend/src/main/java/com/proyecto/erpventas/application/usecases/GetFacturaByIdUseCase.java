package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.Factura;
import com.proyecto.erpventas.infrastructure.repository.FacturaRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetFacturaByIdUseCase {

    private final FacturaRepository facturaRepository;

    public GetFacturaByIdUseCase(FacturaRepository facturaRepository) {
        this.facturaRepository = facturaRepository;
    }

    public Optional<Factura> getById(Integer id) {
        return facturaRepository.findById(id);
    }
}