package com.proyecto.erpventas.application.dto.request.venta;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CreateVentaCompletaDTO {
    @NotNull
    private Integer clienteId;
    @NotNull
    private Integer metodoPagoId;
    @NotNull
    private Integer creadoPorUsuarioId;
    @NotEmpty
    private List<DetalleItem> detalles;

    @Getter
    @Setter
    public static class DetalleItem {
        @NotNull
        private Integer productoId;
        @NotNull
        @Min(1)
        private Integer cantidad;
    }
}
