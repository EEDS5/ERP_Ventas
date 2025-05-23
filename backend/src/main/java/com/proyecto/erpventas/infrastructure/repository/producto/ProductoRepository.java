package com.proyecto.erpventas.infrastructure.repository.producto;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import java.util.List;
import java.util.Optional;

public interface ProductoRepository {
    boolean existsByNombre(String nombre);
    Optional<Producto> findByNombre(String nombre);
    Producto save(Producto producto);
    Producto saveAndFlush(Producto producto);
    Optional<Producto> findById(Integer id);
    List<Producto> findAll();
    List<Producto> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}