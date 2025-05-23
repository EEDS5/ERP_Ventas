package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.inventory.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.metodo.MetodoPagoRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetMetodoPagoByIdUseCase {

    private final MetodoPagoRepository metodoPagoRepository;

    public GetMetodoPagoByIdUseCase(MetodoPagoRepository metodoPagoRepository) {
        this.metodoPagoRepository = metodoPagoRepository;
    }

    public Optional<MetodoPago> getById(Integer id) {
        return metodoPagoRepository.findById(id);
    }
}
