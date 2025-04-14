package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.CreateFacturaDTO;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.domain.model.sales.Factura;
import com.proyecto.erpventas.domain.model.sales.Venta;
import com.proyecto.erpventas.infrastructure.repository.*;
import org.springframework.stereotype.Service;

@Service
public class CreateFacturaUseCase {

    private final FacturaRepository facturaRepository;
    private final VentaRepository ventaRepository;
    private final UserRepository userRepository;

    public CreateFacturaUseCase(FacturaRepository facturaRepository,
                                VentaRepository ventaRepository,
                                UserRepository userRepository) {
        this.facturaRepository = facturaRepository;
        this.ventaRepository = ventaRepository;
        this.userRepository = userRepository;
    }

    public Factura create(CreateFacturaDTO dto) {
        if (facturaRepository.existsByNumeroFactura(dto.getNumeroFactura())) {
            throw new RuntimeException("Ya existe una factura con ese número");
        }
        Venta venta = ventaRepository.findById(dto.getVentaId())
                .orElseThrow(() -> new RuntimeException("Venta no encontrada"));
        if (facturaRepository.findByNumeroFactura(venta.getVentaId().toString()).isPresent()) {
            // Optional: validar que la venta no tenga ya factura
        }
        Usuario creador = userRepository.findById(dto.getCreadoPorUsuarioId())
                .orElseThrow(() -> new RuntimeException("Usuario creador no encontrado"));

        Factura f = new Factura();
        f.setVenta(venta);
        f.setNumeroFactura(dto.getNumeroFactura());
        f.setXmlFactura(dto.getXmlFactura());
        f.setCreadoPorUsuario(creador);
        return facturaRepository.save(f);
    }
}