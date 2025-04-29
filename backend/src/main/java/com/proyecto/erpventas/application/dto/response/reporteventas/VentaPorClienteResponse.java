package com.proyecto.erpventas.application.dto.response.reporteventas;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
public class VentaPorClienteResponse {
    private Integer clienteId;
    private String clienteNombre;
    private Integer ventaId;
    private LocalDateTime fechaVenta;
    private BigDecimal totalVenta;
}