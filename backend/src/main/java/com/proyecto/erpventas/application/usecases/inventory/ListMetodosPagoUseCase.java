package com.proyecto.erpventas.application.usecases.inventory;

import com.proyecto.erpventas.domain.model.inventory.MetodoPago;
import com.proyecto.erpventas.infrastructure.repository.metodo.MetodoPagoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListMetodosPagoUseCase {

    private final MetodoPagoRepository repo;

    public ListMetodosPagoUseCase(MetodoPagoRepository repo) {
        this.repo = repo;
    }

    public List<MetodoPago> listAll() {
        return repo.findAllByActivoTrue();
    }
}
