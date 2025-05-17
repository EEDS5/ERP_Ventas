package com.proyecto.erpventas.application.dto.request.venta;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class UpdateVentaDTO {

    @NotNull
    private Integer metodoPagoId;

    @NotNull
    @DecimalMin(value = "0.0", inclusive = true)
    private BigDecimal total;
}