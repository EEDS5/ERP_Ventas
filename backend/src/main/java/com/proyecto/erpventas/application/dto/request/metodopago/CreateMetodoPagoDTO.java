package com.proyecto.erpventas.application.dto.request.metodopago;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateMetodoPagoDTO {

    @NotBlank
    private String nombre;
}