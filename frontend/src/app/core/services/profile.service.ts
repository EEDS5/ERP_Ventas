// frontend/src/app/core/services/profile.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { PROFILE_API } from '@core/config/profile.config';
import { Observable, switchMap, take, throwError } from 'rxjs';
import { Usuario } from '@core/models/auth/usuario.model';
import { AuthService } from '@core/services/auth.service';

@Injectable({
  providedIn: 'root',
})
export class ProfileService {
  constructor(
    private readonly http: HttpClient,
    private readonly authService: AuthService
  ) {}

  /**
   * Obtiene los datos del usuario actualmente autenticado,
   * usando el usuarioID que expone AuthService.
   */
  getMyProfile(): Observable<Usuario> {
    // authService.user$ es un Observable<Usuario|null> con la info que guardamos en AuthService al hacer login.
    // Hacemos take(1) para obtener solo el valor actual; luego switchMap a la llamada HTTP.
    return this.authService.user$.pipe(
      take(1),
      switchMap((user) => {
        if (user && user.usuarioID) {
          const url = PROFILE_API.GET_BY_ID(user.usuarioID);
          return this.http.get<Usuario>(url);
        } else {
          // Si por alguna razón no hay usuario logueado en AuthService,
          // devolvemos un Observable que emita error:
          return throwError(() => new Error('No hay usuario autenticado'));
        }
      })
    );
  }

  /**
   * Actualiza los datos básicos del perfil del usuario autenticado
   * (por ejemplo, nombreUsuario y email), usando el usuarioID.
   */
  updateMyProfile(payload: Partial<Usuario>): Observable<Usuario> {
    return this.authService.user$.pipe(
      take(1),
      switchMap((user) => {
        if (user && user.usuarioID) {
          const url = PROFILE_API.UPDATE_BY_ID(user.usuarioID);
          return this.http.put<Usuario>(url, payload);
        } else {
          return throwError(() => new Error('No hay usuario autenticado'));
        }
      })
    );
  }
}
