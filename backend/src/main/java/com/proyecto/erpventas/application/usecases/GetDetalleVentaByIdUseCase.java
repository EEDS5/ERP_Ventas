package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetDetalleVentaByIdUseCase {

    private final DetalleVentaRepository detalleRepository;

    public GetDetalleVentaByIdUseCase(DetalleVentaRepository detalleRepository) {
        this.detalleRepository = detalleRepository;
    }

    public Optional<DetalleVenta> getById(Integer id) {
        return detalleRepository.findById(id);
    }
}