import { Injectable } from '@angular/core';
import { UsuarioApiService, JwtResponseDTO } from '../../infrastructure/api/usuario/usuario-api.service';
import { Observable, BehaviorSubject } from 'rxjs';
import { Usuario } from '../models/auth/usuario.model';
import { isTokenValid } from '../helpers/jwt.helper';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private _user = new BehaviorSubject<Usuario | null>(null);
  public user$ = this._user.asObservable();

  constructor(private usuarioApi: UsuarioApiService) {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      this._user.next(JSON.parse(storedUser));
    }
  }

  isLoggedIn(): boolean {
    const token = localStorage.getItem('token');
    return !!token && isTokenValid(token);
  }

  login(nombreUsuario: string, password: string): Observable<JwtResponseDTO> {
    return this.usuarioApi.login({ nombreUsuario, password });
  }

  login2FA(nombreUsuario: string, token2FA: string): Observable<JwtResponseDTO> {
    return this.usuarioApi.login2FA({ nombreUsuario, token2FA });
  }

  register(nombreUsuario: string, email: string, password: string): Observable<JwtResponseDTO> {
    return this.usuarioApi.register({ nombreUsuario, email, password });
  }

  logout(): void {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    this._user.next(null);
  }

  setUser(usuario: Usuario) {
    this._user.next(usuario);
    localStorage.setItem('user', JSON.stringify(usuario));
  }

  getUser(): Usuario | null {
    return this._user.getValue();
  }
}
