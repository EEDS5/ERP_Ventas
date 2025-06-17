package com.proyecto.erpventas.infrastructure.repository.auth;

import com.proyecto.erpventas.domain.model.auth.UsuarioRol;

import java.util.List;
import java.util.Optional;

public interface UsuarioRolRepository {
    Optional<UsuarioRol> findById(Integer id);
    List<UsuarioRol> findAll();
    UsuarioRol save(UsuarioRol usuarioRol);
    UsuarioRol saveAndFlush(UsuarioRol usuarioRol);
    void deleteById(Integer id);
    void softDeleteById(Integer id);
    List<UsuarioRol> findAllByUsuarioId(Integer usuarioId);
}
