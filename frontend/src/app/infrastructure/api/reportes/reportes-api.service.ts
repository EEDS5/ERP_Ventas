import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

import { VentaPorCliente } from '../../../core/models/reportes/venta-por-cliente.model';
import { MesFacturado } from '../../../core/models/reportes/mes-facturado.model';
import { CuentaPorCobrar } from '../../../core/models/reportes/cuenta-por-cobrar.model';

@Injectable({ providedIn: 'root' })
export class ReportesApiService {
  private baseUrl = 'http://localhost:8080/api/reportes';

  constructor(private http: HttpClient) {}

  /**
   * Descarga el reporte de historial de ventas por cliente en formato PDF.
   * @returns Observable<Blob> con el contenido del PDF.
   */
  descargarReporteVentasPorClientePdf(): Observable<Blob> {
    return this.http.get(`${this.baseUrl}/ventas-por-cliente/pdf`, {
      responseType: 'blob'
    });
  }

  /** Descarga datos de ventas por cliente en JSON. */
  obtenerVentasPorCliente(): Observable<VentaPorCliente[]> {
    return this.http.get<VentaPorCliente[]>(
      `${this.baseUrl}/ventas-por-cliente`
    );
  }

  /**
 * Descarga el reporte de historial de ventas por cliente en formato Excel.
 * @returns Observable<Blob> con el contenido del .xlsx.
 */
descargarReporteVentasPorClienteExcel(): Observable<Blob> {
  return this.http.get(
    `${this.baseUrl}/ventas-por-cliente/excel`,
    { responseType: 'blob' }
  );
}
// Facturación mensual
obtenerFacturacionMensual(): Observable<MesFacturado[]> {
  return this.http.get<MesFacturado[]>(`${this.baseUrl}/facturacion-mensual`);
}
descargarReporteFacturacionPdf(): Observable<Blob> {
  return this.http.get(`${this.baseUrl}/facturacion-mensual/pdf`, { responseType: 'blob' });
}
descargarReporteFacturacionExcel(): Observable<Blob> {
  return this.http.get(`${this.baseUrl}/facturacion-mensual/excel`, { responseType: 'blob' });
}

// Cuentas por cobrar
obtenerCuentasPorCobrar(): Observable<CuentaPorCobrar[]> {
  return this.http.get<CuentaPorCobrar[]>(`${this.baseUrl}/cuentas-por-cobrar`);
}
descargarReporteCuentasPdf(): Observable<Blob> {
  return this.http.get(`${this.baseUrl}/cuentas-por-cobrar/pdf`, { responseType: 'blob' });
}
descargarReporteCuentasExcel(): Observable<Blob> {
  return this.http.get(`${this.baseUrl}/cuentas-por-cobrar/excel`, { responseType: 'blob' });

}
}
