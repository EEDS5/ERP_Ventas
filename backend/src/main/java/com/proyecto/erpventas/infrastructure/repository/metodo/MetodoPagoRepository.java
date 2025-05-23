package com.proyecto.erpventas.infrastructure.repository.metodo;

import java.util.List;
import java.util.Optional;

import com.proyecto.erpventas.domain.model.inventory.MetodoPago;

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