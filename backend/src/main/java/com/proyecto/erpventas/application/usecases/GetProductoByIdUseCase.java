package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetProductoByIdUseCase {

    private final ProductoRepository productoRepository;

    public GetProductoByIdUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public Optional<Producto> getById(Integer id) {
        return productoRepository.findById(id);
    }
}