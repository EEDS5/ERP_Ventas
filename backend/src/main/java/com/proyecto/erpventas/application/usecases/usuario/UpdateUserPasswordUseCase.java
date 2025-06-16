package com.proyecto.erpventas.application.usecases.usuario;

import com.proyecto.erpventas.application.dto.request.auth.UpdateUserPasswordDTO;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UpdateUserPasswordUseCase {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UpdateUserPasswordUseCase(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Usuario updatePassword(Integer userId, UpdateUserPasswordDTO dto) {
        Usuario existing = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
        
        // Verificar que la contraseña actual coincide
        if (!passwordEncoder.matches(dto.getCurrentPassword(), existing.getPassword())) {
            throw new RuntimeException("La contraseña actual no es correcta");
        }

        // Actualizar la contraseña
        existing.setPassword(passwordEncoder.encode(dto.getNewPassword()));
        return userRepository.save(existing);
    }
}