package com.proyecto.erpventas.infrastructure.configuration;

import com.proyecto.erpventas.application.dto.response.dashboard.*;
import com.proyecto.erpventas.application.usecases.dashboard.*;
import com.proyecto.erpventas.infrastructure.repository.dashboard.DashboardRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class DashboardUseCaseConfigTest {

    private DashboardRepository repo;
    private DashboardUseCaseConfig config;

    @BeforeEach
    void setUp() {
        repo = mock(DashboardRepository.class);
        config = new DashboardUseCaseConfig();
    }

    @Test
    void ejecutarVentasHoy_deberiaRetornarTotalVentasHoy() {
        when(repo.obtenerVentasHoy()).thenReturn(BigDecimal.valueOf(10L));
        ObtenerVentasHoyUseCase useCase = config.obtenerVentasHoyUseCase(repo);
        VentasHoyResponse response = useCase.ejecutar();

        assertEquals(BigDecimal.valueOf(10L), response.getTotal());
        verify(repo, times(1)).obtenerVentasHoy();
    }

    @Test
    void ejecutarFacturacionActual_deberiaRetornarMesYTotalFacturado() {
        BigDecimal esperado = new BigDecimal("2500.50");
        when(repo.obtenerFacturacionMesActual()).thenReturn(esperado);

        ObtenerFacturacionActualUseCase useCase = config.obtenerFacturacionActualUseCase(repo);
        FacturacionActualResponse response = useCase.ejecutar();

        String mesEsperado = LocalDate.now().getMonth().name();
        assertEquals(mesEsperado, response.getMes());
        assertEquals(esperado, response.getTotal());
        verify(repo, times(1)).obtenerFacturacionMesActual();
    }

    @Test
    void ejecutarResumenCuentas_deberiaRetornarResumenCompleto() {
        Map<String, Object> resumen = new HashMap<>();
        resumen.put("totalPendiente", BigDecimal.valueOf(1500.75));
        resumen.put("cantidadClientesDeudores", 5L);

        Map<String, Integer> estado = new HashMap<>();
        estado.put("MORA", 2);
        estado.put("AL DÍA", 3);
        resumen.put("estadoCuentas", estado);

        when(repo.obtenerResumenCuentas()).thenReturn(resumen);

        ObtenerResumenCuentasUseCase useCase = config.obtenerResumenCuentasUseCase(repo);
        ResumenCuentasResponse response = useCase.ejecutar();

        assertEquals(BigDecimal.valueOf(1500.75), response.getTotalPendiente());
        assertEquals(5, response.getCantidadClientesDeudores());
        assertEquals(estado, response.getEstadoCuentas());
        verify(repo, times(1)).obtenerResumenCuentas();
    }

    @Test
    void ejecutarStockBajo_deberiaRetornarCantidadCorrecta() {
        when(repo.obtenerCantidadStockBajo()).thenReturn(4);

        ObtenerStockBajoUseCase useCase = config.obtenerStockBajoUseCase(repo);
        StockBajoResponse response = useCase.ejecutar();

        assertEquals(4, response.getCantidad());
        verify(repo, times(1)).obtenerCantidadStockBajo();
    }

    @Test
    void ejecutarUsuarios2FA_deberiaRetornarCantidadCorrecta() {
        when(repo.obtenerCantidadUsuarios2FA()).thenReturn(8);

        ObtenerUsuarios2FAUseCase useCase = config.obtenerUsuarios2FAUseCase(repo);
        Usuarios2FAResponse response = useCase.ejecutar();

        assertEquals(8, response.cantidad());
        verify(repo, times(1)).obtenerCantidadUsuarios2FA();
    }
}