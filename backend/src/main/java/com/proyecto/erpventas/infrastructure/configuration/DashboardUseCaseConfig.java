package com.proyecto.erpventas.infrastructure.configuration;

import com.proyecto.erpventas.application.usecases.dashboard.*;
import com.proyecto.erpventas.application.dto.response.dashboard.*;
import com.proyecto.erpventas.infrastructure.repository.dashboard.DashboardRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.util.Map;
import java.math.BigDecimal;

@Configuration
public class DashboardUseCaseConfig {

    @Bean
    public ObtenerVentasHoyUseCase obtenerVentasHoyUseCase(DashboardRepository repo) {
        return () -> new VentasHoyResponse(repo.obtenerVentasHoy());
    }

    @Bean
    public ObtenerFacturacionActualUseCase obtenerFacturacionActualUseCase(DashboardRepository repo) {
        return () -> {
            BigDecimal total = repo.obtenerFacturacionMesActual();
            String mesActual = LocalDate.now().getMonth().name();
            return new FacturacionActualResponse(mesActual, total);
        };
    }

    @Bean
    public ObtenerResumenCuentasUseCase obtenerResumenCuentasUseCase(DashboardRepository repo) {
        return () -> mapearResumen(repo.obtenerResumenCuentas());
    }

    private ResumenCuentasResponse mapearResumen(Map<String, Object> resumen) {
        BigDecimal totalPendiente = (BigDecimal) resumen.get("totalPendiente");
        Integer cantidadClientes = ((Long) resumen.get("cantidadClientesDeudores")).intValue();

        @SuppressWarnings("unchecked")
        Map<String, Integer> estadoCuentas = (Map<String, Integer>) resumen.get("estadoCuentas");

        return new ResumenCuentasResponse(totalPendiente, cantidadClientes, estadoCuentas);
    }

    @Bean
    public ObtenerStockBajoUseCase obtenerStockBajoUseCase(DashboardRepository repo) {
        return () -> new StockBajoResponse(repo.obtenerCantidadStockBajo());
    }

    @Bean
    public ObtenerUsuarios2FAUseCase obtenerUsuarios2FAUseCase(DashboardRepository repo) {
        return () -> new Usuarios2FAResponse(repo.obtenerCantidadUsuarios2FA());
    }
}