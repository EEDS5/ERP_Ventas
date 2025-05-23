package com.proyecto.erpventas.infrastructure.repository.producto;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SpringProductoJpaRepository extends JpaRepository<Producto, Long> {
    boolean existsByNombre(String nombre);
    Optional<Producto> findByNombre(String nombre);
    List<Producto> findAllByActivoTrueOrderByNombreAsc();
}