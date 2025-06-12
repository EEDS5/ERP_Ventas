package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.categoria.CreateCategoriaDTO;
import com.proyecto.erpventas.application.dto.request.categoria.UpdateCategoriaDTO;
import com.proyecto.erpventas.application.dto.response.categoria.CategoriaResponseDTO;
import com.proyecto.erpventas.application.usecases.categoria.*;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/categorias-producto")
public class CategoriaProductoController {

    private final CreateCategoriaUseCase createUC;
    private final ListCategoriasUseCase listUC;
    private final GetCategoriaByIdUseCase getByIdUC;
    private final UpdateCategoriaUseCase updateUC;
    private final DeleteCategoriaUseCase deleteUC;

    public CategoriaProductoController(CreateCategoriaUseCase createUC,
                                       ListCategoriasUseCase listUC,
                                       GetCategoriaByIdUseCase getByIdUC,
                                       UpdateCategoriaUseCase updateUC,
                                       DeleteCategoriaUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<CategoriaResponseDTO>> getAll() {
        List<CategoriaProducto> categorias = listUC.listAll();
        List<CategoriaResponseDTO> dto = categorias.stream()
                .map(c -> new CategoriaResponseDTO(
                        c.getCategoriaId(),
                        c.getNombre(),
                        c.getDescripcion(),
                        c.getActivo()
                )).toList();
        return ResponseEntity.ok(dto);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CategoriaResponseDTO> getById(@PathVariable Integer id) {
        CategoriaProducto c = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        CategoriaResponseDTO dto = new CategoriaResponseDTO(
                c.getCategoriaId(), c.getNombre(), c.getDescripcion(), c.getActivo());
        return ResponseEntity.ok(dto);
    }

    @PostMapping
    public ResponseEntity<CategoriaResponseDTO> create(@Valid @RequestBody CreateCategoriaDTO dto) {
        CategoriaProducto created = createUC.create(dto);
        CategoriaResponseDTO resp = new CategoriaResponseDTO(
                created.getCategoriaId(), created.getNombre(), created.getDescripcion(), created.getActivo());
        return ResponseEntity.ok(resp);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CategoriaResponseDTO> update(@PathVariable Integer id,
                                                       @Valid @RequestBody UpdateCategoriaDTO dto) {
        CategoriaProducto updated = updateUC.update(id, dto);
        CategoriaResponseDTO resp = new CategoriaResponseDTO(
                updated.getCategoriaId(), updated.getNombre(), updated.getDescripcion(), updated.getActivo());
        return ResponseEntity.ok(resp);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Categoría eliminada correctamente (borrado lógico)");
    }
}
