// controller/UserController.java
package controller;

import aplicaciones.dto.*;
import aplicaciones.usecases.*;
import dominio.modulos.Usuario;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
@RequestMapping("/api/users")
public class UserController {

  @Autowired
  private RegisterUserUseCase registerUC;
  @Autowired
  private LoginUserUseCase loginUC;
  @Autowired
  private VerifyTwoFactorUseCase verifyUC;

  @PostMapping("/register")
  public Usuario register(@RequestBody RegisterUserDTO dto) {
    return registerUC.register(dto);
  }

  @PostMapping("/login")
  public String login(@RequestBody LoginUserDTO dto) {
    Usuario user = loginUC.login(dto);
    if (Boolean.TRUE.equals(user.getIs2FAEnabled())) {
      // Devuelves un token temporal o algo que indique que va a
      // requerir 2FA. Aquí solo un ejemplo.
      return "2FA_REQUIRED";
    }
    // De lo contrario, generas un JWT o lo que manejes.
    return "LOGIN_OK";
  }

  @PostMapping("/verify-2fa")
  public String verify2FA(@RequestBody TwoFactorVerificationDTO dto) {
    boolean valid = verifyUC.verify2FA(dto);
    return valid ? "2FA_OK" : "2FA_INVALID";
  }
}
