import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Venta } from '../../../core/models/ventas/venta.model';
import { CreateVentaDTO } from '../../../core/models/ventas/create-venta-dto.model';
import { UpdateVentaDTO } from '../../../core/models/ventas/update-venta-dto.model';

@Injectable({ providedIn: 'root' })
export class VentasApiService {
  private baseUrl = '/api/ventas';

  constructor(private http: HttpClient) {}

  obtenerVentas(): Observable<Venta[]> {
    return this.http.get<Venta[]>(this.baseUrl);
  }

  obtenerVenta(id: number): Observable<Venta> {
    return this.http.get<Venta>(`${this.baseUrl}/${id}`);
  }

  crearVenta(dto: CreateVentaDTO): Observable<Venta> {
    return this.http.post<Venta>(this.baseUrl, dto);
  }

  actualizarVenta(id: number, dto: UpdateVentaDTO): Observable<Venta> {
    return this.http.put<Venta>(`${this.baseUrl}/${id}`, dto);
  }

  eliminarVenta(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`, {
      responseType: 'text' as 'json',
    });
  }
}
