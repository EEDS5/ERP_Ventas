package com.proyecto.erpventas.infrastructure.repository.venta;

import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class DetalleVentaRepositoryImpl implements DetalleVentaRepository {

    private final SpringDetalleVentaJpaRepository jpaRepository;

    public DetalleVentaRepositoryImpl(SpringDetalleVentaJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public DetalleVenta save(DetalleVenta detalle) {
        return jpaRepository.save(detalle);
    }

    @Override
    public DetalleVenta saveAndFlush(DetalleVenta detalle) {
        return jpaRepository.saveAndFlush(detalle);
    }

    @Override
    public Optional<DetalleVenta> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(DetalleVenta::getActivo);
    }

    @Override
    public List<DetalleVenta> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByDetalleIdAsc();
    }

    @Override
    public List<DetalleVenta> findAllByVenta(Integer ventaId) {
        return jpaRepository.findAllByVenta_VentaIdAndActivoTrue(ventaId);
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<DetalleVenta> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            DetalleVenta d = opt.get();
            d.setActivo(false);
            jpaRepository.save(d);
        } else {
            throw new RuntimeException("Detalle de venta no encontrado");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
