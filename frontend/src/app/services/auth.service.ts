// src/app/services/auth.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private baseUrl = 'http://localhost:8080/api/users';

  constructor(private http: HttpClient) {}

  register(data: any): Observable<any> {
    return this.http.post(`${this.baseUrl}/register`, data);
  }

  login(data: any): Observable<any> {
    return this.http.post(`${this.baseUrl}/login`, data, {responseType: 'text'});
  }

  verify2FA(data: any): Observable<any> {
    return this.http.post(`${this.baseUrl}/verify-2fa`, data, 
                          {responseType: 'text'});
  }
}
