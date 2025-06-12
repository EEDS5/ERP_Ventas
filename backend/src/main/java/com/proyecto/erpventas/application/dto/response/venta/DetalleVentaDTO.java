package com.proyecto.erpventas.application.dto.response.venta;

import java.math.BigDecimal;

public record DetalleVentaDTO(
    Integer productoId,
    String productoNombre,
    Integer cantidad,
    BigDecimal precioUnitario,
    BigDecimal subtotal
) {}
