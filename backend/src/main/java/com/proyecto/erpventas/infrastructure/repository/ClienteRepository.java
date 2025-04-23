package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.people.Cliente;
import java.util.List;
import java.util.Optional;

public interface ClienteRepository {
    Optional<Cliente> findByCorreo(String correo);
    boolean existsByCorreo(String correo);
    Cliente save(Cliente cliente);
    Cliente saveAndFlush(Cliente cliente);
    Optional<Cliente> findById(Integer id);
    List<Cliente> findAll();
    List<Cliente> findAllByActivoTrue();
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}