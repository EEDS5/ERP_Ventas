package com.proyecto.erpventas.infrastructure.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.proyecto.erpventas.application.dto.request.cliente.CreateClienteDTO;
import com.proyecto.erpventas.application.usecases.cliente.*;
import com.proyecto.erpventas.domain.model.people.Cliente;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = ClienteController.class,
    excludeAutoConfiguration = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
class ClienteControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private CreateClienteUseCase createUC;
    @MockitoBean
    private ListClientesUseCase listUC;
    @MockitoBean
    private GetClienteByIdUseCase getByIdUC;
    @MockitoBean
    private UpdateClienteUseCase updateUC;
    @MockitoBean
    private DeleteClienteUseCase deleteUC;

    @Test
    void getAll_deberiaRetornarLista() throws Exception {
        Cliente cliente = new Cliente();
        cliente.setClienteId(1);
        cliente.setNombre("Juan");
        when(listUC.listAll()).thenReturn(List.of(cliente));

        mockMvc.perform(get("/api/clientes"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].clienteId").value(1))
                .andExpect(jsonPath("$[0].nombre").value("Juan"));

        verify(listUC).listAll();
    }

    @Test
    void create_deberiaRetornarClienteCreado() throws Exception {
        CreateClienteDTO dto = new CreateClienteDTO();
        dto.setNombre("Juan");
        dto.setCorreo("juan@example.com");
        dto.setTelefono("123");
        dto.setDireccion("dir");
        dto.setCreadoPorUsuarioId(5);

        Cliente saved = new Cliente();
        saved.setClienteId(1);
        saved.setNombre("Juan");
        when(createUC.create(any(CreateClienteDTO.class))).thenReturn(saved);

        mockMvc.perform(post("/api/clientes")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.clienteId").value(1))
                .andExpect(jsonPath("$.nombre").value("Juan"));

        verify(createUC).create(any(CreateClienteDTO.class));
    }
}
