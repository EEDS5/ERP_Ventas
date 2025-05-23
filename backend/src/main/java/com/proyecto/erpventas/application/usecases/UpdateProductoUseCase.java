package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.producto.UpdateProductoDTO;
import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;

import org.springframework.stereotype.Service;

@Service
public class UpdateProductoUseCase {

    private final ProductoRepository productoRepository;

    public UpdateProductoUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public Producto update(Integer id, UpdateProductoDTO dto) {
        Producto existing = productoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
        existing.setNombre(dto.getNombre());
        existing.setDescripcion(dto.getDescripcion());
        existing.setPrecio(dto.getPrecio());
        existing.setStock(dto.getStock());
        return productoRepository.save(existing);
    }
}