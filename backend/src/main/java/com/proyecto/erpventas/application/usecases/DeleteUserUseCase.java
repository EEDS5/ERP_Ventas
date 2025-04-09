package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;

import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class DeleteUserUseCase {

    private final UserRepository userRepository;

    public DeleteUserUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void delete(Integer id) {
        Optional<Usuario> optionalUser = userRepository.findById(id);
        if (!optionalUser.isPresent()) {
            throw new RuntimeException("No existe usuario con ID: " + id);
        }
        Usuario user = optionalUser.get();
        user.setActivo(false);
        userRepository.save(user);
    }
}
