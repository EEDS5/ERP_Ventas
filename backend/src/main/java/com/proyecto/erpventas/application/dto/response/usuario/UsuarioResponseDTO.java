package com.proyecto.erpventas.application.dto.response.usuario;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;

public class UsuarioResponseDTO {

    @JsonProperty("usuarioID")
    private Integer usuarioID;

    @JsonProperty("nombreUsuario")
    private String nombreUsuario;

    @JsonProperty("email")
    private String email;

    @JsonProperty("twoFAEnabled")
    private Boolean twoFAEnabled;

    @JsonProperty("fechaRegistro")
    private LocalDateTime fechaRegistro;

    @JsonProperty("activo")
    private Boolean activo;

    // Constructor
    public UsuarioResponseDTO(Integer usuarioID, String nombreUsuario, String email,
                               Boolean twoFAEnabled, LocalDateTime fechaRegistro, Boolean activo) {
        this.usuarioID = usuarioID;
        this.nombreUsuario = nombreUsuario;
        this.email = email;
        this.twoFAEnabled = twoFAEnabled;
        this.fechaRegistro = fechaRegistro;
        this.activo = activo;
    }

    // Getters
    public Integer getUsuarioID() { return usuarioID; }
    public String getNombreUsuario() { return nombreUsuario; }
    public String getEmail() { return email; }
    public Boolean getTwoFAEnabled() { return twoFAEnabled; }
    public LocalDateTime getFechaRegistro() { return fechaRegistro; }
    public Boolean getActivo() { return activo; }
}