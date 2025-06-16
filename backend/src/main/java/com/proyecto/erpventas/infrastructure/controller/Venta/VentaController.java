package com.proyecto.erpventas.infrastructure.controller.Venta;

import com.proyecto.erpventas.application.dto.response.venta.DetalleVentaDTO;
import com.proyecto.erpventas.application.dto.request.venta.CreateVentaCompletaDTO;
import com.proyecto.erpventas.application.dto.request.venta.UpdateVentaCompletaDTO;
import com.proyecto.erpventas.application.dto.response.venta.VentaCompletaDTO;
import com.proyecto.erpventas.infrastructure.repository.factura.FacturaRepository;
import com.proyecto.erpventas.infrastructure.repository.pasarela.PasarelaPagoRepository;
import com.proyecto.erpventas.infrastructure.repository.transaccion.TransaccionPasarelaRepository;
import com.proyecto.erpventas.infrastructure.paypal.PayPalClient;
import com.proyecto.erpventas.application.usecases.venta.*;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.model.inventory.PasarelaPago;
import com.proyecto.erpventas.domain.model.sales.TransaccionPasarela;
import com.proyecto.erpventas.domain.model.people.Usuario;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/ventas")
public class VentaController {

    private final CreateVentaCompletaUseCase createCompletaUC;
    private final ListVentasUseCase listUC;
    private final UpdateVentaCompletaUseCase updateCompletaUC;
    private final DeleteVentaUseCase deleteUC;
    private final GetVentaCompletaUseCase getCompletaUC;
    private final FacturaRepository facturaRepository;
    private final ReactivateVentaUseCase reactivateUC;
    private final PasarelaPagoRepository pasarelaRepository;
    private final TransaccionPasarelaRepository transaccionRepository;
    private final PayPalClient payPalClient;

    public VentaController(
            CreateVentaCompletaUseCase createCompletaUC,
            ListVentasUseCase listUC,
            UpdateVentaCompletaUseCase updateCompletaUC,
            DeleteVentaUseCase deleteUC,
            GetVentaCompletaUseCase getCompletaUC,
            FacturaRepository facturaRepository,
            ReactivateVentaUseCase reactivateUC,
            PasarelaPagoRepository pasarelaRepository,
            TransaccionPasarelaRepository transaccionRepository,
            PayPalClient payPalClient) {
        this.createCompletaUC = createCompletaUC;
        this.listUC = listUC;
        this.updateCompletaUC = updateCompletaUC;
        this.deleteUC = deleteUC;
        this.getCompletaUC = getCompletaUC;
        this.facturaRepository = facturaRepository;
        this.reactivateUC = reactivateUC;
        this.pasarelaRepository = pasarelaRepository;
        this.transaccionRepository = transaccionRepository;
        this.payPalClient = payPalClient;
    }

    @GetMapping
    public ResponseEntity<List<VentaCompletaDTO>> getAll() {
        List<Venta> ventas = listUC.listAll();
        List<VentaCompletaDTO> response = ventas.stream().map(this::toDto).toList();
        return ResponseEntity.ok(response);
    }

    /*
     * @GetMapping("/{id}")
     * public ResponseEntity<VentaCompletaDTO> getById(@PathVariable Integer id) {
     * Venta venta = getByIdUC.getById(id)
     * .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
     * return ResponseEntity.ok(toDto(venta));
     * }
     */

    /*
     * @PostMapping
     * public ResponseEntity<VentaCompletaDTO> create(@Valid @RequestBody
     * CreateVentaDTO dto) {
     * Venta created = createUC.create(dto);
     * return ResponseEntity.ok(toDto(created));
     * }
     */

    @PostMapping("/completa")
    public ResponseEntity<VentaCompletaDTO> createCompleta(@Valid @RequestBody CreateVentaCompletaDTO dto) {
        VentaCompletaDTO created = createCompletaUC.create(dto);
        return ResponseEntity.ok(created);
    }

