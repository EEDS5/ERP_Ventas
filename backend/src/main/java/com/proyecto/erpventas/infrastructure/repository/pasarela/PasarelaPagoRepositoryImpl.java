package com.proyecto.erpventas.infrastructure.repository.pasarela;

import com.proyecto.erpventas.domain.model.inventory.PasarelaPago;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class PasarelaPagoRepositoryImpl implements PasarelaPagoRepository {

    private final SpringPasarelaPagoJpaRepository jpaRepository;

    public PasarelaPagoRepositoryImpl(SpringPasarelaPagoJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public Optional<PasarelaPago> findByNombre(String nombre) {
        return jpaRepository.findByNombre(nombre).filter(PasarelaPago::getActivo);
    }

    @Override
    public Optional<PasarelaPago> findById(Integer id) {
        return jpaRepository.findById(id.longValue()).filter(PasarelaPago::getActivo);
    }

    @Override
    public PasarelaPago save(PasarelaPago pasarela) {
        return jpaRepository.save(pasarela);
    }

    @Override
    public List<PasarelaPago> findAll() {
        return jpaRepository.findAllByActivoTrueOrderByNombreAsc();
    }

    @Override
    public List<PasarelaPago> findAllByActivoTrue() {
        return findAll();
    }

    @Override
    public void softDeleteById(Integer id) {
        Optional<PasarelaPago> opt = jpaRepository.findById(id.longValue());
        if (opt.isPresent()) {
            PasarelaPago p = opt.get();
            p.setActivo(false);
            jpaRepository.save(p);
        } else {
            throw new RuntimeException("Pasarela no encontrada");
        }
    }

    @Override
    public void deleteById(Integer id) {
        softDeleteById(id);
    }
}
