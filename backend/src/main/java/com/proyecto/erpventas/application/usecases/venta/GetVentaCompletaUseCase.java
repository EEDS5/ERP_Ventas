package com.proyecto.erpventas.application.usecases.venta;

import com.proyecto.erpventas.application.dto.response.venta.DetalleVentaDTO;
import com.proyecto.erpventas.application.dto.response.venta.VentaCompletaDTO;
import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.domain.service.VentaRepository;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class GetVentaCompletaUseCase {

    private final VentaRepository ventaRepository;
    private final DetalleVentaRepository detalleRepository;

    public GetVentaCompletaUseCase(VentaRepository ventaRepository,
                                   DetalleVentaRepository detalleRepository) {
        this.ventaRepository = ventaRepository;
        this.detalleRepository = detalleRepository;
    }

    public Optional<VentaCompletaDTO> getById(Integer id) {
        return ventaRepository.findById(id).map(v -> {
            // obtenemos todos los detalles activos
            List<DetalleVentaDTO> detalles = detalleRepository.findAllByVenta(id).stream()
                .filter(DetalleVenta::getActivo)
                .map(d -> new DetalleVentaDTO(
                    d.getProducto().getProductoId(),
                    d.getProducto().getNombre(),
                    d.getCantidad(),
                    d.getPrecioUnitario(),
                    d.getSubtotal()
                ))
                .collect(Collectors.toList());

            return new VentaCompletaDTO(
                v.getVentaId(),
                v.getCliente().getClienteId(),
                v.getCliente().getNombre(),
                v.getFechaVenta(),
                v.getTotal(),
                v.getMetodoPago().getMetodoPagoId(),
                v.getMetodoPago().getNombre(),
                v.getCreadoPorUsuario().getUsuarioID(),
                v.getCreadoPorUsuario().getNombreUsuario(),
                v.getActivo(),
                detalles
            );
        });
    }
}
