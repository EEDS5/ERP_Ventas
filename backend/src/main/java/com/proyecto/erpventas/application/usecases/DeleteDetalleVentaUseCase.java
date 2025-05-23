package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;

import org.springframework.stereotype.Service;

@Service
public class DeleteDetalleVentaUseCase {

    private final DetalleVentaRepository detalleRepository;

    public DeleteDetalleVentaUseCase(DetalleVentaRepository detalleRepository) {
        this.detalleRepository = detalleRepository;
    }

    public void delete(Integer id) {
        DetalleVenta d = detalleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Detalle de venta no encontrado"));
        d.setActivo(false);
        detalleRepository.save(d);
    }
}