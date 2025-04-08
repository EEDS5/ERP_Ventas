package com.proyecto.erpventas.application.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateUserPasswordDTO {
    @NotBlank(message = "La contraseña actual es requerida.")
    private String currentPassword;

    @NotBlank(message = "La nueva contraseña es requerida.")
    private String newPassword;
}