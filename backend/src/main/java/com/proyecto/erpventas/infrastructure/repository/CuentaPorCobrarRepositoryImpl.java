package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.CuentaPorCobrar;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class CuentaPorCobrarRepositoryImpl implements CuentaPorCobrarRepository {

    private final SpringCuentaPorCobrarJpaRepository jpaRepository;

    public CuentaPorCobrarRepositoryImpl(SpringCuentaPorCobrarJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public List<CuentaPorCobrar> findAll() {
        return jpaRepository.findAllByActivoTrue();
    }

    @Override
    public Optional<CuentaPorCobrar> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(CuentaPorCobrar::getActivo);
    }

    @Override
    public CuentaPorCobrar save(CuentaPorCobrar cuenta) {
        return jpaRepository.save(cuenta);
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<CuentaPorCobrar> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            CuentaPorCobrar c = opt.get();
            c.setActivo(false);
            jpaRepository.save(c);
        } else {
            throw new RuntimeException("Cuenta por cobrar no encontrada");
        }
    }
}