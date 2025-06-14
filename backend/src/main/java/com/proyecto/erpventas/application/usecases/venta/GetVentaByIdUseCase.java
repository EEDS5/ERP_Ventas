package com.proyecto.erpventas.application.usecases.venta;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetVentaByIdUseCase {

    private final VentaRepository ventaRepository;

    public GetVentaByIdUseCase(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }

    public Optional<Venta> getById(Integer id) {
        return ventaRepository.findById(id);
    }
}
