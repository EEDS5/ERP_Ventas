package com.proyecto.erpventas.infrastructure.repository.venta;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class VentaRepositoryJpaAdapter implements VentaRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Venta save(Venta venta) {
        entityManager.persist(venta);
        return venta;
    }

    @Override
    public Venta saveAndFlush(Venta venta) {
        Venta v = entityManager.merge(venta);
        entityManager.flush();
        return v;
    }

    @Override
    public Optional<Venta> findById(Integer id) {
        Venta v = entityManager.find(Venta.class, id);
        return Optional.ofNullable(v);
    }

    @Override
    public List<Venta> findAll() {
        return entityManager.createQuery("SELECT v FROM Venta v ORDER BY v.fechaVenta DESC", Venta.class).getResultList();
    }

    @Override
    public List<Venta> findAllByActivoTrue() {
        return entityManager.createQuery("SELECT v FROM Venta v WHERE v.activo = true", Venta.class).getResultList();
    }

    @Override
    public void deleteById(Integer id) {
        Venta venta = entityManager.find(Venta.class, id);
        if (venta != null) {
            entityManager.remove(venta);
        }
    }

    @Override
    public void softDeleteById(Integer id) {
        Venta venta = entityManager.find(Venta.class, id);
        if (venta != null) {
            venta.setActivo(false);
            entityManager.merge(venta);
        }
    }

    @Override
    public List<Venta> obtenerVentasActivasConCliente() {
        String jpql = "SELECT v FROM Venta v JOIN FETCH v.cliente c WHERE v.activo = true AND c.activo = true";
        TypedQuery<Venta> query = entityManager.createQuery(jpql, Venta.class);
        return query.getResultList();
    }
}