package com.proyecto.erpventas.application.usecases.reporteventas;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.domain.service.VentaRepository;
import com.proyecto.erpventas.infrastructure.mapper.VentaPorClienteMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReporteVentasUseCase {

    private final VentaRepository ventaRepository;
    private final VentaPorClienteMapper ventaPorClienteMapper;

    public ReporteVentasUseCase(VentaRepository ventaRepository, VentaPorClienteMapper ventaPorClienteMapper) {
        this.ventaRepository = ventaRepository;
        this.ventaPorClienteMapper = ventaPorClienteMapper;
    }

    public List<VentaPorClienteResponse> obtenerHistorialVentasPorCliente() {
        return ventaRepository.obtenerVentasActivasConCliente()
                .stream()
                .map(ventaPorClienteMapper::fromVenta)
                .collect(Collectors.toList());
    }
}