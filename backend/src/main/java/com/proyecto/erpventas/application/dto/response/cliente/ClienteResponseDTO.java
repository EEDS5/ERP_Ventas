package com.proyecto.erpventas.application.dto.response.cliente;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class ClienteResponseDTO {
    private Integer clienteId;
    private String nombre;
    private String correo;
    private String telefono;
    private String direccion;
    private LocalDateTime fechaRegistro;
    private Boolean activo;
}