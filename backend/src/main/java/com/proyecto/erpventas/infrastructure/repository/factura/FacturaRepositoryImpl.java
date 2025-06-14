package com.proyecto.erpventas.infrastructure.repository.factura;

import com.proyecto.erpventas.domain.model.sales.Factura;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class FacturaRepositoryImpl implements FacturaRepository {

    private final SpringFacturaJpaRepository jpaRepository;

    public FacturaRepositoryImpl(SpringFacturaJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public boolean existsByNumeroFactura(String numeroFactura) {
        return jpaRepository.existsByNumeroFactura(numeroFactura);
    }

    @Override
    public Optional<Factura> findByNumeroFactura(String numeroFactura) {
        return jpaRepository.findByNumeroFactura(numeroFactura).filter(Factura::getActivo);
    }

    @Override
    public Factura save(Factura factura) {
        return jpaRepository.save(factura);
    }

    @Override
    public Factura saveAndFlush(Factura factura) {
        return jpaRepository.saveAndFlush(factura);
    }

    @Override
    public Optional<Factura> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(Factura::getActivo);
    }

    @Override
    public List<Factura> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByFechaEmisionDesc();
    }

    @Override
    public List<Factura> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<Factura> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            Factura f = opt.get();
            f.setActivo(false);
            jpaRepository.save(f);
        } else {
            throw new RuntimeException("Factura no encontrada");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }

    @Override
    public boolean existsByVentaId(Integer ventaId) {
        return jpaRepository.existsByVenta_VentaId(ventaId);
    }
}
