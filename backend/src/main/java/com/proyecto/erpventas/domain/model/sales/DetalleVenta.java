package com.proyecto.erpventas.domain.model.sales;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

import com.proyecto.erpventas.domain.model.inventory.Producto;

@Entity
@Table(name = "DetalleVentas")
@Getter
@Setter
public class DetalleVenta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "detalleid")
    private Integer detalleId;

    @ManyToOne
    @JoinColumn(name = "ventaid", nullable = false)
    private Venta venta;

    @ManyToOne
    @JoinColumn(name = "productoid", nullable = false)
    private Producto producto;

    @Column(name = "cantidad", nullable = false)
    private Integer cantidad;

    @Column(name = "preciounitario", nullable = false)
    private BigDecimal precioUnitario;

    @Column(name = "subtotal", insertable = false, updatable = false)
    private BigDecimal subtotal;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}