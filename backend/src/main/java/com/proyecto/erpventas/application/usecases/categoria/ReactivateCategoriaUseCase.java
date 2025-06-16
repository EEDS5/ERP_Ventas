package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Servicio de negocio para reactivar (restaurar) una categoría inactiva.
 */
@Service
public class ReactivateCategoriaUseCase {

    private final CategoriaProductoRepository repo;

    public ReactivateCategoriaUseCase(CategoriaProductoRepository repo) {
        this.repo = repo;
    }

    /**
     * Reactiva la categoría con el ID dado, marcando su campo 'activo' = true.
     *
     * @param id Identificador de la categoría a reactivar.
     * @return La entidad CategoriaProducto ya restaurada.
     */
    @Transactional
    public CategoriaProducto reactivate(Integer id) {
        CategoriaProducto categoria = repo.findById(id)
            .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));
        categoria.setActivo(true);
        return repo.save(categoria);
    }
}
