// backend/src/main/java/com/proyecto/erpventas/application/dto/response/JwtResponseDTO.java
package com.proyecto.erpventas.application.dto.response.auth;

import com.proyecto.erpventas.application.dto.response.usuario.UsuarioResponseDTO;

public class JwtResponseDTO {
    private String token;
    private UsuarioResponseDTO user;

     // 1) Constructor por defecto
    public JwtResponseDTO() {}

    // 2) Constructor solo con token (para "2FA_REQUIRED")
    public JwtResponseDTO(String token) {
        this.token = token;
        this.user = null;
    }

    // 3) Constructor completo
    public JwtResponseDTO(String token, UsuarioResponseDTO user) {
        this.token = token;
        this.user = user;
    }

    // 4) Getter
    public String getToken() {
        return token;
    }

    // 5) Setter
    public void setToken(String token) {
        this.token = token;
    }

    // 6) Getter

    public UsuarioResponseDTO getUser() {
        return user;
    }

    // 7) Setter

    public void setUser(UsuarioResponseDTO user) {
        this.user = user;
    }
}