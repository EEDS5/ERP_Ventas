package com.proyecto.erpventas.application.dto.response;

import java.math.BigDecimal;
import java.util.Date;

public class VentaPorClienteReport {
    private Integer clienteId;
    private String clienteNombre;
    private Integer ventaId;
    private Date fechaVenta;       // java.util.Date
    private BigDecimal totalVenta;

    public VentaPorClienteReport(Integer clienteId, String clienteNombre,
                                 Integer ventaId, Date fechaVenta,
                                 BigDecimal totalVenta) {
        this.clienteId     = clienteId;
        this.clienteNombre = clienteNombre;
        this.ventaId       = ventaId;
        this.fechaVenta    = fechaVenta;
        this.totalVenta    = totalVenta;
    }

    // getters (sin setters si no los necesitas)
    public Integer getClienteId()     { return clienteId; }
    public String  getClienteNombre() { return clienteNombre; }
    public Integer getVentaId()       { return ventaId; }
    public Date    getFechaVenta()    { return fechaVenta; }
    public BigDecimal getTotalVenta() { return totalVenta; }
}