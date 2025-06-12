package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;

@Service
public class DeleteCategoriaUseCase {

    private final CategoriaProductoRepository categoriaRepository;

    public DeleteCategoriaUseCase(CategoriaProductoRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public void delete(Integer id) {
        CategoriaProducto existing = categoriaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        existing.setActivo(false);
        categoriaRepository.save(existing);
    }
}
