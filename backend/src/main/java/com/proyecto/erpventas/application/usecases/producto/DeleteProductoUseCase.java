package com.proyecto.erpventas.application.usecases.producto;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class DeleteProductoUseCase {

    private final ProductoRepository productoRepository;

    public DeleteProductoUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public void delete(Integer id) {
        Producto existing = productoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
        existing.setActivo(false);
        productoRepository.save(existing);
    }
}
