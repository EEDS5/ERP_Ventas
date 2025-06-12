package com.proyecto.erpventas.infrastructure.repository.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;

import java.util.List;
import java.util.Optional;

public interface CategoriaProductoRepository {
    boolean existsByNombre(String nombre);
    Optional<CategoriaProducto> findByNombre(String nombre);
    CategoriaProducto save(CategoriaProducto categoria);
    CategoriaProducto saveAndFlush(CategoriaProducto categoria);
    Optional<CategoriaProducto> findById(Integer id);
    List<CategoriaProducto> findAll();
    List<CategoriaProducto> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}
