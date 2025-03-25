package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.UpdateUserDTO;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateUserUseCase {

    private final UserRepository userRepository;

    public UpdateUserUseCase(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Usuario updateUser(Integer id, UpdateUserDTO dto) {
        Usuario usuario = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado con ID: " + id));

        // Actualizamos los campos que consideremos necesarios:
        usuario.setNombreUsuario(dto.getNombreUsuario());
        usuario.setEmail(dto.getEmail());
        // Podrías (o no) permitir actualizar la contraseña:
        usuario.setPassword(dto.getPassword());

        // Guardar cambios
        return userRepository.save(usuario);
    }
}
