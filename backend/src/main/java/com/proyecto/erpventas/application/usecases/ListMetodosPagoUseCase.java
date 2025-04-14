package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.MetodoPagoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListMetodosPagoUseCase {

    private final MetodoPagoRepository metodoPagoRepository;

    public ListMetodosPagoUseCase(MetodoPagoRepository metodoPagoRepository) {
        this.metodoPagoRepository = metodoPagoRepository;
    }

    public List<MetodoPago> listAll() {
        return metodoPagoRepository.findAllByActivoTrue();
    }
}
