package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.UpdateVentaDTO;
import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.infrastructure.repository.MetodoPagoRepository;
import com.proyecto.erpventas.infrastructure.repository.VentaRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateVentaUseCase {

    private final VentaRepository ventaRepository;
    private final MetodoPagoRepository metodoPagoRepository;

    public UpdateVentaUseCase(VentaRepository ventaRepository, MetodoPagoRepository metodoPagoRepository) {
        this.ventaRepository = ventaRepository;
        this.metodoPagoRepository = metodoPagoRepository;
    }

    public Venta update(Integer id, UpdateVentaDTO dto) {
        Venta existing = ventaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        MetodoPago metodo = metodoPagoRepository.findById(dto.getMetodoPagoId())
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));
        existing.setMetodoPago(metodo);
        existing.setTotal(dto.getTotal());
        return ventaRepository.save(existing);
    }
}