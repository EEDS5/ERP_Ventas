package com.proyecto.erpventas.infrastructure.mapper;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.sales.Venta;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;

public class VentaPorClienteMapperTest {

    @Test
    void deberiaMapearCorrectamenteVentaAVentaPorClienteResponse() {
        // Arrange
        Cliente cliente = new Cliente();
        cliente.setClienteId(1);
        cliente.setNombre("Cliente Demo");

        Venta venta = new Venta();
        venta.setVentaId(101);
        venta.setFechaVenta(LocalDateTime.of(2025, 6, 1, 0, 0));
        venta.setTotal(new BigDecimal("1200.00"));
        venta.setCliente(cliente);

        VentaPorClienteMapper mapper = new VentaPorClienteMapper();

        // Act
        VentaPorClienteResponse response = mapper.fromVenta(venta);

        // Assert
        assertThat(response).isNotNull();
        assertThat(response.getClienteNombre()).isEqualTo("Cliente Demo");
        assertThat(response.getVentaId()).isEqualTo(101);
        assertThat(response.getTotalVenta()).isEqualByComparingTo("1200.00");
    }
}