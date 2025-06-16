package com.proyecto.erpventas.infrastructure.repository.transaccion;

import com.proyecto.erpventas.domain.model.sales.TransaccionPasarela;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SpringTransaccionPasarelaJpaRepository extends JpaRepository<TransaccionPasarela, Long> {
    List<TransaccionPasarela> findAllByActivoTrueOrderByFechaTransaccionDesc();
}
