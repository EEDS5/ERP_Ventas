package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.producto.CreateProductoDTO;
import com.proyecto.erpventas.application.dto.request.producto.UpdateProductoDTO;
import com.proyecto.erpventas.application.dto.response.producto.ProductoResponseDTO;
import com.proyecto.erpventas.application.usecases.producto.*;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/productos")
public class ProductoController {

    private final CreateProductoUseCase createUC;
    private final ListProductosUseCase listUC;
    private final GetProductoByIdUseCase getByIdUC;
    private final UpdateProductoUseCase updateUC;
    private final DeleteProductoUseCase deleteUC;
    private final ActivateProductoUseCase activateUC;

    public ProductoController(CreateProductoUseCase createUC,
            ListProductosUseCase listUC,
            GetProductoByIdUseCase getByIdUC,
            UpdateProductoUseCase updateUC,
            DeleteProductoUseCase deleteUC,
            ActivateProductoUseCase activateUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
        this.activateUC = activateUC;
    }

    @GetMapping
    public ResponseEntity<List<ProductoResponseDTO>> getAll() {
        List<Producto> productos = listUC.listAll();
        List<ProductoResponseDTO> dto = productos.stream()
                .map(this::toDto)
                .toList();
        return ResponseEntity.ok(dto);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> getById(@PathVariable Integer id) {
        Producto p = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
        return ResponseEntity.ok(toDto(p));
    }

    @PostMapping
    public ResponseEntity<ProductoResponseDTO> create(@Valid @RequestBody CreateProductoDTO dto) {
        Producto created = createUC.create(dto);
        return ResponseEntity.ok(toDto(created));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> update(@PathVariable Integer id,
            @Valid @RequestBody UpdateProductoDTO dto) {
        Producto updated = updateUC.update(id, dto);
        return ResponseEntity.ok(toDto(updated));
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activar(@PathVariable Integer id) {
        activateUC.activar(id);
        return ResponseEntity.ok("Producto activado correctamente");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Producto eliminado correctamente (borrado lógico)");
    }

    private ProductoResponseDTO toDto(Producto p) {
        return new ProductoResponseDTO(
                p.getProductoId(),
                p.getNombre(),
                p.getDescripcion(),
                p.getPrecio(),
                p.getStock(),
                p.getCategoria().getCategoriaId(),
                p.getCategoria().getNombre(),
                p.getActivo());
    }
}
