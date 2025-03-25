package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class DeleteUserUseCase {

    private final UserRepository userRepository;

    public DeleteUserUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void delete(Integer id) {
        if (!userRepository.findById(id).isPresent()) {
            throw new RuntimeException("Usuario no encontrado");
        }
        userRepository.deleteById(id);
    }
}
