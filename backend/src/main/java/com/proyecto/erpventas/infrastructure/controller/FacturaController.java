package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.CreateFacturaDTO;
import com.proyecto.erpventas.application.dto.request.UpdateFacturaDTO;
import com.proyecto.erpventas.application.dto.response.FacturaResponseDTO;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.sales.Factura;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/invoices")
public class FacturaController {

    private final CreateFacturaUseCase createUC;
    private final ListFacturasUseCase listUC;
    private final GetFacturaByIdUseCase getByIdUC;
    private final UpdateFacturaUseCase updateUC;
    private final DeleteFacturaUseCase deleteUC;

    public FacturaController(CreateFacturaUseCase createUC,
                             ListFacturasUseCase listUC,
                             GetFacturaByIdUseCase getByIdUC,
                             UpdateFacturaUseCase updateUC,
                             DeleteFacturaUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<FacturaResponseDTO>> getAll() {
        List<Factura> facturas = listUC.listAll();
        List<FacturaResponseDTO> response = facturas.stream().map(f -> new FacturaResponseDTO(
                f.getFacturaId(),
                f.getVenta().getVentaId(),
                f.getNumeroFactura(),
                f.getFechaEmision(),
                f.getXmlFactura(),
                f.getCreadoPorUsuario().getUsuarioID(),
                f.getCreadoPorUsuario().getNombreUsuario(),
                f.getActivo()
        )).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<FacturaResponseDTO> getById(@PathVariable Integer id) {
        Factura f = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada o inactiva"));
        FacturaResponseDTO dto = new FacturaResponseDTO(
                f.getFacturaId(),
                f.getVenta().getVentaId(),
                f.getNumeroFactura(),
                f.getFechaEmision(),
                f.getXmlFactura(),
                f.getCreadoPorUsuario().getUsuarioID(),
                f.getCreadoPorUsuario().getNombreUsuario(),
                f.getActivo()
        );
        return ResponseEntity.ok(dto);
    }

    @PostMapping
    public ResponseEntity<FacturaResponseDTO> create(@Valid @RequestBody CreateFacturaDTO dto) {
        Factura created = createUC.create(dto);
        FacturaResponseDTO response = new FacturaResponseDTO(
                created.getFacturaId(),
                created.getVenta().getVentaId(),
                created.getNumeroFactura(),
                created.getFechaEmision(),
                created.getXmlFactura(),
                created.getCreadoPorUsuario().getUsuarioID(),
                created.getCreadoPorUsuario().getNombreUsuario(),
                created.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<FacturaResponseDTO> update(@PathVariable Integer id, @Valid @RequestBody UpdateFacturaDTO dto) {
        Factura updated = updateUC.update(id, dto);
        FacturaResponseDTO response = new FacturaResponseDTO(
                updated.getFacturaId(),
                updated.getVenta().getVentaId(),
                updated.getNumeroFactura(),
                updated.getFechaEmision(),
                updated.getXmlFactura(),
                updated.getCreadoPorUsuario().getUsuarioID(),
                updated.getCreadoPorUsuario().getNombreUsuario(),
                updated.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Factura eliminada correctamente (borrado lógico)");
    }
}
