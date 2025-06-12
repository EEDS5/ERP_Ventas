import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Producto } from '../../../core/models/productos/producto.model';
import { CreateProductoDTO } from '../../../core/models/productos/create-producto-dto.model';
import { UpdateProductoDTO } from '../../../core/models/productos/update-producto-dto.model';

@Injectable({ providedIn: 'root' })
export class ProductosApiService {
  private baseUrl = '/api/productos';

  constructor(private http: HttpClient) {}

  obtenerProductos(): Observable<Producto[]> {
    return this.http.get<Producto[]>(this.baseUrl);
  }

  obtenerProducto(id: number): Observable<Producto> {
    return this.http.get<Producto>(`${this.baseUrl}/${id}`);
  }

  crearProducto(dto: CreateProductoDTO): Observable<Producto> {
    return this.http.post<Producto>(this.baseUrl, dto);
  }

  actualizarProducto(
    id: number,
    dto: UpdateProductoDTO,
  ): Observable<Producto> {
    return this.http.put<Producto>(`${this.baseUrl}/${id}`, dto);
  }

  eliminarProducto(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`, {
      responseType: 'text' as 'json',
    });
  }
}
