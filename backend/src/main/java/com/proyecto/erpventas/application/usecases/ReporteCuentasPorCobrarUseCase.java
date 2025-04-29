package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.response.CuentaPorCobrarResponse;
import com.proyecto.erpventas.domain.service.CuentaPorCobrarRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ReporteCuentasPorCobrarUseCase {

    private final CuentaPorCobrarRepository cuentaPorCobrarRepository;

    public ReporteCuentasPorCobrarUseCase(CuentaPorCobrarRepository cuentaPorCobrarRepository) {
        this.cuentaPorCobrarRepository = cuentaPorCobrarRepository;
    }

    public List<CuentaPorCobrarResponse> obtenerReporteCuentasPorCobrar() {
        return cuentaPorCobrarRepository.obtenerReporteCuentasPorCobrar();
    }
}