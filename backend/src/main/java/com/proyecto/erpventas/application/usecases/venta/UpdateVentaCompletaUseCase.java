package com.proyecto.erpventas.application.usecases.venta;

import com.proyecto.erpventas.application.dto.request.venta.UpdateVentaCompletaDTO;
import com.proyecto.erpventas.application.dto.response.venta.DetalleVentaDTO;
import com.proyecto.erpventas.application.dto.response.venta.VentaCompletaDTO;
import com.proyecto.erpventas.domain.model.inventory.MetodoPago;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.domain.model.sales.CuentaPorCobrar;
import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.infrastructure.repository.cuenta.CuentaPorCobrarRepository;
import com.proyecto.erpventas.infrastructure.repository.metodo.MetodoPagoRepository;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;
import com.proyecto.erpventas.infrastructure.repository.venta.VentaRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class UpdateVentaCompletaUseCase {

    private final VentaRepository ventaRepository;
    private final DetalleVentaRepository detalleRepository;
    private final ProductoRepository productoRepository;
    private final MetodoPagoRepository metodoPagoRepository;
    private final CuentaPorCobrarRepository cuentaRepository;

    public UpdateVentaCompletaUseCase(VentaRepository ventaRepository,
                                      DetalleVentaRepository detalleRepository,
                                      ProductoRepository productoRepository,
                                      MetodoPagoRepository metodoPagoRepository,
                                      CuentaPorCobrarRepository cuentaRepository) {
        this.ventaRepository = ventaRepository;
        this.detalleRepository = detalleRepository;
        this.productoRepository = productoRepository;
        this.metodoPagoRepository = metodoPagoRepository;
        this.cuentaRepository = cuentaRepository;
    }

    public VentaCompletaDTO update(Integer ventaId, UpdateVentaCompletaDTO dto) {
        Venta venta = ventaRepository.findById(ventaId)
                .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        MetodoPago metodo = metodoPagoRepository.findById(dto.getMetodoPagoId())
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));

        List<DetalleVenta> actuales = detalleRepository.findAllByVenta(ventaId);
        for (DetalleVenta d : actuales) {
            detalleRepository.softDeleteById(d.getDetalleId());
        }

        BigDecimal total = BigDecimal.ZERO;
        List<DetalleVentaDTO> detalleDtos = new ArrayList<>();
        for (UpdateVentaCompletaDTO.DetalleItem item : dto.getDetalles()) {
            Producto prod = productoRepository.findById(item.getProductoId())
                    .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
            BigDecimal precio = prod.getPrecio();
            BigDecimal subtotal = precio.multiply(BigDecimal.valueOf(item.getCantidad()));
            total = total.add(subtotal);

            DetalleVenta det = new DetalleVenta();
            det.setVenta(venta);
            det.setProducto(prod);
            det.setCantidad(item.getCantidad());
            det.setPrecioUnitario(precio);
            detalleRepository.save(det);

            detalleDtos.add(new DetalleVentaDTO(
                    prod.getProductoId(),
                    prod.getNombre(),
                    item.getCantidad(),
                    precio,
                    subtotal
            ));
        }

        venta.setMetodoPago(metodo);
        venta.setTotal(total);
        Venta saved = ventaRepository.save(venta);

        if (metodo.getNombre().toLowerCase().contains("crédito")) {
            CuentaPorCobrar cuenta = cuentaRepository.findByVentaId(ventaId)
                    .orElse(new CuentaPorCobrar());
            cuenta.setVenta(saved);
            cuenta.setCliente(saved.getCliente());
            cuenta.setMontoPendiente(total);
            cuenta.setFechaVencimiento(LocalDateTime.now().plusDays(30));
            cuenta.setEstado("Pendiente");
            cuentaRepository.save(cuenta);
        }

        return new VentaCompletaDTO(
                saved.getVentaId(),
                saved.getCliente().getClienteId(),
                saved.getCliente().getNombre(),
                saved.getFechaVenta(),
                total,
                metodo.getMetodoPagoId(),
                metodo.getNombre(),
                saved.getCreadoPorUsuario().getUsuarioID(),
                saved.getCreadoPorUsuario().getNombreUsuario(),
                saved.getActivo(),
                detalleDtos
        );
    }
}
