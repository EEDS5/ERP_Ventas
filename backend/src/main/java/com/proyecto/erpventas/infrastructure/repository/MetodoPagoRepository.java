package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import java.util.List;
import java.util.Optional;

public interface MetodoPagoRepository {
    boolean existsByNombre(String nombre);
    Optional<MetodoPago> findByNombre(String nombre);
    MetodoPago save(MetodoPago metodoPago);
    MetodoPago saveAndFlush(MetodoPago metodoPago);
    Optional<MetodoPago> findById(Integer id);
    List<MetodoPago> findAll();
    List<MetodoPago> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}