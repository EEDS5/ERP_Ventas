package com.proyecto.erpventas.application.dto.response.usuario;

import java.util.List;

public class UsuarioTokenPayload {
    private String nombreUsuario;
    private List<String> roles;

    public UsuarioTokenPayload(String nombreUsuario, List<String> roles) {
        this.nombreUsuario = nombreUsuario;
        this.roles = roles;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public List<String> getRoles() {
        return roles;
    }
}
