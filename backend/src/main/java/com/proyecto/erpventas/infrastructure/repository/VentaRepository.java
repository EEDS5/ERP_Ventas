package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.Venta;
import java.util.List;
import java.util.Optional;

public interface VentaRepository {
    Venta save(Venta venta);
    Venta saveAndFlush(Venta venta);
    Optional<Venta> findById(Integer id);
    List<Venta> findAll();
    List<Venta> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}