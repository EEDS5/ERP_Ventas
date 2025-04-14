package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.infrastructure.repository.DetalleVentaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListDetallesVentaUseCase {

    private final DetalleVentaRepository detalleRepository;

    public ListDetallesVentaUseCase(DetalleVentaRepository detalleRepository) {
        this.detalleRepository = detalleRepository;
    }

    public List<DetalleVenta> listAll() {
        return detalleRepository.findAll();
    }

    public List<DetalleVenta> listByVenta(Integer ventaId) {
        return detalleRepository.findAllByVenta(ventaId);
    }
}
