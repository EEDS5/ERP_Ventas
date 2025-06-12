package com.proyecto.erpventas.application.usecases.producto;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import com.proyecto.erpventas.infrastructure.repository.producto.ProductoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListProductosUseCase {

    private final ProductoRepository productoRepository;

    public ListProductosUseCase(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public List<Producto> listAll() {
        return productoRepository.findAllByActivoTrue();
    }
}
