import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class ReportesApiService {
  private baseUrl = '/api/reportes';

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
}
