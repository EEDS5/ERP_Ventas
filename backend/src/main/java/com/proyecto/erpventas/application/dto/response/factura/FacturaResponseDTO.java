package com.proyecto.erpventas.application.dto.response.factura;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class FacturaResponseDTO {
    private Integer facturaId;
    private Integer ventaId;
    private String numeroFactura;
    private LocalDateTime fechaEmision;
    private String xmlFactura;
    private Integer creadoPorUsuarioId;
    private String creadoPorUsuarioNombre;
    private Boolean activo;
}
