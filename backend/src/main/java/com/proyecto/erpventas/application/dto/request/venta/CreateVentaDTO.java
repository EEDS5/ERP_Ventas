package com.proyecto.erpventas.application.dto.request.venta;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public class CreateVentaDTO {
    @NotNull
    private Integer clienteId;
    @NotNull
    private Integer metodoPagoId;
    @NotNull
    private Integer creadoPorUsuarioId;
    @NotNull
    private BigDecimal total;

    public Integer getClienteId() {
        return clienteId;
    }
    public void setClienteId(Integer clienteId) {
        this.clienteId = clienteId;
    }

    public Integer getMetodoPagoId() {
        return metodoPagoId;
    }
    public void setMetodoPagoId(Integer metodoPagoId) {
        this.metodoPagoId = metodoPagoId;
    }

    public Integer getCreadoPorUsuarioId() {
        return creadoPorUsuarioId;
    }
    public void setCreadoPorUsuarioId(Integer creadoPorUsuarioId) {
        this.creadoPorUsuarioId = creadoPorUsuarioId;
    }

    public BigDecimal getTotal() {
        return total;
    }
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}
