package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.Factura;
import java.util.List;
import java.util.Optional;

public interface FacturaRepository {
    boolean existsByNumeroFactura(String numeroFactura);
    Optional<Factura> findByNumeroFactura(String numeroFactura);
    Factura save(Factura factura);
    Factura saveAndFlush(Factura factura);
    Optional<Factura> findById(Integer id);
    List<Factura> findAll();
    List<Factura> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}