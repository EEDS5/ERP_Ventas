package com.proyecto.erpventas.infrastructure.controller.MetodoPago;

import com.proyecto.erpventas.application.dto.response.metodopago.MetodoPagoResponseDTO;
import com.proyecto.erpventas.application.usecases.inventory.ListMetodosPagoUseCase;
import com.proyecto.erpventas.domain.model.inventory.MetodoPago;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/metodos-pago")
public class MetodoPagoController {

    private final ListMetodosPagoUseCase listUC;

    public MetodoPagoController(ListMetodosPagoUseCase listUC) {
        this.listUC = listUC;
    }

    @GetMapping
    public ResponseEntity<List<MetodoPagoResponseDTO>> getAll() {
        List<MetodoPago> metodos = listUC.listAll();
        List<MetodoPagoResponseDTO> dto = metodos.stream()
            .map(m -> new MetodoPagoResponseDTO(
                m.getMetodoPagoId(),
                m.getNombre(),
                m.getActivo()
            ))
            .toList();
        return ResponseEntity.ok(dto);
    }
}
