package com.proyecto.erpventas.application.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class VentaResponseDTO {
    private Integer ventaId;
    private Integer clienteId;
    private String clienteNombre;
    private LocalDateTime fechaVenta;
    private BigDecimal total;
    private Integer metodoPagoId;
    private String metodoPagoNombre;
    private Integer creadoPorUsuarioId;
    private String creadoPorUsuarioNombre;
    private Boolean activo;
}
