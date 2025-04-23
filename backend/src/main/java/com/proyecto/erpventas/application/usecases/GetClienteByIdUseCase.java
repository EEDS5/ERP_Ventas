package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.infrastructure.repository.ClienteRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class GetClienteByIdUseCase {

    private final ClienteRepository clienteRepository;

    public GetClienteByIdUseCase(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    public Optional<Cliente> getById(Integer id) {
        return clienteRepository.findById(id);
    }
}