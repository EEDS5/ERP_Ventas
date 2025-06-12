package com.proyecto.erpventas.application.usecases.cliente;

import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.infrastructure.repository.cliente.ClienteRepository;

import org.springframework.stereotype.Service;

@Service
public class DeleteClienteUseCase {

    private final ClienteRepository clienteRepository;

    public DeleteClienteUseCase(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    public void delete(Integer id) {
        Cliente existing = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado"));
        existing.setActivo(false);
        clienteRepository.save(existing);
    }
}