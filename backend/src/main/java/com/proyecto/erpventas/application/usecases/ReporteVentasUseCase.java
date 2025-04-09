package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.response.VentaPorClienteResponse;
import com.proyecto.erpventas.domain.service.VentaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReporteVentasUseCase {

    private final VentaRepository ventaRepository;

    public ReporteVentasUseCase(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }

    public List<VentaPorClienteResponse> obtenerHistorialVentasPorCliente() {
        return ventaRepository.obtenerVentasActivasConCliente()
                .stream()
                .map(v -> new VentaPorClienteResponse(
                        v.getCliente().getClienteId(),
                        v.getCliente().getNombre(),
                        v.getVentaId(),
                        v.getFechaVenta(),
                        v.getTotal()
                ))
                .collect(Collectors.toList());
    }
}