import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CategoriaProducto } from 'src/app/core/models/productos/categoria-producto.model';
import { CreateCategoriaDTO } from 'src/app/core/models/productos/create-categoria-dto.model';
import { UpdateCategoriaDTO } from 'src/app/core/models/productos/update-categoria-dto.model';

@Injectable({ providedIn: 'root' })
export class CategoriasApiService {
  private baseUrl = '/api/categorias-producto';

  constructor(private http: HttpClient) {}

  obtenerCategorias(): Observable<CategoriaProducto[]> {
    return this.http.get<CategoriaProducto[]>(this.baseUrl);
  }

  crearCategoria(dto: CreateCategoriaDTO): Observable<CategoriaProducto> {
    return this.http.post<CategoriaProducto>(this.baseUrl, dto);
  }

  actualizarCategoria(id: number, dto: UpdateCategoriaDTO): Observable<CategoriaProducto> {
    return this.http.put<CategoriaProducto>(`${this.baseUrl}/${id}`, dto);
  }

  eliminarCategoria(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`, { responseType: 'text' as 'json' });
  }

  /** Restaura una categoría inactiva */
  restoreCategoria(id: number): Observable<CategoriaProducto> {
    return this.http.put<CategoriaProducto>(`${this.baseUrl}/restore/${id}`, {});
  }
}
