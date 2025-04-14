package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.UpdateClienteDTO;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.infrastructure.repository.ClienteRepository;
import org.springframework.stereotype.Service;

@Service
public class UpdateClienteUseCase {

    private final ClienteRepository clienteRepository;

    public UpdateClienteUseCase(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    public Cliente update(Integer id, UpdateClienteDTO dto) {
        Cliente existing = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado"));
        existing.setNombre(dto.getNombre());
        existing.setCorreo(dto.getCorreo());
        existing.setTelefono(dto.getTelefono());
        existing.setDireccion(dto.getDireccion());
        return clienteRepository.save(existing);
    }
}