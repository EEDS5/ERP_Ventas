package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.response.reportecuentas.CuentaPorCobrarResponse;
import com.proyecto.erpventas.application.usecases.reportecuentas.ReporteCuentasPorCobrarUseCase;
import com.proyecto.erpventas.domain.service.CuentaPorCobrarRepository;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class ReporteCuentasPorCobrarUseCaseTest {

    @Test
    void deberiaRetornarListaDeCuentasPorCobrar() {
        // Arrange
        CuentaPorCobrarRepository mockRepository = mock(CuentaPorCobrarRepository.class);
        ReporteCuentasPorCobrarUseCase useCase = new ReporteCuentasPorCobrarUseCase(mockRepository);

        CuentaPorCobrarResponse mockResponse = new CuentaPorCobrarResponse(
            "Cliente Demo",
            101,
            "FAC-000101",
            LocalDateTime.now().plusDays(5),
            new BigDecimal("1500.00"),
            "Pendiente",
            null
        );

        when(mockRepository.obtenerReporteCuentasPorCobrar()).thenReturn(List.of(mockResponse));

        // Act
        List<CuentaPorCobrarResponse> resultado = useCase.obtenerReporteCuentasPorCobrar();

        // Assert
        assertThat(resultado).isNotNull();
        assertThat(resultado).hasSize(1);
        assertThat(resultado.get(0).getVentaId()).isEqualTo(101);
    }
}