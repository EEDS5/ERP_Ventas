package com.proyecto.erpventas.application.dto.response.reportecuentas;

import lombok.Getter;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
public class CuentaPorCobrarResponse {

    private final String cliente;
    private final Integer ventaId;
    private final String numeroFactura;
    private final LocalDateTime fechaVencimiento;
    private final BigDecimal montoPendiente;
    private final String estado;
    private final LocalDateTime fechaUltimoPago;

    public CuentaPorCobrarResponse(String cliente, Integer ventaId, String numeroFactura,
                                   LocalDateTime fechaVencimiento, BigDecimal montoPendiente,
                                   String estado, LocalDateTime fechaUltimoPago) {
        this.cliente = cliente;
        this.ventaId = ventaId;
        this.numeroFactura = numeroFactura;
        this.fechaVencimiento = fechaVencimiento;
        this.montoPendiente = montoPendiente;
        this.estado = estado;
        this.fechaUltimoPago = fechaUltimoPago;
    }
}