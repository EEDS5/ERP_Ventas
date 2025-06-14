package com.proyecto.erpventas.application.usecases.venta;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReactivateVentaUseCase {

    private final VentaRepository ventaRepository;

    public ReactivateVentaUseCase(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }

    @Transactional
    public void activate(Integer id) {
        Venta v = ventaRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        v.setActivo(true);
        ventaRepository.save(v);
    }
}
