package com.proyecto.erpventas.application.usecases.producto;

import com.proyecto.erpventas.application.dto.request.producto.CreateProductoDTO;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import org.springframework.stereotype.Service;
import java.util.Optional;

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
        // 1) ¿Ya existe un activo con ese nombre?
        if (productoRepository.findActiveByNombre(dto.getNombre()).isPresent()) {
            throw new RuntimeException("Ya existe un producto con ese nombre");
        }

        // 2) ¿Existe uno inactivo que podamos reactivar?
        Optional<Producto> inactivo = productoRepository.findByNombre(dto.getNombre())
                                                         .filter(p -> !p.getActivo());
        if (inactivo.isPresent()) {
            Producto p = inactivo.get();
            // Reactivarlo y actualizar
            p.setDescripcion(dto.getDescripcion());
            p.setPrecio(dto.getPrecio());
            p.setStock(dto.getStock());
            p.setActivo(true);
            p.setCategoria(
                categoriaRepository.findById(dto.getCategoriaId())
                    .orElseThrow(() -> new RuntimeException("Categoría no encontrada"))
            );
            return productoRepository.save(p);
        }

        // 3) No existe ninguno (ni activo ni inactivo): crear uno nuevo
        CategoriaProducto cat = categoriaRepository.findById(dto.getCategoriaId())
            .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        Producto nuevo = new Producto();
        nuevo.setNombre(dto.getNombre());
        nuevo.setDescripcion(dto.getDescripcion());
        nuevo.setPrecio(dto.getPrecio());
        nuevo.setStock(dto.getStock());
        nuevo.setCategoria(cat);
        nuevo.setActivo(true);
        return productoRepository.save(nuevo);
    }
}
