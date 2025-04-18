package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.request.CreateClienteDTO;
import com.proyecto.erpventas.application.dto.request.UpdateClienteDTO;
import com.proyecto.erpventas.application.dto.response.ClienteResponseDTO;
import com.proyecto.erpventas.application.usecases.*;
import com.proyecto.erpventas.domain.model.people.Cliente;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/clients")
public class ClienteController {

    private final CreateClienteUseCase createUC;
    private final ListClientesUseCase listUC;
    private final GetClienteByIdUseCase getByIdUC;
    private final UpdateClienteUseCase updateUC;
    private final DeleteClienteUseCase deleteUC;

    public ClienteController(CreateClienteUseCase createUC,
                             ListClientesUseCase listUC,
                             GetClienteByIdUseCase getByIdUC,
                             UpdateClienteUseCase updateUC,
                             DeleteClienteUseCase deleteUC) {
        this.createUC = createUC;
        this.listUC = listUC;
        this.getByIdUC = getByIdUC;
        this.updateUC = updateUC;
        this.deleteUC = deleteUC;
    }

    @GetMapping
    public ResponseEntity<List<ClienteResponseDTO>> getAll() {
        List<Cliente> clientes = listUC.listAll();
        List<ClienteResponseDTO> response = clientes.stream().map(c -> new ClienteResponseDTO(
                c.getClienteId(),
                c.getNombre(),
                c.getCorreo(),
                c.getTelefono(),
                c.getDireccion(),
                c.getFechaRegistro(),
                c.getActivo()
        )).toList();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClienteResponseDTO> getById(@PathVariable Integer id) {
        Cliente c = getByIdUC.getById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado o inactivo"));
        ClienteResponseDTO dto = new ClienteResponseDTO(
                c.getClienteId(),
                c.getNombre(),
                c.getCorreo(),
                c.getTelefono(),
                c.getDireccion(),
                c.getFechaRegistro(),
                c.getActivo()
        );
        return ResponseEntity.ok(dto);
    }

    @PostMapping
    public ResponseEntity<ClienteResponseDTO> create(@Valid @RequestBody CreateClienteDTO dto) {
        Cliente created = createUC.create(dto);
        ClienteResponseDTO response = new ClienteResponseDTO(
                created.getClienteId(),
                created.getNombre(),
                created.getCorreo(),
                created.getTelefono(),
                created.getDireccion(),
                created.getFechaRegistro(),
                created.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClienteResponseDTO> update(@PathVariable Integer id, @Valid @RequestBody UpdateClienteDTO dto) {
        Cliente updated = updateUC.update(id, dto);
        ClienteResponseDTO response = new ClienteResponseDTO(
                updated.getClienteId(),
                updated.getNombre(),
                updated.getCorreo(),
                updated.getTelefono(),
                updated.getDireccion(),
                updated.getFechaRegistro(),
                updated.getActivo()
        );
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {
        deleteUC.delete(id);
        return ResponseEntity.ok("Cliente eliminado correctamente (borrado lógico)");
    }
}
