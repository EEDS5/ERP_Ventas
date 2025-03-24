package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.TwoFactorSetupResponseDTO;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import org.springframework.stereotype.Service;

@Service
public class AuthDomainService {

    private final GoogleAuthenticator gAuth;

    public AuthDomainService(GoogleAuthenticator gAuth) {
        this.gAuth = gAuth;
    }

    public TwoFactorSetupResponseDTO generate2FASetup(String username) {
        GoogleAuthenticatorKey key = gAuth.createCredentials();

        String secret = key.getKey();
        String otpAuthURL = String.format(
            "otpauth://totp/%s@ERP_Ventas?secret=%s&issuer=ERP_Ventas",
            username, secret
        );

        return new TwoFactorSetupResponseDTO(secret, otpAuthURL);
    }
}