package com.proyecto.erpventas.infrastructure.mapper;

import org.junit.jupiter.api.Test;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

public class FacturacionMensualMapperTest {

    @Test
    void deberiaMapearCorrectamenteObjectArrayAMesFacturado() {
        // Arrange
        Object[] row = new Object[]{
            "2025-04",                       // Mes
            new BigDecimal("25000.00")        // TotalFacturado
        };

        FacturacionMensualMapper mapper = new FacturacionMensualMapper();

        // Act
        MesFacturadoResponse response = mapper.fromRow(row);

        // Assert
        assertThat(response).isNotNull();
        assertThat(response.getMes()).isEqualTo("2025-04");
        assertThat(response.getTotalFacturado()).isEqualByComparingTo("25000.00");
    }
}