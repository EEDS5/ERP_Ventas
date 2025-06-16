import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Venta } from '../../../core/models/ventas/venta.model';
/* import { CreateVentaDTO } from '../../../core/models/ventas/create-venta-dto.model'; */
/* import { UpdateVentaDTO } from '../../../core/models/ventas/update-venta-dto.model'; */
import { VentaCompleta } from '../../../core/models/ventas/venta-completa.model';
import { CreateVentaCompletaDTO } from '../../../core/models/ventas/create-venta-completa-dto.model';
import { UpdateVentaCompletaDTO } from '../../../core/models/ventas/update-venta-completa-dto.model';

@Injectable({ providedIn: 'root' })
export class VentasApiService {
  private baseUrl = '/api/ventas';

  constructor(private http: HttpClient) {}

  obtenerVentas(): Observable<Venta[]> {
    return this.http.get<Venta[]>(this.baseUrl);
  }

  obtenerVenta(id: number): Observable<VentaCompleta> {
    return this.http.get<VentaCompleta>(`${this.baseUrl}/completa/${id}`);
  }

  /** Trae la venta con todos sus detalles */
  obtenerVentaCompleta(id: number): Observable<VentaCompleta> {
    return this.http.get<VentaCompleta>(`${this.baseUrl}/completa/${id}`);
  }

  /* crearVenta(dto: CreateVentaDTO): Observable<Venta> {
    return this.http.post<Venta>(this.baseUrl, dto);
  } */

  crearVentaCompleta(dto: CreateVentaCompletaDTO): Observable<VentaCompleta> {
    return this.http.post<VentaCompleta>(`${this.baseUrl}/completa`, dto);
  }

  /* actualizarVenta(id: number, dto: UpdateVentaDTO): Observable<Venta> {
    return this.http.put<Venta>(`${this.baseUrl}/${id}`, dto);
  } */

  actualizarVentaCompleta(
    id: number,
    dto: UpdateVentaCompletaDTO,
  ): Observable<VentaCompleta> {
    return this.http.put<VentaCompleta>(`${this.baseUrl}/completa/${id}`, dto);
  }

  eliminarVenta(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`, {
      responseType: 'text' as 'json',
    });
  }

  activarVenta(id: number): Observable<string> {
    return this.http.put(`${this.baseUrl}/activate/${id}`, {}, {
      responseType: 'text' });
  }
}
