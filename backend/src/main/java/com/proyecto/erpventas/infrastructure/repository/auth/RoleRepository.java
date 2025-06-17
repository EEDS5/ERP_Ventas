package com.proyecto.erpventas.infrastructure.repository.auth;

import com.proyecto.erpventas.domain.model.auth.Role;

import java.util.List;
import java.util.Optional;

public interface RoleRepository {
    Optional<Role> findById(Integer id);
    List<Role> findAll();
    Role save(Role role);
    Role saveAndFlush(Role role);
    void deleteById(Integer id);
    void softDeleteById(Integer id);
    List<Role> findByUsuarioId(Integer usuarioId);
}
