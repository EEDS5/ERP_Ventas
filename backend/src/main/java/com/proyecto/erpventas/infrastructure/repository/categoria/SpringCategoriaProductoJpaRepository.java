package com.proyecto.erpventas.infrastructure.repository.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SpringCategoriaProductoJpaRepository extends JpaRepository<CategoriaProducto, Long> {
    boolean existsByNombre(String nombre);
    Optional<CategoriaProducto> findByNombre(String nombre);
    List<CategoriaProducto> findAllByActivoTrueOrderByNombreAsc();
}
