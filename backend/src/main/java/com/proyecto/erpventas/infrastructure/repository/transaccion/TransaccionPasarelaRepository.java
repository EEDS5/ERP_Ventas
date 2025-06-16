package com.proyecto.erpventas.infrastructure.repository.transaccion;

import com.proyecto.erpventas.domain.model.sales.TransaccionPasarela;
import java.util.List;
import java.util.Optional;

public interface TransaccionPasarelaRepository {
    TransaccionPasarela save(TransaccionPasarela tx);
    Optional<TransaccionPasarela> findById(Integer id);
    List<TransaccionPasarela> findAll();
    List<TransaccionPasarela> findAllByActivoTrue();
    void deleteById(Integer id);
    void softDeleteById(Integer id);
}
