package com.proyecto.erpventas.application.dto.response.reportefacturacion;

import lombok.Getter;
import java.math.BigDecimal;

@Getter
public class MesFacturado {

    private String mes;
    private BigDecimal totalFacturado;

    // Constructor original (BigDecimal)
    public MesFacturado(String mes, BigDecimal totalFacturado) {
        this.mes = mes;
        this.totalFacturado = totalFacturado;
    }
}