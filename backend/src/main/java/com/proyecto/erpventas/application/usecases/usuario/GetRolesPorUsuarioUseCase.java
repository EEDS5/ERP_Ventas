package com.proyecto.erpventas.application.usecases.usuario;

import com.proyecto.erpventas.domain.model.auth.Role;
import com.proyecto.erpventas.infrastructure.repository.auth.RoleRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GetRolesPorUsuarioUseCase {

    private final RoleRepository roleRepository;

    public GetRolesPorUsuarioUseCase(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public List<Role> obtenerRoles(Integer usuarioId) {
        return roleRepository.findByUsuarioId(usuarioId);
    }
}
