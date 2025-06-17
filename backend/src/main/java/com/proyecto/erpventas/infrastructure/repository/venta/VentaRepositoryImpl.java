package com.proyecto.erpventas.infrastructure.repository.venta;

import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.domain.service.VentaRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Implementación de VentaRepository usando Spring Data JPA y JPQL para consultas personalizadas.
 */
@Repository
public class VentaRepositoryImpl implements VentaRepository {

    private final SpringVentaJpaRepository jpaRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public VentaRepositoryImpl(SpringVentaJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public Venta save(Venta venta) {
        return jpaRepository.save(venta);
    }

    @Override
    public Venta saveAndFlush(Venta venta) {
        return jpaRepository.saveAndFlush(venta);
    }

    @Override
    public Optional<Venta> findById(Integer id) {
        return jpaRepository.findById(id.longValue());
    }

    @Override
    public List<Venta> findAll() {
        return jpaRepository.findAll();
    }

    @Override
    public List<Venta> findAllByActivoTrue() {
        return jpaRepository.findAllByActivoTrueOrderByFechaVentaDesc();
    }

    @Override
    public void deleteById(Integer id) {
        // Borrado lógico: marcar como inactivo
        softDeleteById(id);
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<Venta> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            Venta v = opt.get();
            v.setActivo(false);
            jpaRepository.save(v);
        } else {
            throw new RuntimeException("Venta no encontrada");
        }
    }

    @Override
    public List<Venta> obtenerVentasActivasConCliente() {
        // Devuelve las ventas activas con datos de cliente, ordenadas por fecha
        return jpaRepository.findAllByActivoTrueOrderByFechaVentaDesc();
    }

    @Override
    public Optional<Venta> findVentaConFactura(Integer id) {
        String jpql = """
            SELECT v
              FROM Venta v
         LEFT JOIN FETCH v.factura f
             WHERE v.ventaId = :id
        """;
        return entityManager.createQuery(jpql, Venta.class)
            .setParameter("id", id)
            .getResultStream()
            .findFirst();
    }
}
