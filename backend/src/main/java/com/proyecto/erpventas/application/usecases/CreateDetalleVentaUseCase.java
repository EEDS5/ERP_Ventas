package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.detalleventa.CreateDetalleVentaDTO;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;
import com.proyecto.erpventas.infrastructure.repository.venta.VentaRepository;

import org.springframework.stereotype.Service;

@Service
public class CreateDetalleVentaUseCase {

    private final DetalleVentaRepository detalleRepository;
    private final VentaRepository ventaRepository;
    private final ProductoRepository productoRepository;

    public CreateDetalleVentaUseCase(DetalleVentaRepository detalleRepository,
                                     VentaRepository ventaRepository,
                                     ProductoRepository productoRepository) {
        this.detalleRepository = detalleRepository;
        this.ventaRepository = ventaRepository;
        this.productoRepository = productoRepository;
    }

    public DetalleVenta create(CreateDetalleVentaDTO dto) {
        Venta venta = ventaRepository.findById(dto.getVentaId())
                .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        Producto producto = productoRepository.findById(dto.getProductoId())
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

        DetalleVenta d = new DetalleVenta();
        d.setVenta(venta);
        d.setProducto(producto);
        d.setCantidad(dto.getCantidad());
        d.setPrecioUnitario(dto.getPrecioUnitario());
        // subtotal lo calcula la BD
        return detalleRepository.save(d);
    }
}
