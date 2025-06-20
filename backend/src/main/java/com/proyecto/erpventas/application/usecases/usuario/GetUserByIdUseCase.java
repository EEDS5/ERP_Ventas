package com.proyecto.erpventas.application.usecases.usuario;

import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetUserByIdUseCase {

    private final UserRepository userRepository;

    public GetUserByIdUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Optional<Usuario> getById(Integer id) {
        return userRepository.findById(id);
    }
}
