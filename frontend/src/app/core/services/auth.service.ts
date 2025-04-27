import { Injectable } from '@angular/core';
import { UsuarioApiService, JwtResponseDTO } from '../../infrastructure/api/usuario-api.service';
import { Observable } from 'rxjs';
import { Usuario } from '../../core/models/usuario.model';

@Injectable({ providedIn: 'root' })
export class AuthService {
  constructor(private usuarioApi: UsuarioApiService) {}

  isLoggedIn(): boolean {
    const token = localStorage.getItem('token');
    return !!token;
  }

  login(nombreUsuario: string, password: string): Observable<string> {
    return this.usuarioApi.login({ nombreUsuario, password });
  }

  login2FA(nombreUsuario: string, token2FA: string): Observable<JwtResponseDTO> {
    return this.usuarioApi.login2FA({ nombreUsuario, token2FA });
  }

  register(nombreUsuario: string, email: string, password: string): Observable<Usuario> {
    return this.usuarioApi.register({ nombreUsuario, email, password });
  }

  logout(): void {
    localStorage.removeItem('token');
  }
}
