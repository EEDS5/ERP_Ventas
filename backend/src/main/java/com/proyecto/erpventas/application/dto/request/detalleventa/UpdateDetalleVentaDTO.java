package com.proyecto.erpventas.application.dto.request.detalleventa;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class UpdateDetalleVentaDTO {

    @NotNull
    @Min(1)
    private Integer cantidad;

    @NotNull
    @DecimalMin(value = "0.0", inclusive = true)
    private BigDecimal precioUnitario;
}