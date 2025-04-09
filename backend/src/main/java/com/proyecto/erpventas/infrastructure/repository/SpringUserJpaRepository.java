package com.proyecto.erpventas.infrastructure.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyecto.erpventas.domain.model.people.Usuario;

import java.util.Optional;
import java.util.List;

public interface SpringUserJpaRepository extends JpaRepository<Usuario, Long> {
    // En tu SpringUserJpaRepository
    List<Usuario> findAllByActivoTrue();
    List<Usuario> findAllByActivoTrueOrderByFechaRegistroAsc();
    Optional<Usuario> findByNombreUsuario(String nombreUsuario);
    boolean existsByNombreUsuario(String nombreUsuario);
    boolean existsByEmail(String email);
}