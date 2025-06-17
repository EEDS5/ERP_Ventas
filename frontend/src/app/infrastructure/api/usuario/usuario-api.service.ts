import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Usuario } from '../../../core/models/auth/usuario.model';
import { TwoFactorSetupResponseDTO } from '../../../core/models/auth/twofactor-setup-response.dto';
import { UpdateUserDTO } from '../../../core/models/auth/update-user-dto.model';
import { UpdateUserPasswordDTO } from '../../../core/models/auth/update-user-password-dto.model';

export interface RegisterUserDTO {
  nombreUsuario: string;
  email: string;
  password: string;
}

export interface LoginUserDTO {
  nombreUsuario: string;
  password: string;
}

export interface TwoFactorVerificationDTO {
  nombreUsuario: string;
  token2FA: string;
}

export interface JwtResponseDTO {
  token: string;
  user: {
    usuarioID: number;
    nombreUsuario: string;
    email: string;
    twoFAEnabled: boolean;
    fechaRegistro: string;
    activo: boolean;
  };
}

@Injectable({ providedIn: 'root' })
export class UsuarioApiService {
  private apiUrl = '/api/auth';
  private usersUrl = '/api/users';

  constructor(private http: HttpClient) {}

  register(user: RegisterUserDTO): Observable<JwtResponseDTO> {
    return this.http.post<JwtResponseDTO>(`${this.apiUrl}/register`, user);
  }

  // Devuelve el DTO { token: string } con el campo `token`
  login(user: LoginUserDTO): Observable<JwtResponseDTO> {
    return this.http.post<JwtResponseDTO>(`${this.apiUrl}/login`, user);
  }

  login2FA(data: TwoFactorVerificationDTO): Observable<JwtResponseDTO> {
    return this.http.post<JwtResponseDTO>(`${this.apiUrl}/login-2fa`, data);
  }

  verify2FA(data: TwoFactorVerificationDTO): Observable<string> {
    return this.http.post(`${this.apiUrl}/verify-2fa`, data, { responseType: 'text' });
  }

  generate2FASecret(username: string): Observable<TwoFactorSetupResponseDTO> {
    return this.http.post<TwoFactorSetupResponseDTO>(
      `${this.apiUrl}/2fa-secret?username=${username}`,
      {},
    );
  }

  // Método adicional que falta: obtenerUsuarios()
  obtenerUsuarios(): Observable<Usuario[]> {
    return this.http.get<Usuario[]>(`${this.usersUrl}`);
    // Endpoint que debe existir en tu backend.
  }

  updateUsuario(id: number, dto: UpdateUserDTO): Observable<Usuario> {
    return this.http.put<Usuario>(`/api/users/${id}`, dto);
  }

  cambiarPassword(id: number, dto: UpdateUserPasswordDTO): Observable<void> {
    return this.http.put<void>(`/api/users/${id}/password`, dto);
  }

  eliminarUsuario(id: number): Observable<string> {
    return this.http.delete(`/api/users/${id}`, { responseType: 'text' });
  }

  restaurarUsuario(id: number): Observable<Usuario> {
    return this.http.put<Usuario>(`/api/users/activate/${id}`, {});
  }
}
