package com.proyecto.erpventas.application.usecases.cliente;

import com.proyecto.erpventas.application.dto.request.cliente.CreateClienteDTO;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.cliente.ClienteRepository;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;

import org.springframework.stereotype.Service;

@Service
public class CreateClienteUseCase {

    private final ClienteRepository clienteRepository;
    private final UserRepository userRepository;

    public CreateClienteUseCase(ClienteRepository clienteRepository, UserRepository userRepository) {
        this.clienteRepository = clienteRepository;
        this.userRepository = userRepository;
    }

    public Cliente create(CreateClienteDTO dto) {
        if (clienteRepository.existsByCorreo(dto.getCorreo())) {
            throw new RuntimeException("Ya existe un cliente con ese correo");
        }
        Usuario creador = userRepository.findById(dto.getCreadoPorUsuarioId())
                .orElseThrow(() -> new RuntimeException("Usuario creador no encontrado"));

        Cliente cliente = new Cliente();
        cliente.setNombre(dto.getNombre());
        cliente.setCorreo(dto.getCorreo());
        cliente.setTelefono(dto.getTelefono());
        cliente.setDireccion(dto.getDireccion());
        cliente.setCreadoPorUsuario(creador);
        // activo y fechaRegistro se setean por defecto
        return clienteRepository.save(cliente);
    }
}