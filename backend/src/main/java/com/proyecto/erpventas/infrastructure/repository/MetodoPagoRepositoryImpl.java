package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class MetodoPagoRepositoryImpl implements MetodoPagoRepository {

    private final SpringMetodoPagoJpaRepository jpaRepository;

    public MetodoPagoRepositoryImpl(SpringMetodoPagoJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public boolean existsByNombre(String nombre) {
        return jpaRepository.existsByNombre(nombre);
    }

    @Override
    public Optional<MetodoPago> findByNombre(String nombre) {
        return jpaRepository.findByNombre(nombre).filter(MetodoPago::getActivo);
    }

    @Override
    public MetodoPago save(MetodoPago metodoPago) {
        return jpaRepository.save(metodoPago);
    }

    @Override
    public MetodoPago saveAndFlush(MetodoPago metodoPago) {
        return jpaRepository.saveAndFlush(metodoPago);
    }

    @Override
    public Optional<MetodoPago> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(MetodoPago::getActivo);
    }

    @Override
    public List<MetodoPago> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByNombreAsc();
    }

    @Override
    public List<MetodoPago> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<MetodoPago> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            MetodoPago m = opt.get();
            m.setActivo(false);
            jpaRepository.save(m);
        } else {
            throw new RuntimeException("Método de pago no encontrado");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}