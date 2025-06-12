package com.proyecto.erpventas.application.usecases.producto;

import com.proyecto.erpventas.application.dto.request.producto.CreateProductoDTO;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class CreateProductoUseCase {

    private final ProductoRepository productoRepository;
    private final CategoriaProductoRepository categoriaRepository;

    public CreateProductoUseCase(ProductoRepository productoRepository,
                                 CategoriaProductoRepository categoriaRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
    }

    public Producto create(CreateProductoDTO dto) {
        if (productoRepository.existsByNombre(dto.getNombre())) {
            throw new RuntimeException("Ya existe un producto con ese nombre");
        }
        CategoriaProducto categoria = categoriaRepository.findById(dto.getCategoriaId())
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        Producto p = new Producto();
        p.setNombre(dto.getNombre());
        p.setDescripcion(dto.getDescripcion());
        p.setPrecio(dto.getPrecio());
        p.setStock(dto.getStock());
        p.setCategoria(categoria);
        return productoRepository.save(p);
    }
}
