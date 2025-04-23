package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.MetodoPagoRepository;
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
