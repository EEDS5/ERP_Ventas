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

    @Override
    public Optional<CategoriaProducto> findByNombre(String nombre) {
        return jpaRepository.findByNombre(nombre).filter(CategoriaProducto::getActivo);
    }

    @Override
    public CategoriaProducto save(CategoriaProducto categoriaProducto) {
        return jpaRepository.save(categoriaProducto);
    }

    @Override
    public CategoriaProducto saveAndFlush(CategoriaProducto categoriaProducto) {
        return jpaRepository.saveAndFlush(categoriaProducto);
    }

    @Override
    public Optional<CategoriaProducto> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(CategoriaProducto::getActivo);
    }

    @Override
    public List<CategoriaProducto> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByNombreAsc();
    }

    @Override
    public List<CategoriaProducto> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<CategoriaProducto> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            CategoriaProducto categoria = opt.get();
            categoria.setActivo(false);
            jpaRepository.save(categoria);
        } else {
            throw new RuntimeException("Categoría de producto no encontrada");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
