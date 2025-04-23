package com.proyecto.erpventas.application.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateClienteDTO {

    @NotBlank
    private String nombre;

    @Email
    @NotBlank
    private String correo;

    private String telefono;
    private String direccion;

    /** Id del usuario autenticado que crea el registro */
    @NotNull
    private Integer creadoPorUsuarioId;
}
