import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CategoriaProducto } from '../../../core/models/productos/categoria-producto.model';
import { CreateCategoriaProductoDTO } from '../../../core/models/productos/create-categoria-producto-dto.model';
import { UpdateCategoriaProductoDTO } from '../../../core/models/productos/update-categoria-producto-dto.model';

@Injectable({ providedIn: 'root' })
export class CategoriasProductoApiService {
  private baseUrl = '/api/categorias';

  constructor(private http: HttpClient) {}

  obtenerCategorias(): Observable<CategoriaProducto[]> {
    return this.http.get<CategoriaProducto[]>(this.baseUrl);
  }

  obtenerCategoria(id: number): Observable<CategoriaProducto> {
    return this.http.get<CategoriaProducto>(`${this.baseUrl}/${id}`);
  }

  crearCategoria(dto: CreateCategoriaProductoDTO): Observable<CategoriaProducto> {
    return this.http.post<CategoriaProducto>(this.baseUrl, dto);
  }

  actualizarCategoria(
    id: number,
    dto: UpdateCategoriaProductoDTO,
  ): Observable<CategoriaProducto> {
    return this.http.put<CategoriaProducto>(`${this.baseUrl}/${id}`, dto);
  }

  eliminarCategoria(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}
