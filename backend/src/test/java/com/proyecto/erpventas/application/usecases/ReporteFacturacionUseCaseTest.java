package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;
import com.proyecto.erpventas.application.usecases.reportefacturacion.ReporteFacturacionUseCase;
import com.proyecto.erpventas.domain.service.FacturaRepository;
import org.junit.jupiter.api.Test;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class ReporteFacturacionUseCaseTest {

    @Test
    void deberiaRetornarListaDeFacturacionMensual() {
        // Arrange
        FacturaRepository mockRepository = mock(FacturaRepository.class);
        DataSource mockDataSource = mock(DataSource.class);
        ReporteFacturacionUseCase useCase =
            new ReporteFacturacionUseCase(mockRepository, mockDataSource);

        MesFacturadoResponse mockResponse = new MesFacturadoResponse(
            "2025-04",
            new BigDecimal("25000.00")
        );

        when(mockRepository.obtenerFacturacionMensual())
            .thenReturn(List.of(mockResponse));

        // Act
        List<MesFacturadoResponse> resultado = useCase.obtenerFacturacionMensual();

        // Assert
        assertThat(resultado).isNotNull();
        assertThat(resultado).hasSize(1);
        assertThat(resultado.get(0).getMes()).isEqualTo("2025-04");
        assertThat(resultado.get(0).getTotalFacturado())
            .isEqualByComparingTo("25000.00");

        // Verifica que se haya llamado al repositorio
        verify(mockRepository, times(1)).obtenerFacturacionMensual();
    }
}