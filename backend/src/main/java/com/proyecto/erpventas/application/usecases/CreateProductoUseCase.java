package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.producto.CreateProductoDTO;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;

import org.springframework.stereotype.Service;

@Service
public class CreateProductoUseCase {

    private final ProductoRepository productoRepository;

    public CreateProductoUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public Producto create(CreateProductoDTO dto) {
        if (productoRepository.existsByNombre(dto.getNombre())) {
            throw new RuntimeException("Ya existe un producto con ese nombre");
        }
        Producto p = new Producto();
        p.setNombre(dto.getNombre());
        p.setDescripcion(dto.getDescripcion());
        p.setPrecio(dto.getPrecio());
        p.setStock(dto.getStock());
        return productoRepository.save(p);
    }
}
