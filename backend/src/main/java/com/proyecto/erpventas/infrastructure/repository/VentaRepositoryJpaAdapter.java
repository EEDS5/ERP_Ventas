package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class VentaRepositoryJpaAdapter implements VentaRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Venta> obtenerVentasActivasConCliente() {
        String jpql = "SELECT v FROM Venta v JOIN FETCH v.cliente c WHERE v.activo = true AND c.activo = true";
        TypedQuery<Venta> query = entityManager.createQuery(jpql, Venta.class);
        return query.getResultList();
    }
}