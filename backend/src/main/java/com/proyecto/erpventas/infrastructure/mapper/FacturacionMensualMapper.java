package com.proyecto.erpventas.infrastructure.mapper;

import com.proyecto.erpventas.application.dto.response.MesFacturado;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class FacturacionMensualMapper {

    public MesFacturado fromRow(Object[] row) {
        String mes = (String) row[0];
        BigDecimal total = row[1] instanceof BigDecimal
            ? (BigDecimal) row[1]
            : new BigDecimal(row[1].toString());
        return new MesFacturado(mes, total);
    }
}