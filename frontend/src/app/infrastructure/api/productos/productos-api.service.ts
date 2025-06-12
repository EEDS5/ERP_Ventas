import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Producto } from 'src/app/core/models/productos/producto.model';
import { CreateProductoDTO } from 'src/app/core/models/productos/create-producto-dto.model';
import { UpdateProductoDTO } from 'src/app/core/models/productos/update-producto-dto.model';

@Injectable({ providedIn: 'root' })
export class ProductosApiService {
  private baseUrl = '/api/productos';

  constructor(private http: HttpClient) {}

  obtenerProductos(): Observable<Producto[]> {
    return this.http.get<Producto[]>(this.baseUrl);
  }

  crearProducto(dto: CreateProductoDTO): Observable<Producto> {
    return this.http.post<Producto>(this.baseUrl, dto);
  }

  actualizarProducto(id: number, dto: UpdateProductoDTO): Observable<Producto> {
    return this.http.put<Producto>(`${this.baseUrl}/${id}`, dto);
  }

  eliminarProducto(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}
