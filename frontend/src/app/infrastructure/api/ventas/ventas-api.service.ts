import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Venta } from '../../core/models/ventas/venta.model';

@Injectable({ providedIn: 'root' })
export class VentasApiService {
  private baseUrl = '/api/ventas';

  constructor(private http: HttpClient) {}

  obtenerVentas(): Observable<Venta[]> {
    return this.http.get<Venta[]>(this.baseUrl);
  }
}
