package com.proyecto.erpventas.application.usecases.usuario;

import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ActivateUserUseCase {

    private final UserRepository userRepository;

    public ActivateUserUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Transactional
    public Usuario activate(Integer id) {
        Usuario user = userRepository.findByIdIncludeInactive(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
        user.setActivo(true);
        return userRepository.save(user);
    }
}
