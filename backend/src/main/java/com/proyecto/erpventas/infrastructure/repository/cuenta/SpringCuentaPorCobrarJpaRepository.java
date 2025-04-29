package com.proyecto.erpventas.infrastructure.repository.cuenta;

import com.proyecto.erpventas.domain.model.sales.CuentaPorCobrar;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SpringCuentaPorCobrarJpaRepository extends JpaRepository<CuentaPorCobrar, Long> {
    List<CuentaPorCobrar> findAllByActivoTrue();
}