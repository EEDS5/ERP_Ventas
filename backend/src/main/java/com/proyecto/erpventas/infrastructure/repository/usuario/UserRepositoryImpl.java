package com.proyecto.erpventas.infrastructure.repository.usuario;

import org.springframework.stereotype.Repository;

import com.proyecto.erpventas.domain.model.people.Usuario;

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
        return jpaRepository.findByNombreUsuario(nombreUsuario)
                .filter(Usuario::getActivo);
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

    @Override
    public Optional<Usuario> findById(Integer id) {
        return jpaRepository.findById(id.longValue())
                .filter(Usuario::getActivo);
    }

    @Override
    public Optional<Usuario> findByIdIncludeInactive(Integer id) {
        return jpaRepository.findById(id.longValue());
    }

    @Override
    public List<Usuario> findAll() {
        /* return jpaRepository.findAllByActivoTrueOrderByFechaRegistroAsc(); */
        return jpaRepository.findAll();
    }

    @Override
    public List<Usuario> findAllByActivoTrue() {
        // Se puede reutilizar findAll() ya que filtra usuarios activos.
        return jpaRepository.findAllByActivoTrueOrderByFechaRegistroAsc();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<Usuario> optUser = jpaRepository.findById(id.longValue());
        if (optUser.isPresent()) {
            Usuario user = optUser.get();
            user.setActivo(false); // Borrado lógico: marcamos como inactivo
            jpaRepository.save(user);
        } else {
            throw new RuntimeException("Usuario no encontrado");
        }
    }

    @Override
    public void deleteById(Integer id) {
        // En lugar de eliminar físicamente, se realiza el borrado lógico
        softDeleteById(id);
    }
}
