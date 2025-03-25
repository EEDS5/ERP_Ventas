package com.proyecto.erpventas.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateUserDTO {
    private String nombreUsuario;
    private String email;
    private String password;
}
