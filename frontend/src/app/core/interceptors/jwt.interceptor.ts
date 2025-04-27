import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';
import { LocalStorageService } from '../../infrastructure/storage/local-storage.service';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
  constructor(private localStorage: LocalStorageService) {}

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const token = this.localStorage.getToken();
    if (token) {
      req = req.clone({
        setHeaders: { Authorization: `Bearer ${token}` }
      });
    }
    return next.handle(req);
  }
}
// This interceptor adds the JWT token to the Authorization header of outgoing HTTP requests if the token is present in local storage.
