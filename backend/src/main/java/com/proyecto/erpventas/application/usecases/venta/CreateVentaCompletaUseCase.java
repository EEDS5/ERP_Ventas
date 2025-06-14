package com.proyecto.erpventas.application.usecases.venta;

import com.proyecto.erpventas.application.dto.request.venta.CreateVentaCompletaDTO;
import com.proyecto.erpventas.application.dto.response.venta.DetalleVentaDTO;
import com.proyecto.erpventas.application.dto.response.venta.VentaCompletaDTO;
import com.proyecto.erpventas.domain.model.inventory.MetodoPago;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.domain.model.sales.CuentaPorCobrar;
import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;
import com.proyecto.erpventas.infrastructure.repository.cliente.ClienteRepository;
import com.proyecto.erpventas.infrastructure.repository.cuenta.CuentaPorCobrarRepository;
import com.proyecto.erpventas.infrastructure.repository.metodo.MetodoPagoRepository;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import com.proyecto.erpventas.infrastructure.repository.venta.DetalleVentaRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class CreateVentaCompletaUseCase {

    private final VentaRepository ventaRepository;
    private final DetalleVentaRepository detalleRepository;
    private final ProductoRepository productoRepository;
    private final ClienteRepository clienteRepository;
    private final MetodoPagoRepository metodoPagoRepository;
    private final UserRepository userRepository;
    private final CuentaPorCobrarRepository cuentaRepository;

    public CreateVentaCompletaUseCase(VentaRepository ventaRepository,
                                      DetalleVentaRepository detalleRepository,
                                      ProductoRepository productoRepository,
                                      ClienteRepository clienteRepository,
                                      MetodoPagoRepository metodoPagoRepository,
                                      UserRepository userRepository,
                                      CuentaPorCobrarRepository cuentaRepository) {
        this.ventaRepository = ventaRepository;
        this.detalleRepository = detalleRepository;
        this.productoRepository = productoRepository;
        this.clienteRepository = clienteRepository;
        this.metodoPagoRepository = metodoPagoRepository;
        this.userRepository = userRepository;
        this.cuentaRepository = cuentaRepository;
    }

    @Transactional
    public VentaCompletaDTO create(CreateVentaCompletaDTO dto) {
        Cliente cliente = clienteRepository.findById(dto.getClienteId())
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado"));
        MetodoPago metodo = metodoPagoRepository.findById(dto.getMetodoPagoId())
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));
        Usuario usuario = userRepository.findById(dto.getCreadoPorUsuarioId())
                .orElseThrow(() -> new RuntimeException("Usuario creador no encontrado"));

        Venta venta = new Venta();
        venta.setCliente(cliente);
        venta.setMetodoPago(metodo);
        venta.setCreadoPorUsuario(usuario);

        BigDecimal total = BigDecimal.ZERO;
        List<DetalleVentaDTO> detalleDtos = new ArrayList<>();
        List<DetalleVenta> detalles = new ArrayList<>();
        for (CreateVentaCompletaDTO.DetalleItem item : dto.getDetalles()) {
            Producto prod = productoRepository.findById(item.getProductoId())
                    .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
            BigDecimal precio = prod.getPrecio();
            BigDecimal subtotal = precio.multiply(BigDecimal.valueOf(item.getCantidad()));
            total = total.add(subtotal);

            DetalleVenta det = new DetalleVenta();
            det.setProducto(prod);
            det.setCantidad(item.getCantidad());
            det.setPrecioUnitario(precio);
            det.setVenta(venta);
            detalles.add(det);

            detalleDtos.add(new DetalleVentaDTO(
                    prod.getProductoId(),
                    prod.getNombre(),
                    item.getCantidad(),
                    precio,
                    subtotal
            ));
        }

        venta.setTotal(total);
        Venta savedVenta = ventaRepository.save(venta);

        detalles.forEach(detalleRepository::save);

        if (metodo.getNombre().toLowerCase().contains("crédito")) {
            CuentaPorCobrar c = new CuentaPorCobrar();
            c.setCliente(cliente);
            c.setVenta(savedVenta);
            c.setMontoPendiente(total);
            c.setFechaVencimiento(LocalDateTime.now().plusDays(30));
            c.setEstado("Pendiente");
            cuentaRepository.save(c);
        }

        return new VentaCompletaDTO(
                savedVenta.getVentaId(),
                cliente.getClienteId(),
                cliente.getNombre(),
                savedVenta.getFechaVenta(),
                total,
                metodo.getMetodoPagoId(),
                metodo.getNombre(),
                usuario.getUsuarioID(),
                usuario.getNombreUsuario(),
                savedVenta.getActivo(),
                detalleDtos
        );
    }
}
