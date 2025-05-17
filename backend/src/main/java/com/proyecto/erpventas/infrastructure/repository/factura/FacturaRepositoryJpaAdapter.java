package com.proyecto.erpventas.infrastructure.repository.factura;

import com.proyecto.erpventas.application.dto.response.reportefacturacion.MesFacturadoResponse;
import com.proyecto.erpventas.domain.service.FacturaRepository;
import com.proyecto.erpventas.infrastructure.mapper.FacturacionMensualMapper;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FacturaRepositoryJpaAdapter implements FacturaRepository {

    @PersistenceContext
    private EntityManager entityManager;

    private final FacturacionMensualMapper mapper;

    public FacturaRepositoryJpaAdapter(FacturacionMensualMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public List<MesFacturadoResponse> obtenerFacturacionMensual() {
        String jpql = """
            SELECT FUNCTION('to_char', f.fechaEmision, 'YYYY-MM'),
                   SUM(v.total)
              FROM Factura f
              JOIN f.venta v
             WHERE f.activo = true AND v.activo = true
             GROUP BY FUNCTION('to_char', f.fechaEmision, 'YYYY-MM')
        """;

        List<Object[]> rows = entityManager
            .createQuery(jpql, Object[].class)
            .getResultList();

        return rows.stream()
            .map(mapper::fromRow)
            .toList();
    }
}