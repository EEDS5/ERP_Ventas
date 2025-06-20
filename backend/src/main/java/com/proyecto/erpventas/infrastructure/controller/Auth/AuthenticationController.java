package com.proyecto.erpventas.infrastructure.controller.Auth;

import com.proyecto.erpventas.application.dto.request.auth.LoginUserDTO;
import com.proyecto.erpventas.application.dto.request.auth.RegisterUserDTO;
import com.proyecto.erpventas.application.dto.request.auth.TwoFactorVerificationDTO;
import com.proyecto.erpventas.application.dto.response.auth.JwtResponseDTO;
import com.proyecto.erpventas.application.dto.response.auth.TwoFactorSetupResponseDTO;
import com.proyecto.erpventas.application.dto.response.usuario.UsuarioResponseDTO;
import com.proyecto.erpventas.application.usecases.auth.LoginUserUseCase;
import com.proyecto.erpventas.application.usecases.auth.RegisterUserUseCase;
import com.proyecto.erpventas.application.usecases.auth.VerifyTwoFactorUseCase;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.domain.service.AuthDomainService;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import com.proyecto.erpventas.infrastructure.security.JwtTokenProvider;
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
import org.springframework.http.MediaType;
import java.util.List;
import org.springframework.http.HttpStatus;

@RestController
@RequestMapping("/api/auth")
public class AuthenticationController {

        private final RegisterUserUseCase registerUserUseCase;
        private final LoginUserUseCase loginUserUseCase;
        private final VerifyTwoFactorUseCase verifyTwoFactorUseCase;
        private final UserRepository userRepository;
        private final JwtTokenProvider jwtTokenProvider;
        private final AuthDomainService authDomainService;

        @Autowired
        public AuthenticationController(RegisterUserUseCase registerUserUseCase,
                        LoginUserUseCase loginUserUseCase,
                        VerifyTwoFactorUseCase verifyTwoFactorUseCase,
                        UserRepository userRepository,
                        JwtTokenProvider jwtTokenProvider,
                        AuthDomainService authDomainService) {
                this.registerUserUseCase = registerUserUseCase;
                this.loginUserUseCase = loginUserUseCase;
                this.verifyTwoFactorUseCase = verifyTwoFactorUseCase;
                this.userRepository = userRepository;
                this.jwtTokenProvider = jwtTokenProvider;
                this.authDomainService = authDomainService;
        }

