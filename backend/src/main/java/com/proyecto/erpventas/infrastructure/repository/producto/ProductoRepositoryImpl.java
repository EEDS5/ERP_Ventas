package com.proyecto.erpventas.infrastructure.repository.producto;

import com.proyecto.erpventas.domain.model.inventory.Producto;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class ProductoRepositoryImpl implements ProductoRepository {

    private final SpringProductoJpaRepository jpaRepository;

    public ProductoRepositoryImpl(SpringProductoJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public boolean existsByNombre(String nombre) {
        return jpaRepository.existsByNombre(nombre);
    }

    @Override
    public Optional<Producto> findByNombre(String nombre) {
        // Ahora trae el producto aunque esté inactivo
        return jpaRepository.findByNombre(nombre);
    }

    @Override
    public Optional<Producto> findActiveByNombre(String nombre) {
        return jpaRepository.findByNombre(nombre).filter(Producto::getActivo);
    }

    @Override
    public Producto save(Producto producto) {
        return jpaRepository.save(producto);
    }

    @Override
    public Producto saveAndFlush(Producto producto) {
        return jpaRepository.saveAndFlush(producto);
    }

    @Override
    public Optional<Producto> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(Producto::getActivo);
    }

    @Override
    public List<Producto> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByNombreAsc();
    }

    @Override
    public List<Producto> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<Producto> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            Producto p = opt.get();
            p.setActivo(false);
            jpaRepository.save(p);
        } else {
            throw new RuntimeException("Producto no encontrado");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
