import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Cliente } from 'src/app/core/models/clientes/cliente.model';
import { CreateClienteDTO } from 'src/app/core/models/clientes/create-cliente-dto.model';
import { UpdateClienteDTO } from 'src/app/core/models/clientes/update-cliente-dto.model';

@Injectable({ providedIn: 'root' })
export class ClientesApiService {
  private baseUrl = '/api/clientes';

  constructor(private http: HttpClient) {}

  obtenerClientes(): Observable<Cliente[]> {
    return this.http.get<Cliente[]>(this.baseUrl);
  }

  obtenerCliente(id: number): Observable<Cliente> {
    return this.http.get<Cliente>(`${this.baseUrl}/${id}`);
  }

  crearCliente(dto: CreateClienteDTO): Observable<Cliente> {
    return this.http.post<Cliente>(this.baseUrl, dto);
  }

  actualizarCliente(id: number, dto: UpdateClienteDTO): Observable<Cliente> {
    return this.http.put<Cliente>(`${this.baseUrl}/${id}`, dto);
  }

  eliminarCliente(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}
