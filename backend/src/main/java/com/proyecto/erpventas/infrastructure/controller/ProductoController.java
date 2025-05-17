package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.producto.CreateProductoDTO;
import com.proyecto.erpventas.application.dto.request.producto.UpdateProductoDTO;
import com.proyecto.erpventas.application.dto.response.producto.ProductoResponseDTO;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductoController {

    private final CreateProductoUseCase createUC;
    private final ListProductosUseCase listUC;
    private final GetProductoByIdUseCase getByIdUC;
    private final UpdateProductoUseCase updateUC;
    private final DeleteProductoUseCase deleteUC;

    public ProductoController(CreateProductoUseCase createUC,
                              ListProductosUseCase listUC,
                              GetProductoByIdUseCase getByIdUC,
                              UpdateProductoUseCase updateUC,
                              DeleteProductoUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<ProductoResponseDTO>> getAll() {
        List<Producto> productos = listUC.listAll();
        List<ProductoResponseDTO> response = productos.stream().map(p -> new ProductoResponseDTO(
                p.getProductoId(),
                p.getNombre(),
                p.getDescripcion(),
                p.getPrecio(),
                p.getStock(),
                p.getActivo()
        )).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> getById(@PathVariable Integer id) {
        Producto p = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado o inactivo"));
        ProductoResponseDTO dto = new ProductoResponseDTO(
                p.getProductoId(),
                p.getNombre(),
                p.getDescripcion(),
                p.getPrecio(),
                p.getStock(),
                p.getActivo()
        );
        return ResponseEntity.ok(dto);
    }

    @PostMapping
    public ResponseEntity<ProductoResponseDTO> create(@Valid @RequestBody CreateProductoDTO dto) {
        Producto created = createUC.create(dto);
        ProductoResponseDTO response = new ProductoResponseDTO(
                created.getProductoId(),
                created.getNombre(),
                created.getDescripcion(),
                created.getPrecio(),
                created.getStock(),
                created.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> update(@PathVariable Integer id, @Valid @RequestBody UpdateProductoDTO dto) {
        Producto updated = updateUC.update(id, dto);
        ProductoResponseDTO response = new ProductoResponseDTO(
                updated.getProductoId(),
                updated.getNombre(),
                updated.getDescripcion(),
                updated.getPrecio(),
                updated.getStock(),
                updated.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Producto eliminado correctamente (borrado lógico)");
    }
}
