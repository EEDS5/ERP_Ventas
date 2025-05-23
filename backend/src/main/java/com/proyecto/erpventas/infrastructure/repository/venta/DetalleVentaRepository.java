package com.proyecto.erpventas.infrastructure.repository.venta;

import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import java.util.List;
import java.util.Optional;

public interface DetalleVentaRepository {
    DetalleVenta save(DetalleVenta detalle);
    DetalleVenta saveAndFlush(DetalleVenta detalle);
    Optional<DetalleVenta> findById(Integer id);
    List<DetalleVenta> findAll();
    List<DetalleVenta> findAllByVenta(Integer ventaId);
    void deleteById(Integer id); // borrado lógico
    void softDeleteById(Integer id);
}