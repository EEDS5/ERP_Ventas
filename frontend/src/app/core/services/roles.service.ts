import { Injectable } from '@angular/core';
import { LocalStorageService } from 'src/app/infrastructure/storage/local-storage.service';
import { isTokenValid } from '../helpers/jwt.helper';
import { jwtDecode } from 'jwt-decode';

interface JwtPayloadConRoles {
  exp: number;
  roles?: string[];
  [key: string]: unknown;
}

@Injectable({ providedIn: 'root' })
export class RolesService {
  private roles: string[] = [];

  constructor(private localStorage: LocalStorageService) {}

  loadRolesFromToken(): Promise<void> {
    return new Promise((resolve) => {
      const token = this.localStorage.getToken();
      if (token && isTokenValid(token)) {
        const payload = jwtDecode<JwtPayloadConRoles>(token);
        this.roles = payload.roles || [];
      } else {
        this.roles = [];
      }
      resolve();
    });
  }

  hasRole(rol: string): boolean {
    return this.roles.includes(rol);
  }

  hasAnyRole(rolesPermitidos: string[]): boolean {
    return rolesPermitidos.some((r) => this.roles.includes(r));
  }

  getAll(): string[] {
    return this.roles;
  }
}
