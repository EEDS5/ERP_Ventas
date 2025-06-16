package com.proyecto.erpventas.domain.model.sales;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import com.proyecto.erpventas.domain.model.inventory.MetodoPago;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.people.Usuario;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import java.util.List;
import java.util.ArrayList;

@Entity
@Table(name = "Ventas")
@Getter
@Setter
public class Venta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ventaid")
    private Integer ventaId;

    @ManyToOne
    @JoinColumn(name = "clienteid", nullable = false)
    private Cliente cliente;

    @Column(name = "fechaventa", updatable = false)
    @CreationTimestamp
    private LocalDateTime fechaVenta;

    @Column(name = "total", nullable = false)
    private BigDecimal total;

    @ManyToOne
    @JoinColumn(name = "metodopagoid", nullable = false)
    private MetodoPago metodoPago;

    @ManyToOne
    @JoinColumn(name = "creadoporusuarioid", nullable = false)
    private Usuario creadoPorUsuario;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;

    /**
     * Detalles asociados a esta venta.
     */
    @OneToMany(mappedBy = "venta", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DetalleVenta> detalles = new ArrayList<>();
}