import { Injectable } from '@angular/core';
import { UsuarioApiService, JwtResponseDTO } from '../../infrastructure/api/usuario-api.service';
import { Observable, BehaviorSubject } from 'rxjs';
import { Usuario } from '../../core/models/usuario.model';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private _user = new BehaviorSubject<Usuario | null>(null);
  public user$ = this._user.asObservable();

  constructor(private usuarioApi: UsuarioApiService) {}

  isLoggedIn(): boolean {
    const token = localStorage.getItem('token');
    return !!token;
  }

  login(nombreUsuario: string, password: string): Observable<JwtResponseDTO> {
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
    this._user.next(null); // limpiar usuario al hacer logout
  }

  setUser(usuario: Usuario) {
    this._user.next(usuario);
  }

  getUser(): Usuario | null {
    return this._user.getValue();
  }
}
