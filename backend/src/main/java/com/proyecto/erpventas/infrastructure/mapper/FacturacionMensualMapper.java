package com.proyecto.erpventas.infrastructure.mapper;

import org.springframework.stereotype.Component;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;

import java.math.BigDecimal;

@Component
public class FacturacionMensualMapper {

    public MesFacturadoResponse fromRow(Object[] row) {
        String mes = (String) row[0];
        BigDecimal total = row[1] instanceof BigDecimal
            ? (BigDecimal) row[1]
            : new BigDecimal(row[1].toString());
        return new MesFacturadoResponse(mes, total);
    }
}