    @PostMapping("/paypal/create-order")
    public ResponseEntity<String> createOrder(@RequestParam("amount") BigDecimal amount) throws Exception {
        String token = payPalClient.obtainAccessToken();
        String orderId = payPalClient.createOrder(token, amount);
        return ResponseEntity.ok(orderId);
    }

    @PostMapping("/paypal/capture-order")
    public ResponseEntity<VentaCompletaDTO> captureOrder(@RequestParam("orderId") String orderId,
                                                         @Valid @RequestBody CreateVentaCompletaDTO dto) throws Exception {
        String token = payPalClient.obtainAccessToken();
        PayPalClient.CaptureResult result = payPalClient.captureOrder(token, orderId);
        if (!"COMPLETED".equalsIgnoreCase(result.status())) {
            throw new RuntimeException("Orden no aprobada");
        }
        VentaCompletaDTO ventaDto = createCompletaUC.create(dto);

        PasarelaPago pasarela = pasarelaRepository.findByNombre("PayPal")
                .orElseGet(() -> {
                    PasarelaPago p = new PasarelaPago();
                    p.setNombre("PayPal");
                    return pasarelaRepository.save(p);
                });

        TransaccionPasarela tx = new TransaccionPasarela();
        Venta ventaRef = new Venta();
        ventaRef.setVentaId(ventaDto.getVentaId());
        tx.setVenta(ventaRef);
        tx.setPasarela(pasarela);
        tx.setEstado("Aprobado");
        tx.setFechaTransaccion(LocalDateTime.now());
        tx.setMonto(result.amount());
        tx.setReferenciaTransaccion(result.transactionId());
        Usuario u = new Usuario();
        u.setUsuarioID(dto.getCreadoPorUsuarioId());
        tx.setIniciadaPorUsuario(u);
        transaccionRepository.save(tx);

        return ResponseEntity.ok(ventaDto);
    }

    /*
     * @PutMapping("/{id}")
     * public ResponseEntity<VentaCompletaDTO> update(@PathVariable Integer id,
     * 
     * @Valid @RequestBody UpdateVentaDTO dto) {
     * Venta updated = updateUC.update(id, dto);
     * return ResponseEntity.ok(toDto(updated));
     * }
     */

    @PutMapping("/completa/{id}")
    public ResponseEntity<VentaCompletaDTO> updateCompleta(@PathVariable Integer id,
            @Valid @RequestBody UpdateVentaCompletaDTO dto) {
        VentaCompletaDTO updated = updateCompletaUC.update(id, dto);
        return ResponseEntity.ok(updated);
    }

    @GetMapping("/completa/{id}")
    public ResponseEntity<VentaCompletaDTO> getCompleta(@PathVariable Integer id) {
        VentaCompletaDTO vc = getCompletaUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Venta completa no encontrada"));
        return ResponseEntity.ok(vc);
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activate(@PathVariable Integer id) {
        reactivateUC.activate(id);
        return ResponseEntity.ok("Venta reactivada correctamente");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Venta eliminada correctamente (borrado lógico)");
    }

    private VentaCompletaDTO toDto(Venta v) {

        boolean estaFacturada = facturaRepository.existsByVentaId(v.getVentaId());

        // 1) Mapear cada entidad DetalleVenta a su DTO
        List<DetalleVentaDTO> detalles = v.getDetalles().stream()
                .map(d -> new DetalleVentaDTO(
                        d.getProducto().getProductoId(), // Integer: productoId
                        d.getProducto().getNombre(), // String: productoNombre
                        d.getCantidad(), // Integer: cantidad
                        d.getPrecioUnitario(), // BigDecimal: precioUnitario
                        d.getSubtotal() // BigDecimal: subtotal
                ))
                .toList();

        // 2) Invocar el constructor con la lista de detalles al final
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
                estaFacturada,
                detalles);
    }
}
