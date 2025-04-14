package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.CreateMetodoPagoDTO;
import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.MetodoPagoRepository;
import org.springframework.stereotype.Service;

@Service
public class CreateMetodoPagoUseCase {

    private final MetodoPagoRepository metodoPagoRepository;

    public CreateMetodoPagoUseCase(MetodoPagoRepository metodoPagoRepository) {
        this.metodoPagoRepository = metodoPagoRepository;
    }

    public MetodoPago create(CreateMetodoPagoDTO dto) {
        if (metodoPagoRepository.existsByNombre(dto.getNombre())) {
            throw new RuntimeException("Ya existe un método de pago con ese nombre");
        }
        MetodoPago m = new MetodoPago();
        m.setNombre(dto.getNombre());
        return metodoPagoRepository.save(m);
    }
}