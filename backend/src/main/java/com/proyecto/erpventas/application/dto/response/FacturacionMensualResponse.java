package com.proyecto.erpventas.application.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import java.math.BigDecimal;

@Getter
@AllArgsConstructor
public class FacturacionMensualResponse {
    private String mes;
    private BigDecimal totalFacturado;
}