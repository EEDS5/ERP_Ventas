package com.proyecto.erpventas.infrastructure.mapper;

import org.junit.jupiter.api.Test;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;

public class CuentaPorCobrarMapperTest {

    @Test
    void deberiaMapearCorrectamenteObjectArrayACuentaPorCobrarResponse() {
        // Arrange
        Object[] row = new Object[]{
            "Cliente Demo",                    // cliente
            101,                               // ventaId
            "FAC-000101",                      // numeroFactura
            LocalDateTime.of(2025, 6, 1, 0, 0), // fechaVencimiento
            new BigDecimal("1800.00"),        // montoPendiente
            "Vencido",                         // estado
            LocalDateTime.of(2025, 5, 20, 0, 0) // fechaUltimoPago
        };

        CuentaPorCobrarMapper mapper = new CuentaPorCobrarMapper();

        // Act
        CuentaPorCobrarResponse response = mapper.fromRow(row);

        // Assert
        assertThat(response).isNotNull();
        assertThat(response.getVentaId()).isEqualTo(101);
        assertThat(response.getNumeroFactura()).isEqualTo("FAC-000101");
        assertThat(response.getEstado()).isEqualTo("Vencido");
    }
}