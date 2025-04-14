package com.proyecto.erpventas.infrastructure.repository;

import com.proyecto.erpventas.domain.model.people.Cliente;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class ClienteRepositoryImpl implements ClienteRepository {

    private final SpringClienteJpaRepository jpaRepository;

    public ClienteRepositoryImpl(SpringClienteJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public Optional<Cliente> findByCorreo(String correo) {
        return jpaRepository.findByCorreo(correo)
                .filter(Cliente::getActivo);
    }

    @Override
    public boolean existsByCorreo(String correo) {
        return jpaRepository.existsByCorreo(correo);
    }

    @Override
    public Cliente save(Cliente cliente) {
        return jpaRepository.save(cliente);
    }

    @Override
    public Cliente saveAndFlush(Cliente cliente) {
        return jpaRepository.saveAndFlush(cliente);
    }

    @Override
    public Optional<Cliente> findById(Integer id) {
        return jpaRepository.findById(id.longValue())
                .filter(Cliente::getActivo);
    }

    @Override
    public List<Cliente> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByFechaRegistroAsc();
    }

    @Override
    public List<Cliente> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<Cliente> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            Cliente cliente = opt.get();
            cliente.setActivo(false);
            jpaRepository.save(cliente);
        } else {
            throw new RuntimeException("Cliente no encontrado");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
