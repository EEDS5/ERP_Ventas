package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.auth.LoginUserDTO;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class LoginUserUseCase {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public LoginUserUseCase(UserRepository repo, BCryptPasswordEncoder encoder) {
        this.userRepository = repo;
        this.passwordEncoder = encoder;
    }

    public Usuario login(LoginUserDTO dto) {
        Usuario usuario = userRepository
            .findByNombreUsuario(dto.getNombreUsuario())
            .orElseThrow(() -> new RuntimeException("No existe"));

        boolean passMatches = passwordEncoder.matches(dto.getPassword(), usuario.getPassword());
        if (!passMatches) {
            throw new RuntimeException("Credenciales inválidas");
        }
        return usuario;
    }
}