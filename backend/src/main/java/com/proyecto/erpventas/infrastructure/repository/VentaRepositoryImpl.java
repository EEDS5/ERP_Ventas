package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.Venta;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class VentaRepositoryImpl implements VentaRepository {

    private final SpringVentaJpaRepository jpaRepository;

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
        return jpaRepository.findById(id.longValue()).filter(Venta::getActivo);
    }

    @Override
    public List<Venta> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByFechaVentaDesc();
    }

    @Override
    public List<Venta> findAllByActivoTrue() {
        return findAll();
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
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
