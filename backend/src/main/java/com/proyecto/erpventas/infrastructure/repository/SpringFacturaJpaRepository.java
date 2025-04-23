package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.Factura;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SpringFacturaJpaRepository extends JpaRepository<Factura, Long> {
    boolean existsByNumeroFactura(String numeroFactura);
    Optional<Factura> findByNumeroFactura(String numeroFactura);
    List<Factura> findAllByActivoTrueOrderByFechaEmisionDesc();
}
