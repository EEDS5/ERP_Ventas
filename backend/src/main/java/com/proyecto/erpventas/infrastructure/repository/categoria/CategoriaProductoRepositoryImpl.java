package com.proyecto.erpventas.infrastructure.repository.categoria;

import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class CategoriaProductoRepositoryImpl implements CategoriaProductoRepository {

    private final SpringCategoriaProductoJpaRepository jpaRepository;

    public CategoriaProductoRepositoryImpl(SpringCategoriaProductoJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public boolean existsByNombre(String nombre) {
        return jpaRepository.existsByNombre(nombre);
    }

    /** Devuelve cualquiera, activo o no */
    @Override
    public Optional<CategoriaProducto> findByNombre(String nombre) {
        return jpaRepository.findByNombre(nombre);
    }

    /** Devuelve sólo si está activo */
    @Override
    public Optional<CategoriaProducto> findActiveByNombre(String nombre) {
        return jpaRepository.findByNombre(nombre).filter(CategoriaProducto::getActivo);
    }

    @Override
    public CategoriaProducto save(CategoriaProducto categoria) {
        return jpaRepository.save(categoria);
    }

    @Override
    public CategoriaProducto saveAndFlush(CategoriaProducto categoria) {
        return jpaRepository.saveAndFlush(categoria);
    }

    @Override
    public Optional<CategoriaProducto> findById(Integer id) {
        return jpaRepository.findById(id.longValue());
    }

    @Override
    public List<CategoriaProducto> findAll() {
        return jpaRepository.findAll();
    }

    @Override
    public List<CategoriaProducto> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<CategoriaProducto> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            CategoriaProducto c = opt.get();
            c.setActivo(false);
            jpaRepository.save(c);
        } else {
            throw new RuntimeException("Categoría no encontrada");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
