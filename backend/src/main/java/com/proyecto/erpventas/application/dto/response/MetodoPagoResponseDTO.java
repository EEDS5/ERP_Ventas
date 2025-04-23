package com.proyecto.erpventas.application.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class MetodoPagoResponseDTO {
    private Integer metodoPagoId;
    private String nombre;
    private Boolean activo;
}