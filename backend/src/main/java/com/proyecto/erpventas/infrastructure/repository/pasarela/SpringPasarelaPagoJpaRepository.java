package com.proyecto.erpventas.infrastructure.repository.pasarela;

import com.proyecto.erpventas.domain.model.inventory.PasarelaPago;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SpringPasarelaPagoJpaRepository extends JpaRepository<PasarelaPago, Long> {
    Optional<PasarelaPago> findByNombre(String nombre);
    List<PasarelaPago> findAllByActivoTrueOrderByNombreAsc();
}
