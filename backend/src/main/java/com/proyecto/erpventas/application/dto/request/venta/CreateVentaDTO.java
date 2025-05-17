package com.proyecto.erpventas.application.dto.request.venta;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class CreateVentaDTO {

    @NotNull
    private Integer clienteId;

    @NotNull
    private Integer metodoPagoId;

    @NotNull
    @DecimalMin(value = "0.0", inclusive = true)
    private BigDecimal total;

    /** Id del usuario autenticado que crea la venta */
    @NotNull
    private Integer creadoPorUsuarioId;
}