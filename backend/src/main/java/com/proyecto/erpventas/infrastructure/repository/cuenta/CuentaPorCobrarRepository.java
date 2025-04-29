package com.proyecto.erpventas.infrastructure.repository.cuenta;

import com.proyecto.erpventas.domain.model.sales.CuentaPorCobrar;

import java.util.List;
import java.util.Optional;

public interface CuentaPorCobrarRepository {

    List<CuentaPorCobrar> findAll();

    Optional<CuentaPorCobrar> findById(Integer id);

    CuentaPorCobrar save(CuentaPorCobrar cuenta);

    void softDeleteById(Integer id);
}