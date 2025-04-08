package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.RegisterUserDTO;
import com.proyecto.erpventas.application.dto.response.UsuarioResponseDTO;
import com.proyecto.erpventas.application.usecases.RegisterUserUseCase;
import com.proyecto.erpventas.domain.model.Usuario;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class AuthController {

    private final RegisterUserUseCase registerUserUseCase;

    @Autowired
    public AuthController(RegisterUserUseCase registerUserUseCase) {
        this.registerUserUseCase = registerUserUseCase;
    }

    @Operation(summary = "Registrar un nuevo usuario", description = "Crea un usuario en el sistema con nombre de usuario, email y contraseña encriptada.", requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(description = "Datos para crear un nuevo usuario", required = true, content = @Content(mediaType = "application/json", schema = @Schema(implementation = RegisterUserDTO.class), examples = @ExampleObject(name = "Ejemplo de registro", value = "{ \"nombreUsuario\": \"elias_test\", \"email\": \"elias@test.com\", \"password\": \"123456\" }"))))
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Usuario registrado exitosamente", content = @Content(mediaType = "application/json", schema = @Schema(implementation = UsuarioResponseDTO.class), examples = @ExampleObject(name = "Respuesta exitosa", value = "{ \"usuarioID\": 1, \"nombreUsuario\": \"elias_test\", \"email\": \"elias@test.com\", \"twoFAEnabled\": false, \"fechaRegistro\": \"2025-04-08T16:43:37.471604\", \"activo\": true }"))),
            @ApiResponse(responseCode = "409", description = "El nombre de usuario o email ya existe"),
            @ApiResponse(responseCode = "400", description = "Error de validación o datos incorrectos")
    })
    @PostMapping("/register")
    public ResponseEntity<UsuarioResponseDTO> register(
            @Valid @org.springframework.web.bind.annotation.RequestBody RegisterUserDTO nuevoUsuario) {
        Usuario usuario = registerUserUseCase.register(nuevoUsuario);
        UsuarioResponseDTO responseDTO = new UsuarioResponseDTO(
                usuario.getUsuarioID(),
                usuario.getNombreUsuario(),
                usuario.getEmail(),
                usuario.getTwoFAEnabled(),
                usuario.getFechaRegistro(),
                usuario.getActivo());
        return ResponseEntity.ok(responseDTO);
    }
}