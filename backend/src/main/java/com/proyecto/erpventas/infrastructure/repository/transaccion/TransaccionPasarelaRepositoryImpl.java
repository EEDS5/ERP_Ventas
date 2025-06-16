package com.proyecto.erpventas.infrastructure.repository.transaccion;

import com.proyecto.erpventas.domain.model.sales.TransaccionPasarela;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class TransaccionPasarelaRepositoryImpl implements TransaccionPasarelaRepository {

    private final SpringTransaccionPasarelaJpaRepository jpaRepository;

    public TransaccionPasarelaRepositoryImpl(SpringTransaccionPasarelaJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public TransaccionPasarela save(TransaccionPasarela tx) {
        return jpaRepository.save(tx);
    }

    @Override
    public Optional<TransaccionPasarela> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(TransaccionPasarela::getActivo);
    }

    @Override
    public List<TransaccionPasarela> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByFechaTransaccionDesc();
    }

    @Override
    public List<TransaccionPasarela> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<TransaccionPasarela> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            TransaccionPasarela t = opt.get();
            t.setActivo(false);
            jpaRepository.save(t);
        } else {
            throw new RuntimeException("Transacción no encontrada");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
