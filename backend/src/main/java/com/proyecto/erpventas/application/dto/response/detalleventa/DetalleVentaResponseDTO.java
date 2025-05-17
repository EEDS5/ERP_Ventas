package com.proyecto.erpventas.application.dto.response.detalleventa;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
public class DetalleVentaResponseDTO {
    private Integer detalleId;
    private Integer ventaId;
    private Integer productoId;
    private String productoNombre;
    private Integer cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subtotal;
    private Boolean activo;
}
