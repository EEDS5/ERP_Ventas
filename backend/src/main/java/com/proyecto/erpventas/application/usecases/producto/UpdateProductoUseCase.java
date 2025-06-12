package com.proyecto.erpventas.application.usecases.producto;

import com.proyecto.erpventas.application.dto.request.producto.UpdateProductoDTO;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateProductoUseCase {

    private final ProductoRepository productoRepository;
    private final CategoriaProductoRepository categoriaRepository;

    public UpdateProductoUseCase(ProductoRepository productoRepository,
                                 CategoriaProductoRepository categoriaRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
    }

    public Producto update(Integer id, UpdateProductoDTO dto) {
        Producto existing = productoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
        CategoriaProducto categoria = categoriaRepository.findById(dto.getCategoriaId())
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        existing.setNombre(dto.getNombre());
        existing.setDescripcion(dto.getDescripcion());
        existing.setPrecio(dto.getPrecio());
        existing.setStock(dto.getStock());
        existing.setCategoria(categoria);
        return productoRepository.save(existing);
    }
}
