package com.proyecto.erpventas.application.usecases.cliente;

import com.proyecto.erpventas.application.dto.request.cliente.CreateClienteDTO;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.cliente.ClienteRepository;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class CreateClienteUseCaseTest {

    @Test
    void createCliente_deberiaPersistirYRetornarCliente() {
        ClienteRepository clienteRepo = mock(ClienteRepository.class);
        UserRepository userRepo = mock(UserRepository.class);
        CreateClienteUseCase useCase = new CreateClienteUseCase(clienteRepo, userRepo);

        CreateClienteDTO dto = new CreateClienteDTO();
        dto.setNombre("Juan");
        dto.setCorreo("juan@example.com");
        dto.setTelefono("123");
        dto.setDireccion("dir");
        dto.setCreadoPorUsuarioId(5);

        Usuario creador = new Usuario();
        creador.setUsuarioID(5);
        when(userRepo.findById(5)).thenReturn(Optional.of(creador));
        when(clienteRepo.existsByCorreo("juan@example.com")).thenReturn(false);

        Cliente saved = new Cliente();
        saved.setClienteId(1);
        saved.setNombre("Juan");
        when(clienteRepo.save(any(Cliente.class))).thenReturn(saved);

        Cliente result = useCase.create(dto);

        assertThat(result.getClienteId()).isEqualTo(1);
        assertThat(result.getNombre()).isEqualTo("Juan");
        verify(clienteRepo).save(any(Cliente.class));
    }

    @Test
    void createCliente_correoExistente_deberiaLanzarExcepcion() {
        ClienteRepository clienteRepo = mock(ClienteRepository.class);
        UserRepository userRepo = mock(UserRepository.class);
        CreateClienteUseCase useCase = new CreateClienteUseCase(clienteRepo, userRepo);

        CreateClienteDTO dto = new CreateClienteDTO();
        dto.setCorreo("dup@example.com");
        when(clienteRepo.existsByCorreo("dup@example.com")).thenReturn(true);

        assertThrows(RuntimeException.class, () -> useCase.create(dto));
        verify(clienteRepo, never()).save(any());
    }
}
