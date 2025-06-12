package com.proyecto.erpventas.infrastructure.repository.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import java.util.List;
import java.util.Optional;

public interface CategoriaProductoRepository {
    boolean existsByNombre(String nombre);

    /** Trae la categoría por nombre sin importar su estado */
    Optional<CategoriaProducto> findByNombre(String nombre);

    /** Trae sólo si está activa */
    Optional<CategoriaProducto> findActiveByNombre(String nombre);

    CategoriaProducto save(CategoriaProducto categoria);
    CategoriaProducto saveAndFlush(CategoriaProducto categoria);
    Optional<CategoriaProducto> findById(Integer id);
    List<CategoriaProducto> findAll();
    List<CategoriaProducto> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}
