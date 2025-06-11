package com.proyecto.erpventas.infrastructure.controller;

import com.proyecto.erpventas.application.dto.response.venta.VentaResponseDTO;
import com.proyecto.erpventas.application.usecases.venta.ListVentasUseCase;
import com.proyecto.erpventas.domain.model.sales.Venta;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/ventas")
public class VentaController {

    private final ListVentasUseCase listVentasUseCase;

    public VentaController(ListVentasUseCase listVentasUseCase) {
        this.listVentasUseCase = listVentasUseCase;
    }

    @GetMapping
    public ResponseEntity<List<VentaResponseDTO>> getAll() {
        List<Venta> ventas = listVentasUseCase.listAll();
        List<VentaResponseDTO> response = ventas.stream().map(v -> new VentaResponseDTO(
                v.getVentaId(),
                v.getCliente().getClienteId(),
                v.getCliente().getNombre(),
                v.getFechaVenta(),
                v.getTotal(),
                v.getMetodoPago().getMetodoPagoId(),
                v.getMetodoPago().getNombre(),
                v.getCreadoPorUsuario().getUsuarioID(),
                v.getCreadoPorUsuario().getNombreUsuario(),
                v.getActivo()
        )).toList();
        return ResponseEntity.ok(response);
    }
}
