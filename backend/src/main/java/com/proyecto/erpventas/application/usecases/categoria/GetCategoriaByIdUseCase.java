package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetCategoriaByIdUseCase {

    private final CategoriaProductoRepository categoriaRepository;

    public GetCategoriaByIdUseCase(CategoriaProductoRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public Optional<CategoriaProducto> getById(Integer id) {
        return categoriaRepository.findById(id);
    }
}