        @Operation(summary = "Registrar un nuevo usuario", description = "Crea un usuario en el sistema con nombre de usuario, email y contraseña encriptada.", requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(description = "Datos para crear un nuevo usuario", required = true, content = @Content(mediaType = "application/json", schema = @Schema(implementation = RegisterUserDTO.class), examples = @ExampleObject(name = "Ejemplo de registro", value = "{ \"nombreUsuario\": \"elias_test\", \"email\": \"elias@test.com\", \"password\": \"123456\" }"))))
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Usuario registrado exitosamente", content = @Content(mediaType = "application/json", schema = @Schema(implementation = UsuarioResponseDTO.class), examples = @ExampleObject(name = "Respuesta exitosa", value = "{ \"usuarioID\": 1, \"nombreUsuario\": \"elias_test\", \"email\": \"elias@test.com\", \"twoFAEnabled\": false, \"fechaRegistro\": \"2025-04-08T16:43:37.471604\", \"activo\": true }"))),
                        @ApiResponse(responseCode = "409", description = "El nombre de usuario o email ya existe"),
                        @ApiResponse(responseCode = "400", description = "Error de validación o datos incorrectos")
        })
        @PostMapping("/register")
        public ResponseEntity<JwtResponseDTO> register(@Valid @RequestBody RegisterUserDTO nuevoUsuario) {
                Usuario usuario = registerUserUseCase.register(nuevoUsuario);

                // Generar token con lista de roles
                List<String> roles = usuario.getRoles().stream()
                                .map(r -> r.getNombre())
                                .toList();
                String jwt = jwtTokenProvider.generateToken(usuario.getNombreUsuario(), roles);

                UsuarioResponseDTO responseDTO = new UsuarioResponseDTO(
                                usuario.getUsuarioID(),
                                usuario.getNombreUsuario(),
                                usuario.getEmail(),
                                usuario.getTwoFAEnabled(),
                                usuario.getFechaRegistro(),
                                usuario.getActivo());

                return ResponseEntity.ok(new JwtResponseDTO(jwt, responseDTO));
        }

        @Operation(summary = "Iniciar sesión", description = "Permite iniciar sesión, retornando '2FA_REQUIRED' si 2FA está habilitado o 'LOGIN_OK' si no lo está.")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Resultado de inicio de sesión")
        })
        @PostMapping(value = "/login", produces = MediaType.APPLICATION_JSON_VALUE)
        public ResponseEntity<JwtResponseDTO> login(@Valid @RequestBody LoginUserDTO loginDTO) {
                Usuario user = loginUserUseCase.login(loginDTO);

                if (Boolean.TRUE.equals(user.getTwoFAEnabled())) {
                        return ResponseEntity
                                        .ok(new JwtResponseDTO("2FA_REQUIRED"));
                }

                // Incluir roles en el token
                List<String> roles = user.getRoles().stream()
                                .map(r -> r.getNombre())
                                .toList();
                String jwt = jwtTokenProvider.generateToken(user.getNombreUsuario(), roles);

                UsuarioResponseDTO userDto = UsuarioResponseDTO.fromEntity(user);
                return ResponseEntity.ok(new JwtResponseDTO(jwt, userDto));
        }

        @Operation(summary = "Iniciar sesión con 2FA", description = "Verifica el código 2FA y retorna un token JWT en caso de éxito.")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Token JWT generado exitosamente"),
                        @ApiResponse(responseCode = "400", description = "Error en la verificación de 2FA")
        })
        @PostMapping("/login-2fa")
        public ResponseEntity<JwtResponseDTO> login2FA(@Valid @RequestBody TwoFactorVerificationDTO verificationDTO) {
                boolean valid = verifyTwoFactorUseCase.verify2FA(verificationDTO);
                if (!valid) {
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
                }
                Usuario user = userRepository.findByNombreUsuario(verificationDTO.getNombreUsuario())
                                .orElseThrow(() -> new RuntimeException("Usuario no existe o está inactivo"));
                // Generar token con roles
                List<String> roles = user.getRoles().stream()
                                .map(r -> r.getNombre())
                                .toList();
                String jwt = jwtTokenProvider.generateToken(user.getNombreUsuario(), roles);

                UsuarioResponseDTO userDto = UsuarioResponseDTO.fromEntity(user);
                return ResponseEntity.ok(new JwtResponseDTO(jwt, userDto));
        }

        @Operation(summary = "Verificar 2FA", description = "Verifica el código 2FA y retorna '2FA_OK' o '2FA_INVALID'.")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Resultado de la verificación de 2FA")
        })
        @PostMapping("/verify-2fa")
        public ResponseEntity<String> verify2FA(@Valid @RequestBody TwoFactorVerificationDTO verificationDTO) {
                boolean valid = verifyTwoFactorUseCase.verify2FA(verificationDTO);
                return ResponseEntity.ok(valid ? "2FA_OK" : "2FA_INVALID");
        }

        @Operation(summary = "Generar secreto 2FA", description = "Genera el secreto para configurar 2FA y retorna el secreto junto con la URL del código QR.")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Secreto 2FA generado exitosamente")
        })
        @PostMapping("/2fa-secret")
        public ResponseEntity<TwoFactorSetupResponseDTO> generate2FASecret(@RequestParam String username) {
                Usuario user = userRepository.findByNombreUsuario(username)
                                .orElseThrow(() -> new RuntimeException("Usuario no existe"));

                // ⚠️ Solo permitir si aún no tiene 2FA activado
                if (Boolean.TRUE.equals(user.getTwoFAEnabled())) {
                        return ResponseEntity.badRequest().build(); // o lanzar una excepción
                }

                TwoFactorSetupResponseDTO setupResponse = authDomainService.generate2FASetup(username);
                return ResponseEntity.ok(setupResponse);
        }

        @Operation(summary = "Actualizar 2FA (prueba)", description = "Actualiza directamente el estado de 2FA para el usuario (prueba).")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "2FA actualizado correctamente")
        })
        @PostMapping("/test-update-2fa")
        public ResponseEntity<String> testUpdate2FA(@RequestParam String nombreUsuario) {
                Usuario user = userRepository.findByNombreUsuario(nombreUsuario)
                                .orElseThrow(() -> new RuntimeException("Usuario no existe o está inactivo"));
                user.setTwoFAEnabled(true);
                userRepository.save(user);
                return ResponseEntity.ok("2FA actualizado correctamente!");
        }

        /**
         * Habilita o deshabilita la verificación en dos pasos.
         */
        @PostMapping("/update-2fa")
        public ResponseEntity<String> updateTwoFactor(
                        @RequestParam String nombreUsuario,
                        @RequestParam boolean enabled) {
                Usuario user = userRepository.findByNombreUsuario(nombreUsuario)
                                .orElseThrow(() -> new RuntimeException("Usuario no existe"));
                user.setTwoFAEnabled(enabled);
                // Si deshabilitas, opcionalmente limpia el secret:
                if (!enabled) {
                        user.setSecret2FA(null);
                }
                userRepository.save(user);
                return ResponseEntity.ok("2FA estado actualizado");
        }
}