package com.proyecto.erpventas.application.dto.request.auth;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

public class RegisterUserDTO {

    @NotBlank(message = "El nombre de usuario no puede estar vacío.")
    @JsonProperty("nombreUsuario")
    private String nombreUsuario;

    @NotBlank(message = "El email no puede estar vacío.")
    @JsonProperty("email")
    private String email;

    @NotBlank(message = "La contraseña no puede estar vacía.")
    @JsonProperty("password")
    private String password;

    // Getters y setters
    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}