package com.proyecto.erpventas.domain.model.sales;

import com.proyecto.erpventas.domain.model.people.Cliente;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "CuentasPorCobrar")
@Getter
@Setter
public class CuentaPorCobrar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cuentaid")
    private Integer cuentaId;

    @ManyToOne
    @JoinColumn(name = "clienteid", nullable = false)
    private Cliente cliente;

    @OneToOne
    @JoinColumn(name = "ventaid", nullable = false, unique = true)
    private Venta venta;

    @Column(name = "montopendiente", nullable = false)
    private BigDecimal montoPendiente;

    @Column(name = "fechavencimiento", nullable = false)
    private LocalDateTime fechaVencimiento;

    @Column(name = "estado", nullable = false)
    private String estado;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}