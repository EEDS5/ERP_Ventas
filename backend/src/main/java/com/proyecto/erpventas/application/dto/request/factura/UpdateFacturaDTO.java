package com.proyecto.erpventas.application.dto.request.factura;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateFacturaDTO {
    /** Solo se permite actualizar el XML; el número es inmutable. */
    private String xmlFactura;
}