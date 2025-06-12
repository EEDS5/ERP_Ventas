package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.application.dto.request.categoria.UpdateCategoriaDTO;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateCategoriaUseCase {

    private final CategoriaProductoRepository categoriaRepository;

    public UpdateCategoriaUseCase(CategoriaProductoRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public CategoriaProducto update(Integer id, UpdateCategoriaDTO dto) {
        CategoriaProducto existing = categoriaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        existing.setNombre(dto.getNombre());
        existing.setDescripcion(dto.getDescripcion());
        return categoriaRepository.save(existing);
    }
}
