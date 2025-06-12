package com.proyecto.erpventas.infrastructure.repository.cuenta;

import com.proyecto.erpventas.domain.model.sales.CuentaPorCobrar;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SpringCuentaPorCobrarJpaRepository extends JpaRepository<CuentaPorCobrar, Long> {
    List<CuentaPorCobrar> findAllByActivoTrue();
    Optional<CuentaPorCobrar> findByVenta_VentaId(Integer ventaId);
}