package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.usuario.UpdateUserDataDTO;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateUserUseCase {

    private final UserRepository userRepository;

    public UpdateUserUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Usuario updateUserData(Integer id, UpdateUserDataDTO dto) {
        Usuario existing = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
        existing.setNombreUsuario(dto.getNombreUsuario());
        existing.setEmail(dto.getEmail());
        // No se toca la contraseña
        return userRepository.save(existing);
    }
}
