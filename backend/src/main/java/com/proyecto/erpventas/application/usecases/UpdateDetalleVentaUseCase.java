package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.detalleventa.UpdateDetalleVentaDTO;
import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;

import org.springframework.stereotype.Service;

@Service
public class UpdateDetalleVentaUseCase {

    private final DetalleVentaRepository detalleRepository;

    public UpdateDetalleVentaUseCase(DetalleVentaRepository detalleRepository) {
        this.detalleRepository = detalleRepository;
    }

    public DetalleVenta update(Integer id, UpdateDetalleVentaDTO dto) {
        DetalleVenta existing = detalleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Detalle de venta no encontrado"));
        existing.setCantidad(dto.getCantidad());
        existing.setPrecioUnitario(dto.getPrecioUnitario());
        return detalleRepository.save(existing);
    }
}