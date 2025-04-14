package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.ProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class DeleteProductoUseCase {

    private final ProductoRepository productoRepository;

    public DeleteProductoUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public void delete(Integer id) {
        Producto p = productoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
        p.setActivo(false);
        productoRepository.save(p);
    }
}
