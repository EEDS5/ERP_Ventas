package com.proyecto.erpventas.infrastructure.repository.cliente;

import com.proyecto.erpventas.domain.model.people.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface SpringClienteJpaRepository extends JpaRepository<Cliente, Long> {
    Optional<Cliente> findByCorreo(String correo);
    boolean existsByCorreo(String correo);
    List<Cliente> findAllByActivoTrueOrderByFechaRegistroAsc();
}