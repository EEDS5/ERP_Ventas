package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.infrastructure.repository.ClienteRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ListClientesUseCase {

    private final ClienteRepository clienteRepository;

    public ListClientesUseCase(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    public List<Cliente> listAll() {
        return clienteRepository.findAllByActivoTrue();
    }
}