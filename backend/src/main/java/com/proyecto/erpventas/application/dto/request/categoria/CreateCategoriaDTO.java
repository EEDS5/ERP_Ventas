package com.proyecto.erpventas.application.dto.request.categoria;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateCategoriaDTO {

    @NotBlank
    private String nombre;

    private String descripcion;
}
