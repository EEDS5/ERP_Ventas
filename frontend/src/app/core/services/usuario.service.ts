import { Injectable } from '@angular/core';
import { UsuarioApiService } from '../../infrastructure/api/usuario-api.service';
import { Observable } from 'rxjs';
import { Usuario } from '../models/auth/usuario.model';
import { map } from 'rxjs/operators';

@Injectable({ providedIn: 'root' })
export class UsuarioService {
  constructor(private usuarioApi: UsuarioApiService) {}

  listarActivos(): Observable<Usuario[]> {
    return this.usuarioApi.obtenerUsuarios().pipe(
      map((usuarios: Usuario[]) => usuarios.filter((u: Usuario) => u.activo))
    );
  }
}
// Este servicio se encarga de filtrar los usuarios activos a través del método listarActivos().
