package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.*;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.domain.service.AuthDomainService;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;

import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/users")
public class UserController {

  @Autowired
  private RegisterUserUseCase registerUC;

  @Autowired
  private LoginUserUseCase loginUC;

  @Autowired
  private VerifyTwoFactorUseCase verifyUC;
  
  // Use Cases de CRUD
  @Autowired
  private ListUsersUseCase listUsersUC;

  @Autowired
  private GetUserByIdUseCase getUserByIdUC;

  @Autowired
  private UpdateUserUseCase updateUserUC;

  @Autowired
  private DeleteUserUseCase deleteUserUC;

  @Autowired
  private AuthDomainService authService;

  @Autowired
  private UserRepository userRepository;

  @GetMapping
  public List<Usuario> getAllUsers() {
      return listUsersUC.listAll();
  }

  @GetMapping("/{id}")
  public Usuario getUserById(@PathVariable Integer id) {
      return getUserByIdUC.getById(id)
              .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
  }

  @PutMapping("/{id}")
  public Usuario updateUser(
          @PathVariable Integer id,
          @Valid @RequestBody UpdateUserDTO dto
  ) {
      return updateUserUC.updateUser(id, dto);
  }

  @DeleteMapping("/{id}")
  public String deleteUser(@PathVariable Integer id) {
      deleteUserUC.delete(id);
      return "Usuario eliminado correctamente";
  }

  @PostMapping("/register")
  public Usuario register(@Valid @RequestBody RegisterUserDTO dto) {
    return registerUC.register(dto);
  }

  @PostMapping("/login")
public String login(@RequestBody LoginUserDTO dto) {
    Usuario user = loginUC.login(dto);
    if (Boolean.TRUE.equals(user.getTwoFAEnabled())) {
      return "2FA_REQUIRED";
    }
    return "LOGIN_OK";
}

@PostMapping("/login-2fa")
public String login2FA(@RequestBody TwoFactorVerificationDTO dto) {
    // Este endpoint utiliza el use case de verificación 2FA.
    boolean valid = verifyUC.verify2FA(dto);
    return valid ? "LOGIN_OK" : "2FA_INVALID";
}

  @PostMapping("/verify-2fa")
  public String verify2FA(@RequestBody TwoFactorVerificationDTO dto) {
    boolean valid = verifyUC.verify2FA(dto);
    return valid ? "2FA_OK" : "2FA_INVALID";
  }

  @PostMapping("/2fa-secret")
  public TwoFactorSetupResponseDTO generate2FASecret(@RequestParam String username) {
    return authService.generate2FASetup(username);
  }

  @PostMapping("/test-update-2fa")
public String testUpdate2FA(@RequestParam String nombreUsuario) {
    Usuario user = userRepository.findByNombreUsuario(nombreUsuario)
        .orElseThrow(() -> new RuntimeException("No existe"));
    user.setTwoFAEnabled(true);
    userRepository.save(user);
    return "Actualizado!";
}
}