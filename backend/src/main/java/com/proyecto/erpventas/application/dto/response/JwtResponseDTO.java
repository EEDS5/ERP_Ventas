// backend/src/main/java/com/proyecto/erpventas/application/dto/response/JwtResponseDTO.java
package com.proyecto.erpventas.application.dto.response;

public class JwtResponseDTO {
    private String token;

    // 1) Constructor por defecto
    public JwtResponseDTO() {}

    // 2) Constructor que se usa en el controller
    public JwtResponseDTO(String token) {
        this.token = token;
    }

    // 3) Getter 
    public String getToken() {
        return token;
    }

    // 4) Setter 
    public void setToken(String token) {
        this.token = token;
    }
}