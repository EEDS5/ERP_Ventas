package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.*;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.domain.service.AuthDomainService;

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
  
  @Autowired
  private AuthDomainService authService;

  @PostMapping("/register")
  public Usuario register(@RequestBody RegisterUserDTO dto) {
    return registerUC.register(dto);
  }

  @PostMapping("/login")
  public String login(@RequestBody LoginUserDTO dto) {
    Usuario user = loginUC.login(dto);
    if (Boolean.TRUE.equals(user.getIs2FAEnabled())) {
      return "2FA_REQUIRED";
    }
    return "LOGIN_OK";
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
}