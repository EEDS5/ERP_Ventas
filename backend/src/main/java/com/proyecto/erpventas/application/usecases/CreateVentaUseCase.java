package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.venta.CreateVentaDTO;
import com.proyecto.erpventas.domain.model.people.Cliente;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.domain.model.sales.MetodoPago;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.infrastructure.repository.*;
import com.proyecto.erpventas.infrastructure.repository.venta.VentaRepository;

import org.springframework.stereotype.Service;

@Service
public class CreateVentaUseCase {

    private final VentaRepository ventaRepository;
    private final ClienteRepository clienteRepository;
    private final MetodoPagoRepository metodoPagoRepository;
    private final UserRepository userRepository;

    public CreateVentaUseCase(VentaRepository ventaRepository,
                              ClienteRepository clienteRepository,
                              MetodoPagoRepository metodoPagoRepository,
                              UserRepository userRepository) {
        this.ventaRepository = ventaRepository;
        this.clienteRepository = clienteRepository;
        this.metodoPagoRepository = metodoPagoRepository;
        this.userRepository = userRepository;
    }

    public Venta create(CreateVentaDTO dto) {
        Cliente cliente = clienteRepository.findById(dto.getClienteId())
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado"));
        MetodoPago metodo = metodoPagoRepository.findById(dto.getMetodoPagoId())
                .orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));
        Usuario creador = userRepository.findById(dto.getCreadoPorUsuarioId())
                .orElseThrow(() -> new RuntimeException("Usuario creador no encontrado"));

        Venta v = new Venta();
        v.setCliente(cliente);
        v.setMetodoPago(metodo);
        v.setTotal(dto.getTotal());
        v.setCreadoPorUsuario(creador);
        return ventaRepository.save(v);
    }
}
