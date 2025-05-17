package com.proyecto.erpventas.application.dto.response.auth;

public class TwoFactorSetupResponseDTO {
    private String secret;
    private String qrUrl;

    public TwoFactorSetupResponseDTO(String secret, String qrUrl) {
        this.secret = secret;
        this.qrUrl = qrUrl;
    }

    public String getSecret() {
        return secret;
    }

    public String getQrUrl() {
        return qrUrl;
    }
}