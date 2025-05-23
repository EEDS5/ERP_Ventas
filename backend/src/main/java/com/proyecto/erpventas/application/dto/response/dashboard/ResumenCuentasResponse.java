package com.proyecto.erpventas.application.dto.response.dashboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import java.math.BigDecimal;
import java.util.Map;

@Getter
@AllArgsConstructor
public class ResumenCuentasResponse {
    private BigDecimal totalPendiente;
    private Integer cantidadClientesDeudores;
    private Map<String, Integer> estadoCuentas;
}