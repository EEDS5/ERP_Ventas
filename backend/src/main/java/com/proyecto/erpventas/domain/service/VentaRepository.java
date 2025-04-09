package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.domain.model.sales.Venta;
import java.util.List;

public interface VentaRepository {
    List<Venta> obtenerVentasActivasConCliente();
}