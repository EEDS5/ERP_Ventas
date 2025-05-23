package com.proyecto.erpventas.application.dto.response.dashboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import java.math.BigDecimal;

@Getter
@AllArgsConstructor
public class FacturacionActualResponse {
    private String mes;
    private BigDecimal total;
}