package com.proyecto.erpventas.application.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateUserDataDTO {
    private String nombreUsuario;
    private String email;
    // No se incluye la contraseña
}