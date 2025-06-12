import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { MetodoPago } from 'src/app/core/models/productos/metodo-pago.model';

@Injectable({ providedIn: 'root' })
export class MetodosPagoApiService {
  private baseUrl = '/api/metodos-pago';

  constructor(private http: HttpClient) {}

  obtenerMetodosPago(): Observable<MetodoPago[]> {
    return this.http.get<MetodoPago[]>(this.baseUrl);
  }
}
