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

    // Métodos que faltan para un CRUD completo:
    Optional<Usuario> findById(Integer id);
    List<Usuario> findAll();
    void deleteById(Integer id);
}
