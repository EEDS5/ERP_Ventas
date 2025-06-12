package com.proyecto.erpventas.application.dto.response.categoria;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CategoriaResponseDTO {
    private Integer categoriaId;
    private String nombre;
    private String descripcion;
    private Boolean activo;
}
