package com.proyecto.erpventas.application.dto.request.cliente;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateClienteDTO {

    @NotBlank
    private String nombre;

    @Email
    @NotBlank
    private String correo;

    private String telefono;
    private String direccion;
}