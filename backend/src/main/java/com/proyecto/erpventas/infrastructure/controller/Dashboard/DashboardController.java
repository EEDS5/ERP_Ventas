package com.proyecto.erpventas.infrastructure.controller.Dashboard;

import com.proyecto.erpventas.application.dto.response.dashboard.*;
import com.proyecto.erpventas.application.usecases.dashboard.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

    private final ObtenerVentasHoyUseCase ventasHoyUseCase;
    private final ObtenerFacturacionActualUseCase facturacionActualUseCase;
    private final ObtenerResumenCuentasUseCase resumenCuentasUseCase;
    private final ObtenerStockBajoUseCase stockBajoUseCase;
    private final ObtenerUsuarios2FAUseCase usuarios2FAUseCase;

    public DashboardController(
            ObtenerVentasHoyUseCase ventasHoyUseCase,
            ObtenerFacturacionActualUseCase facturacionActualUseCase,
            ObtenerResumenCuentasUseCase resumenCuentasUseCase,
            ObtenerStockBajoUseCase stockBajoUseCase,
            ObtenerUsuarios2FAUseCase usuarios2FAUseCase) {
        this.ventasHoyUseCase = ventasHoyUseCase;
        this.facturacionActualUseCase = facturacionActualUseCase;
        this.resumenCuentasUseCase = resumenCuentasUseCase;
        this.stockBajoUseCase = stockBajoUseCase;
        this.usuarios2FAUseCase = usuarios2FAUseCase;
    }

    @GetMapping("/ventas-hoy")
    public ResponseEntity<VentasHoyResponse> getVentasHoy() {
        return ResponseEntity.ok(ventasHoyUseCase.ejecutar());
    }

    @GetMapping("/facturacion-actual")
    public ResponseEntity<FacturacionActualResponse> getFacturacionActual() {
        return ResponseEntity.ok(facturacionActualUseCase.ejecutar());
    }

    @GetMapping("/resumen-cuentas")
    public ResponseEntity<ResumenCuentasResponse> getResumenCuentas() {
        return ResponseEntity.ok(resumenCuentasUseCase.ejecutar());
    }

    @GetMapping("/stock-bajo")
    public ResponseEntity<StockBajoResponse> getStockBajo() {
        return ResponseEntity.ok(stockBajoUseCase.ejecutar());
    }

    @GetMapping("/usuarios-2fa")
    public ResponseEntity<Usuarios2FAResponse> getUsuarios2FA() {
        return ResponseEntity.ok(usuarios2FAUseCase.ejecutar());
    }
}