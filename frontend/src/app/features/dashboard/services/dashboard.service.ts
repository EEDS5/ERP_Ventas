import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { VentasHoyResponse } from '@core/models/dashboard/ventas-hoy.model';
import { MesFacturadoResponse } from '@core/models/reportes/facturacion.model';
import { FacturacionActualResponse } from '@core/models/dashboard/facturacion-actual.model';
import { ResumenCuentasResponse } from '@core/models/dashboard/cuentas.model';
import { StockBajoResponse } from '@core/models/dashboard/stock-bajo.model';
import { Usuarios2FAResponse } from '@core/models/dashboard/usuarios-2fa.model';

@Injectable({ providedIn: 'root' })
export class DashboardService {
  private base = '/api/dashboard';

  constructor(private http: HttpClient) {}

  getVentasHoy(): Observable<VentasHoyResponse> {
    return this.http.get<VentasHoyResponse>(`${this.base}/ventas-hoy`);
  }

  getFacturacionActual(): Observable<FacturacionActualResponse> {
    return this.http.get<FacturacionActualResponse>(`${this.base}/facturacion-actual`);
  }

  getResumenCuentas(): Observable<ResumenCuentasResponse> {
    return this.http.get<ResumenCuentasResponse>(`${this.base}/resumen-cuentas`);
  }

  getStockBajo(): Observable<StockBajoResponse> {
    return this.http.get<StockBajoResponse>(`${this.base}/stock-bajo`);
  }

  getUsuarios2FA(): Observable<Usuarios2FAResponse> {
    return this.http.get<Usuarios2FAResponse>(`${this.base}/usuarios-2fa`);
  }

  getFacturacionMensual(): Observable<MesFacturadoResponse[]> {
    return this.http.get<MesFacturadoResponse[]>(
      '/api/reportes/facturacion-mensual',
    );
  }
}
