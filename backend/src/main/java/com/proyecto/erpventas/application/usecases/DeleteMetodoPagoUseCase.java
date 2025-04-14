package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.MetodoPagoRepository;
import org.springframework.stereotype.Service;

@Service
public class DeleteMetodoPagoUseCase {

    private final MetodoPagoRepository metodoPagoRepository;

    public DeleteMetodoPagoUseCase(MetodoPagoRepository metodoPagoRepository) {
        this.metodoPagoRepository = metodoPagoRepository;
    }

    public void delete(Integer id) {
        MetodoPago m = metodoPagoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));
        m.setActivo(false);
        metodoPagoRepository.save(m);
    }
}