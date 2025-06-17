package com.proyecto.erpventas.infrastructure.repository.auth;

import com.proyecto.erpventas.domain.model.auth.UsuarioRol;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class UsuarioRolRepositoryImpl implements UsuarioRolRepository {

    private final SpringUsuarioRolJpaRepository jpaRepository;

    public UsuarioRolRepositoryImpl(SpringUsuarioRolJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public Optional<UsuarioRol> findById(Integer id) {
        return jpaRepository.findById(id.longValue());
    }

    @Override
    public List<UsuarioRol> findAll() {
        return jpaRepository.findAll();
    }

    @Override
    public UsuarioRol save(UsuarioRol usuarioRol) {
        return jpaRepository.save(usuarioRol);
    }

    @Override
    public UsuarioRol saveAndFlush(UsuarioRol usuarioRol) {
        return jpaRepository.saveAndFlush(usuarioRol);
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<UsuarioRol> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            UsuarioRol ur = opt.get();
            ur.setActivo(false);
            jpaRepository.save(ur);
        } else {
            throw new RuntimeException("Asignación de rol no encontrada");
        }
    }

    @Override
    public List<UsuarioRol> findAllByUsuarioId(Integer usuarioId) {
        return jpaRepository.findAllByUsuario_UsuarioIDAndActivoTrue(usuarioId);
    }
}
