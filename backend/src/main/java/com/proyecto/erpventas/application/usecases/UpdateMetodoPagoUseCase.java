package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.metodopago.UpdateMetodoPagoDTO;
import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.MetodoPagoRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateMetodoPagoUseCase {

    private final MetodoPagoRepository metodoPagoRepository;

    public UpdateMetodoPagoUseCase(MetodoPagoRepository metodoPagoRepository) {
        this.metodoPagoRepository = metodoPagoRepository;
    }

    public MetodoPago update(Integer id, UpdateMetodoPagoDTO dto) {
        MetodoPago existing = metodoPagoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));
        existing.setNombre(dto.getNombre());
        return metodoPagoRepository.save(existing);
    }
}