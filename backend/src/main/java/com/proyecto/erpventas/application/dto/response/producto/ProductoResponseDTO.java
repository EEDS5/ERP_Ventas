package com.proyecto.erpventas.application.dto.response.producto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
public class ProductoResponseDTO {
    private Integer productoId;
    private String nombre;
    private String descripcion;
    private BigDecimal precio;
    private Integer stock;
    private Integer categoriaId;
    private String categoriaNombre;
    private Boolean activo;
}