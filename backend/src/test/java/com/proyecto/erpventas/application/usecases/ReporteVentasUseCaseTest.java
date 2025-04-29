package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.application.usecases.reporteventas.ReporteVentasUseCase;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;
import com.proyecto.erpventas.infrastructure.mapper.VentaPorClienteMapper;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class ReporteVentasUseCaseTest {

    @Test
    void deberiaRetornarHistorialVentasPorCliente() {
        // Arrange
        VentaRepository mockRepository = mock(VentaRepository.class);
        VentaPorClienteMapper mapper = new VentaPorClienteMapper();
        ReporteVentasUseCase useCase = new ReporteVentasUseCase(mockRepository, mapper);

        Cliente cliente = new Cliente();
        cliente.setClienteId(1);
        cliente.setNombre("Cliente Demo");

        Venta venta = new Venta();
        venta.setVentaId(101);
        venta.setFechaVenta(LocalDateTime.now());
        venta.setTotal(new BigDecimal("1200.00"));
        venta.setCliente(cliente);

        when(mockRepository.obtenerVentasActivasConCliente()).thenReturn(List.of(venta));

        // Act
        List<VentaPorClienteResponse> resultado = useCase.obtenerHistorialVentasPorCliente();

        // Assert
        assertThat(resultado).isNotNull();
        assertThat(resultado).hasSize(1);
        assertThat(resultado.get(0).getClienteNombre()).isEqualTo("Cliente Demo");

        verify(mockRepository, times(1)).obtenerVentasActivasConCliente();
    }
}