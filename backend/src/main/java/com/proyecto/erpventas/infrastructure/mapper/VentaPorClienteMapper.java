package com.proyecto.erpventas.infrastructure.mapper;

import com.proyecto.erpventas.application.dto.response.reporteventas.VentaPorClienteResponse;
import com.proyecto.erpventas.domain.model.sales.Venta;
import org.springframework.stereotype.Component;

@Component
public class VentaPorClienteMapper {

    public VentaPorClienteResponse fromVenta(Venta venta) {
        return new VentaPorClienteResponse(
            venta.getCliente().getClienteId(),
            venta.getCliente().getNombre(),
            venta.getVentaId(),
            venta.getFechaVenta(),
            venta.getTotal()
        );
    }
}