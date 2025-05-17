package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.detalleventa.CreateDetalleVentaDTO;
import com.proyecto.erpventas.application.dto.request.detalleventa.UpdateDetalleVentaDTO;
import com.proyecto.erpventas.application.dto.response.detalleventa.DetalleVentaResponseDTO;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/sale-details")
public class DetalleVentaController {

    private final CreateDetalleVentaUseCase createUC;
    private final ListDetallesVentaUseCase listUC;
    private final GetDetalleVentaByIdUseCase getByIdUC;
    private final UpdateDetalleVentaUseCase updateUC;
    private final DeleteDetalleVentaUseCase deleteUC;

    public DetalleVentaController(CreateDetalleVentaUseCase createUC,
                                  ListDetallesVentaUseCase listUC,
                                  GetDetalleVentaByIdUseCase getByIdUC,
                                  UpdateDetalleVentaUseCase updateUC,
                                  DeleteDetalleVentaUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<DetalleVentaResponseDTO>> getAll(@RequestParam(value = "ventaId", required = false) Integer ventaId) {
        List<DetalleVenta> detalles = (ventaId == null) ? listUC.listAll() : listUC.listByVenta(ventaId);
        List<DetalleVentaResponseDTO> response = detalles.stream().map(d -> new DetalleVentaResponseDTO(
                d.getDetalleId(),
                d.getVenta().getVentaId(),
                d.getProducto().getProductoId(),
                d.getProducto().getNombre(),
                d.getCantidad(),
                d.getPrecioUnitario(),
                d.getSubtotal(),
                d.getActivo()
        )).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetalleVentaResponseDTO> getById(@PathVariable Integer id) {
        DetalleVenta d = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Detalle de venta no encontrado o inactivo"));
        DetalleVentaResponseDTO dto = new DetalleVentaResponseDTO(
                d.getDetalleId(),
                d.getVenta().getVentaId(),
                d.getProducto().getProductoId(),
                d.getProducto().getNombre(),
                d.getCantidad(),
                d.getPrecioUnitario(),
                d.getSubtotal(),
                d.getActivo()
        );
        return ResponseEntity.ok(dto);
    }

    @PostMapping
    public ResponseEntity<DetalleVentaResponseDTO> create(@Valid @RequestBody CreateDetalleVentaDTO dto) {
        DetalleVenta created = createUC.create(dto);
        DetalleVentaResponseDTO response = new DetalleVentaResponseDTO(
                created.getDetalleId(),
                created.getVenta().getVentaId(),
                created.getProducto().getProductoId(),
                created.getProducto().getNombre(),
                created.getCantidad(),
                created.getPrecioUnitario(),
                created.getSubtotal(),
                created.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DetalleVentaResponseDTO> update(@PathVariable Integer id, @Valid @RequestBody UpdateDetalleVentaDTO dto) {
        DetalleVenta updated = updateUC.update(id, dto);
        DetalleVentaResponseDTO response = new DetalleVentaResponseDTO(
                updated.getDetalleId(),
                updated.getVenta().getVentaId(),
                updated.getProducto().getProductoId(),
                updated.getProducto().getNombre(),
                updated.getCantidad(),
                updated.getPrecioUnitario(),
                updated.getSubtotal(),
                updated.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Detalle de venta eliminado correctamente (borrado lógico)");
    }
}
