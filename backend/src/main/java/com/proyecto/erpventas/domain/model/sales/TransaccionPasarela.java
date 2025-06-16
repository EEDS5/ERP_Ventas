package com.proyecto.erpventas.domain.model.sales;

import com.proyecto.erpventas.domain.model.inventory.PasarelaPago;
import com.proyecto.erpventas.domain.model.people.Usuario;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "TransaccionesPasarela")
@Getter
@Setter
public class TransaccionPasarela {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaccionid")
    private Integer transaccionId;

    @ManyToOne
    @JoinColumn(name = "ventaid", nullable = false)
    private Venta venta;

    @ManyToOne
    @JoinColumn(name = "pasarelaid", nullable = false)
    private PasarelaPago pasarela;

    @Column(name = "estado", nullable = false)
    private String estado;

    @Column(name = "fechatransaccion", nullable = false)
    private LocalDateTime fechaTransaccion;

    @Column(name = "monto", nullable = false)
    private BigDecimal monto;

    @Column(name = "referenciatransaccion", nullable = false)
    private String referenciaTransaccion;

    @ManyToOne
    @JoinColumn(name = "iniciadaporusuarioid", nullable = false)
    private Usuario iniciadaPorUsuario;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}
