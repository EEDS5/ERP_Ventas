package com.proyecto.erpventas.application.dto.request.venta;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public class UpdateVentaDTO {
    @NotNull
    private Integer metodoPagoId;
    @NotNull
    private BigDecimal total;

    public Integer getMetodoPagoId() {
        return metodoPagoId;
    }
    public void setMetodoPagoId(Integer metodoPagoId) {
        this.metodoPagoId = metodoPagoId;
    }

    public BigDecimal getTotal() {
        return total;
    }
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}
