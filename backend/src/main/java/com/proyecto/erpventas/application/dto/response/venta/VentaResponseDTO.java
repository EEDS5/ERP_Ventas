package com.proyecto.erpventas.application.dto.response.venta;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record VentaResponseDTO(
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
  Boolean facturada
) {}
