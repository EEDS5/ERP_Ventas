package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.infrastructure.repository.venta.VentaRepository;

import org.springframework.stereotype.Service;

@Service
public class DeleteVentaUseCase {

    private final VentaRepository ventaRepository;

    public DeleteVentaUseCase(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }

    public void delete(Integer id) {
        Venta v = ventaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        v.setActivo(false);
        ventaRepository.save(v);
    }
}