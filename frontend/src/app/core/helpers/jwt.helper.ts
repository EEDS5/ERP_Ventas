// frontend/src/app/core/helpers/jwt.helper.ts
import { jwtDecode } from 'jwt-decode';

export interface JwtPayload {
  exp: number;
  [key: string]: unknown;
}

export function isTokenValid(token: string): boolean {
  try {
    const payload = jwtDecode<JwtPayload>(token);
    const exp = payload.exp;
    const now = Math.floor(Date.now() / 1000);
    return exp > now;
  } catch {
    return false;
  }
}