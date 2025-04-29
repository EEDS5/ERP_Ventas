package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.application.dto.response.CuentaPorCobrarResponse;
import com.proyecto.erpventas.domain.service.CuentaPorCobrarRepository;
import com.proyecto.erpventas.infrastructure.mapper.CuentaPorCobrarMapper;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CuentaPorCobrarRepositoryJpaAdapter implements CuentaPorCobrarRepository {

    @PersistenceContext
    private EntityManager entityManager;

    private final CuentaPorCobrarMapper mapper;

    public CuentaPorCobrarRepositoryJpaAdapter(CuentaPorCobrarMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public List<CuentaPorCobrarResponse> obtenerReporteCuentasPorCobrar() {
        String jpql = """
            SELECT 
                c.cliente.nombre,
                v.ventaId,
                f.numeroFactura,
                c.fechaVencimiento,
                c.montoPendiente,
                c.estado,
                (
                    SELECT MAX(p.fechaPago)
                    FROM Pago p
                    WHERE p.cuentaPorCobrar.cuentaId = c.cuentaId
                )
            FROM CuentaPorCobrar c
            JOIN c.venta v
            LEFT JOIN Factura f ON f.venta.ventaId = v.ventaId
            WHERE c.activo = true
        """;

        List<Object[]> rows = entityManager
            .createQuery(jpql, Object[].class)
            .getResultList();

        return rows.stream()
            .map(mapper::fromRow)
            .toList();
    }
}