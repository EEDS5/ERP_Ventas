package com.proyecto.erpventas.application.usecases.venta;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListVentasUseCase {

    private final VentaRepository ventaRepository;

    public ListVentasUseCase(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }

    public List<Venta> listAll() {
        /* return ventaRepository.findAllByActivoTrue(); */
         return ventaRepository.findAll();
    }
}
