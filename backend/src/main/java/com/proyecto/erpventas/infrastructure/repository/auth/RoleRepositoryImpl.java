package com.proyecto.erpventas.infrastructure.repository.auth;

import com.proyecto.erpventas.domain.model.auth.Role;
import com.proyecto.erpventas.domain.model.auth.UsuarioRol;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class RoleRepositoryImpl implements RoleRepository {

    private final SpringRoleJpaRepository roleJpaRepository;
    private final SpringUsuarioRolJpaRepository usuarioRolJpaRepository;

    public RoleRepositoryImpl(SpringRoleJpaRepository roleJpaRepository,
                              SpringUsuarioRolJpaRepository usuarioRolJpaRepository) {
        this.roleJpaRepository = roleJpaRepository;
        this.usuarioRolJpaRepository = usuarioRolJpaRepository;
    }

    @Override
    public Optional<Role> findById(Integer id) {
        return roleJpaRepository.findById(id.longValue());
    }

    @Override
    public List<Role> findAll() {
        return roleJpaRepository.findAll();
    }

    @Override
    public Role save(Role role) {
        return roleJpaRepository.save(role);
    }

    @Override
    public Role saveAndFlush(Role role) {
        return roleJpaRepository.saveAndFlush(role);
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<Role> opt = roleJpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            Role r = opt.get();
            r.setActivo(false);
            roleJpaRepository.save(r);
        } else {
            throw new RuntimeException("Rol no encontrado");
        }
    }

    @Override
    public List<Role> findByUsuarioId(Integer usuarioId) {
        List<UsuarioRol> asignaciones = usuarioRolJpaRepository
                .findAllByUsuario_UsuarioIDAndActivoTrue(usuarioId);
        return asignaciones.stream()
                .map(UsuarioRol::getRole)
                .filter(Role::getActivo)
                .toList();
    }
}
