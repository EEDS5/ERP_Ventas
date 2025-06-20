package com.proyecto.erpventas.application.usecases.usuario;

import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListUsersUseCase {

    private final UserRepository userRepository;

    public ListUsersUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<Usuario> listAll() {
        /* return userRepository.findAllByActivoTrue(); */
        return userRepository.findAll();
    }
    
}
