package com.proyecto.erpventas.application.dto.response.venta;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record VentaCompletaDTO(
    Integer ventaId,
    Integer clienteId,
    String clienteNombre,
    LocalDateTime fechaVenta,
    BigDecimal total,
    Integer metodoPagoId,
    String metodoPagoNombre,
    Integer creadoPorUsuarioId,
    String creadoPorUsuarioNombre,
    Boolean activo,
    List<DetalleVentaDTO> detalles
) {}
