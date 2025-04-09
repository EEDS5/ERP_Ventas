package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.UpdateUserDataDTO;
import com.proyecto.erpventas.application.dto.request.UpdateUserPasswordDTO;
import com.proyecto.erpventas.application.dto.response.UsuarioResponseDTO;
import com.proyecto.erpventas.application.usecases.DeleteUserUseCase;
import com.proyecto.erpventas.application.usecases.GetUserByIdUseCase;
import com.proyecto.erpventas.application.usecases.ListUsersUseCase;
import com.proyecto.erpventas.application.usecases.UpdateUserPasswordUseCase;
import com.proyecto.erpventas.application.usecases.UpdateUserUseCase;
import com.proyecto.erpventas.domain.model.people.Usuario;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final ListUsersUseCase listUsersUC;
    private final GetUserByIdUseCase getUserByIdUC;
    private final UpdateUserUseCase updateUserUC;
    private final DeleteUserUseCase deleteUserUC;

    @Autowired
    public UserController(ListUsersUseCase listUsersUC, GetUserByIdUseCase getUserByIdUC,
            UpdateUserUseCase updateUserUC, DeleteUserUseCase deleteUserUC) {
        this.listUsersUC = listUsersUC;
        this.getUserByIdUC = getUserByIdUC;
        this.updateUserUC = updateUserUC;
        this.deleteUserUC = deleteUserUC;
    }

    @Autowired
    private UpdateUserPasswordUseCase updateUserPasswordUseCase;

    @GetMapping
    public ResponseEntity<List<UsuarioResponseDTO>> getAllUsers() {
        List<Usuario> users = listUsersUC.listAll();
        List<UsuarioResponseDTO> response = users.stream().map(u -> new UsuarioResponseDTO(
                u.getUsuarioID(),
                u.getNombreUsuario(),
                u.getEmail(),
                u.getTwoFAEnabled(),
                u.getFechaRegistro(),
                u.getActivo())).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<UsuarioResponseDTO> getUserById(@PathVariable Integer id) {
        Usuario user = getUserByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado o inactivo"));
        UsuarioResponseDTO dto = new UsuarioResponseDTO(
                user.getUsuarioID(),
                user.getNombreUsuario(),
                user.getEmail(),
                user.getTwoFAEnabled(),
                user.getFechaRegistro(),
                user.getActivo());
        return ResponseEntity.ok(dto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<UsuarioResponseDTO> updateUser(
            @PathVariable Integer id,
            @Valid @RequestBody UpdateUserDataDTO dto) {
        Usuario updatedUser = updateUserUC.updateUserData(id, dto);
        UsuarioResponseDTO responseDTO = new UsuarioResponseDTO(
                updatedUser.getUsuarioID(),
                updatedUser.getNombreUsuario(),
                updatedUser.getEmail(),
                updatedUser.getTwoFAEnabled(),
                updatedUser.getFechaRegistro(),
                updatedUser.getActivo());
        return ResponseEntity.ok(responseDTO);
    }

    @PutMapping("/{id}/password")
    public ResponseEntity<String> updateUserPassword(
            @PathVariable Integer id,
            @Valid @RequestBody UpdateUserPasswordDTO dto) {
        updateUserPasswordUseCase.updatePassword(id, dto);
        return ResponseEntity.ok("Contraseña actualizada correctamente");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Integer id) {
        deleteUserUC.delete(id);
        return ResponseEntity.ok("Usuario eliminado correctamente (borrado lógico)");
    }
}