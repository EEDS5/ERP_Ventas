package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.TwoFactorVerificationDTO;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;

public class VerifyTwoFactorUseCase {

    private final UserRepository userRepository;
    private final GoogleAuthenticator gAuth;

    public VerifyTwoFactorUseCase(UserRepository userRepository, GoogleAuthenticator gAuth) {
        this.userRepository = userRepository;
        this.gAuth = gAuth;
    }

    public boolean verify2FA(TwoFactorVerificationDTO dto) {
        Usuario user = userRepository
            .findByNombreUsuario(dto.getNombreUsuario())
            .orElseThrow(() -> new RuntimeException("No existe"));

        if (!Boolean.TRUE.equals(user.getIs2FAEnabled())) {
            return true; // Si 2FA no está habilitado, pasa
        }

        int code = Integer.parseInt(dto.getToken2FA());
        return gAuth.authorize(user.getSecret2FA(), code);
    }
}