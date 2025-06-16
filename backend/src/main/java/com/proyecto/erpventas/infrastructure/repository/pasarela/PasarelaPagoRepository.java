package com.proyecto.erpventas.infrastructure.repository.pasarela;

import com.proyecto.erpventas.domain.model.inventory.PasarelaPago;
import java.util.List;
import java.util.Optional;

public interface PasarelaPagoRepository {
    Optional<PasarelaPago> findByNombre(String nombre);
    Optional<PasarelaPago> findById(Integer id);
    PasarelaPago save(PasarelaPago pasarela);
    List<PasarelaPago> findAll();
    List<PasarelaPago> findAllByActivoTrue();
    void deleteById(Integer id);
    void softDeleteById(Integer id);
}
