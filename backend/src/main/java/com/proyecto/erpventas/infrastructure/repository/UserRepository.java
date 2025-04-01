package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.Usuario;
import java.util.List;
import java.util.Optional;

public interface UserRepository {
    Optional<Usuario> findByNombreUsuario(String nombreUsuario);
    boolean existsByNombreUsuario(String nombreUsuario);
    boolean existsByEmail(String email);
    
    Usuario save(Usuario usuario);
    Usuario saveAndFlush(Usuario usuario);
    
    // Métodos CRUD para usuarios activos (borrado lógico)
    Optional<Usuario> findById(Integer id);
    List<Usuario> findAll();
    List<Usuario> findAllByActivoTrue();
    void deleteById(Integer id);    // ahora invoca borrado lógico
    void softDeleteById(Integer id);
}
