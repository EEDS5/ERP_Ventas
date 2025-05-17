package com.proyecto.erpventas.application.dto.request.factura;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateFacturaDTO {

    @NotNull
    private Integer ventaId;

    @NotBlank
    private String numeroFactura;

    /** Contenido XML firmado o timbrado (opcional en creación) */
    private String xmlFactura;

    /** Id del usuario autenticado que genera la factura */
    @NotNull
    private Integer creadoPorUsuarioId;
}