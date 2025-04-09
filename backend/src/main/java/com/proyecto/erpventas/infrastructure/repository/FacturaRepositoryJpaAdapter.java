package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.application.dto.response.FacturacionMensualResponse;
import com.proyecto.erpventas.domain.service.FacturaRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FacturaRepositoryJpaAdapter implements FacturaRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<FacturacionMensualResponse> obtenerFacturacionMensual() {
        String jpql = """
            SELECT new com.proyecto.erpventas.application.dto.response.FacturacionMensualResponse(
                FUNCTION('to_char', f.fechaEmision, 'YYYY-MM'),
                SUM(v.total))
            FROM Factura f
            JOIN f.venta v
            WHERE f.activo = true AND v.activo = true
            GROUP BY FUNCTION('to_char', f.fechaEmision, 'YYYY-MM')
        """;

        TypedQuery<FacturacionMensualResponse> query = entityManager.createQuery(jpql, FacturacionMensualResponse.class);
        return query.getResultList();
    }
}