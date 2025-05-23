package com.proyecto.erpventas.infrastructure.repository.venta;

import com.proyecto.erpventas.domain.model.sales.DetalleVenta;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SpringDetalleVentaJpaRepository extends JpaRepository<DetalleVenta, Long> {
    List<DetalleVenta> findAllByActivoTrueOrderByDetalleIdAsc();
    List<DetalleVenta> findAllByVenta_VentaIdAndActivoTrue(Integer ventaId);
}