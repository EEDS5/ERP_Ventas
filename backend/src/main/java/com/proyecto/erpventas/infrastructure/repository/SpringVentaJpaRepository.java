package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.Venta;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SpringVentaJpaRepository extends JpaRepository<Venta, Long> {
    List<Venta> findAllByActivoTrueOrderByFechaVentaDesc();
}