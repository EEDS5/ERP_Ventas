package com.proyecto.erpventas.application.usecases.producto;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class ActivateProductoUseCase {

    private final ProductoRepository productoRepository;

    public ActivateProductoUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public void activar(Integer id) {
        Producto producto = productoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

        producto.setActivo(true);
        productoRepository.save(producto);
    }
}
