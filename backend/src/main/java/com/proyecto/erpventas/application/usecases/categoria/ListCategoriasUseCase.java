package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListCategoriasUseCase {

    private final CategoriaProductoRepository categoriaRepository;

    public ListCategoriasUseCase(CategoriaProductoRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public List<CategoriaProducto> listAll() {
        return categoriaRepository.findAllByActivoTrue();
    }
}
