package com.proyecto.erpventas.domain.model.sales;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "Pagos")
@Getter
@Setter
public class Pago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "pagoid")
    private Integer pagoId;

    @ManyToOne
    @JoinColumn(name = "cuentaid", nullable = false)
    private CuentaPorCobrar cuentaPorCobrar;

    @Column(name = "fechapago", nullable = false)
    private LocalDateTime fechaPago;

    @Column(name = "monto", nullable = false)
    private BigDecimal monto;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}