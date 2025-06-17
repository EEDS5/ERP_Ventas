package com.proyecto.erpventas.infrastructure.repository.auth;

import com.proyecto.erpventas.domain.model.auth.UsuarioRol;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SpringUsuarioRolJpaRepository extends JpaRepository<UsuarioRol, Long> {
    List<UsuarioRol> findAllByUsuario_UsuarioIDAndActivoTrue(Integer usuarioId);
}
