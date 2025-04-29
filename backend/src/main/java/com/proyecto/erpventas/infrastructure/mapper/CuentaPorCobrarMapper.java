package com.proyecto.erpventas.infrastructure.mapper;

import org.springframework.stereotype.Component;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Component
public class CuentaPorCobrarMapper {

    public CuentaPorCobrarResponse fromRow(Object[] row) {
        return new CuentaPorCobrarResponse(
            (String) row[0],                   // Cliente
            (Integer) row[1],                  // VentaID
            (String) row[2],                   // NumeroFactura
            (LocalDateTime) row[3],            // FechaVencimiento
            (BigDecimal) row[4],               // MontoPendiente
            (String) row[5],                   // Estado
            (LocalDateTime) row[6]             // FechaUltimoPago
        );
    }
}