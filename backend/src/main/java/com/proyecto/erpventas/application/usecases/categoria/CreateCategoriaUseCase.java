package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.application.dto.request.categoria.CreateCategoriaDTO;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class CreateCategoriaUseCase {

    private final CategoriaProductoRepository categoriaRepository;

    public CreateCategoriaUseCase(CategoriaProductoRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public CategoriaProducto create(CreateCategoriaDTO dto) {
        if (categoriaRepository.existsByNombre(dto.getNombre())) {
            throw new RuntimeException("Ya existe una categoría con ese nombre");
        }
        CategoriaProducto cat = new CategoriaProducto();
        cat.setNombre(dto.getNombre());
        cat.setDescripcion(dto.getDescripcion());
        return categoriaRepository.save(cat);
    }
}
