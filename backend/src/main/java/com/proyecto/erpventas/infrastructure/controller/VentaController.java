package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.venta.CreateVentaDTO;
import com.proyecto.erpventas.application.dto.request.venta.UpdateVentaDTO;
import com.proyecto.erpventas.application.dto.response.venta.VentaResponseDTO;
import com.proyecto.erpventas.application.usecases.venta.*;
import com.proyecto.erpventas.domain.model.sales.Venta;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/ventas")
public class VentaController {

    private final CreateVentaUseCase createUC;
    private final ListVentasUseCase listUC;
    private final GetVentaByIdUseCase getByIdUC;
    private final UpdateVentaUseCase updateUC;
    private final DeleteVentaUseCase deleteUC;

    public VentaController(CreateVentaUseCase createUC,
                           ListVentasUseCase listUC,
                           GetVentaByIdUseCase getByIdUC,
                           UpdateVentaUseCase updateUC,
                           DeleteVentaUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<VentaResponseDTO>> getAll() {
        List<Venta> ventas = listUC.listAll();
        List<VentaResponseDTO> response = ventas.stream().map(this::toDto).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<VentaResponseDTO> getById(@PathVariable Integer id) {
        Venta venta = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        return ResponseEntity.ok(toDto(venta));
    }

    @PostMapping
    public ResponseEntity<VentaResponseDTO> create(@Valid @RequestBody CreateVentaDTO dto) {
        Venta created = createUC.create(dto);
        return ResponseEntity.ok(toDto(created));
    }

    @PutMapping("/{id}")
    public ResponseEntity<VentaResponseDTO> update(@PathVariable Integer id,
                                                   @Valid @RequestBody UpdateVentaDTO dto) {
        Venta updated = updateUC.update(id, dto);
        return ResponseEntity.ok(toDto(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Venta eliminada correctamente (borrado lógico)");
    }

    private VentaResponseDTO toDto(Venta v) {
        return new VentaResponseDTO(
                v.getVentaId(),
                v.getCliente().getClienteId(),
                v.getCliente().getNombre(),
                v.getFechaVenta(),
                v.getTotal(),
                v.getMetodoPago().getMetodoPagoId(),
                v.getMetodoPago().getNombre(),
                v.getCreadoPorUsuario().getUsuarioID(),
                v.getCreadoPorUsuario().getNombreUsuario(),
                v.getActivo()
        );
    }
}
