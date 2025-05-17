package com.proyecto.erpventas.application.dto.request.detalleventa;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class CreateDetalleVentaDTO {

    @NotNull
    private Integer ventaId;

    @NotNull
    private Integer productoId;

    @NotNull
    @Min(1)
    private Integer cantidad;

    /** Precio unitario al momento de la venta */
    @NotNull
    @DecimalMin(value = "0.0", inclusive = true)
    private BigDecimal precioUnitario;
}
