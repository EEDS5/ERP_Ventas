package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.Usuario;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class UserRepositoryImpl implements UserRepository {

    private final SpringUserJpaRepository jpaRepository;

    public UserRepositoryImpl(SpringUserJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public Optional<Usuario> findByNombreUsuario(String nombreUsuario) {
        return jpaRepository.findByNombreUsuario(nombreUsuario);
    }

    @Override
    public boolean existsByNombreUsuario(String nombreUsuario) {
        return jpaRepository.existsByNombreUsuario(nombreUsuario);
    }

    @Override
    public boolean existsByEmail(String email) {
        return jpaRepository.existsByEmail(email);
    }

    @Override
    public Usuario save(Usuario usuario) {
        return jpaRepository.save(usuario);
    }

    @Override
    public Usuario saveAndFlush(Usuario usuario) {
        return jpaRepository.saveAndFlush(usuario);
    }

    // Métodos nuevos para CRUD
    @Override
    public Optional<Usuario> findById(Integer id) {
        return jpaRepository.findById(id.longValue());
    }

    @Override
    public List<Usuario> findAll() {
        return jpaRepository.findAll();
    }

    @Override
    public void deleteById(Integer id) {
        jpaRepository.deleteById(id.longValue());
    }
}
