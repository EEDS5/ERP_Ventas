package com.proyecto.erpventas.application.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateMetodoPagoDTO {

    @NotBlank
    private String nombre;
}