package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.metodopago.CreateMetodoPagoDTO;
import com.proyecto.erpventas.application.dto.request.metodopago.UpdateMetodoPagoDTO;
import com.proyecto.erpventas.application.dto.response.metodopago.MetodoPagoResponseDTO;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/payment-methods")
public class MetodoPagoController {

    private final CreateMetodoPagoUseCase createUC;
    private final ListMetodosPagoUseCase listUC;
    private final GetMetodoPagoByIdUseCase getByIdUC;
    private final UpdateMetodoPagoUseCase updateUC;
    private final DeleteMetodoPagoUseCase deleteUC;

    public MetodoPagoController(CreateMetodoPagoUseCase createUC,
                                ListMetodosPagoUseCase listUC,
                                GetMetodoPagoByIdUseCase getByIdUC,
                                UpdateMetodoPagoUseCase updateUC,
                                DeleteMetodoPagoUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<MetodoPagoResponseDTO>> getAll() {
        List<MetodoPago> metodos = listUC.listAll();
        List<MetodoPagoResponseDTO> response = metodos.stream().map(m -> new MetodoPagoResponseDTO(
                m.getMetodoPagoId(),
                m.getNombre(),
                m.getActivo()
        )).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<MetodoPagoResponseDTO> getById(@PathVariable Integer id) {
        MetodoPago m = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado o inactivo"));
        MetodoPagoResponseDTO dto = new MetodoPagoResponseDTO(
                m.getMetodoPagoId(),
                m.getNombre(),
                m.getActivo()
        );
        return ResponseEntity.ok(dto);
    }

    @PostMapping
    public ResponseEntity<MetodoPagoResponseDTO> create(@Valid @RequestBody CreateMetodoPagoDTO dto) {
        MetodoPago created = createUC.create(dto);
        MetodoPagoResponseDTO response = new MetodoPagoResponseDTO(
                created.getMetodoPagoId(),
                created.getNombre(),
                created.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MetodoPagoResponseDTO> update(@PathVariable Integer id, @Valid @RequestBody UpdateMetodoPagoDTO dto) {
        MetodoPago updated = updateUC.update(id, dto);
        MetodoPagoResponseDTO response = new MetodoPagoResponseDTO(
                updated.getMetodoPagoId(),
                updated.getNombre(),
                updated.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Método de pago eliminado correctamente (borrado lógico)");
    }
}
