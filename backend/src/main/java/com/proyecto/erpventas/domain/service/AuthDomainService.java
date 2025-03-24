package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.TwoFactorSetupResponseDTO;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import org.springframework.stereotype.Service;

@Service
public class AuthDomainService {

    private final GoogleAuthenticator gAuth;
    private final UserRepository userRepository;

    public AuthDomainService(GoogleAuthenticator gAuth, UserRepository userRepository) {
        this.gAuth = gAuth;
        this.userRepository = userRepository;
    }

    public TwoFactorSetupResponseDTO generate2FASetup(String username) {
        // Buscamos el usuario en la BD
        Usuario user = userRepository.findByNombreUsuario(username)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        // Generamos las credenciales TOTP
        GoogleAuthenticatorKey key = gAuth.createCredentials();
        String secret = key.getKey();
        String otpAuthURL = String.format(
            "otpauth://totp/%s@ERP_Ventas?secret=%s&issuer=ERP_Ventas",
            username, secret
        );

        // Actualizamos el registro del usuario con el secret generado
        user.setSecret2FA(secret);
        userRepository.save(user);

        return new TwoFactorSetupResponseDTO(secret, otpAuthURL);
    }
}