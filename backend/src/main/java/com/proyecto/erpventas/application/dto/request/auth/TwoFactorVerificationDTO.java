package com.proyecto.erpventas.application.dto.request.auth;

public class TwoFactorVerificationDTO {
    private String nombreUsuario;
    private String token2FA;

    // Getters y setters
    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getToken2FA() {
        return token2FA;
    }

    public void setToken2FA(String token2FA) {
        this.token2FA = token2FA;
    }
}