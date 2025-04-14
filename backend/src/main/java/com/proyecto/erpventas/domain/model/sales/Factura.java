package com.proyecto.erpventas.domain.model.sales;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import com.proyecto.erpventas.domain.model.people.Usuario;

import java.time.LocalDateTime;

@Entity
@Table(name = "Facturas")
@Getter
@Setter
public class Factura {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "facturaid")
    private Integer facturaId;

    @OneToOne
    @JoinColumn(name = "ventaid", nullable = false, unique = true)
    private Venta venta;

    @Column(name = "numerofactura", nullable = false, unique = true)
    private String numeroFactura;

    @Column(name = "fechaemision", updatable = false)
    @CreationTimestamp
    private LocalDateTime fechaEmision;

    @Column(name = "xmlfactura", columnDefinition = "xml")
    private String xmlFactura;

    @ManyToOne
    @JoinColumn(name = "creadoporusuarioid", nullable = false)
    private Usuario creadoPorUsuario;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}
