package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.RegisterUserDTO;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class RegisterUserUseCase {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public RegisterUserUseCase(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Usuario register(RegisterUserDTO dto) {
        // Verificar si ya existe el nombre de usuario o email
        if (userRepository.existsByNombreUsuario(dto.getNombreUsuario())) {
            throw new RuntimeException("El nombre de usuario ya está en uso.");
        }

        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("El email ya está en uso.");
        }

        // Crear usuario y encriptar la contraseña
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombreUsuario(dto.getNombreUsuario());
        nuevoUsuario.setEmail(dto.getEmail());
        nuevoUsuario.setPassword(passwordEncoder.encode(dto.getPassword()));

        return userRepository.save(nuevoUsuario);
    }
}