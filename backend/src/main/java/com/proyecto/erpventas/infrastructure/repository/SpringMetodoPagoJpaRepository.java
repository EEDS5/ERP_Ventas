package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SpringMetodoPagoJpaRepository extends JpaRepository<MetodoPago, Long> {
    boolean existsByNombre(String nombre);
    Optional<MetodoPago> findByNombre(String nombre);
    List<MetodoPago> findAllByActivoTrueOrderByNombreAsc();
}
