// frontend/src/app/core/services/auth.service.spec.ts
import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { AuthService } from './auth.service';
import { JwtResponseDTO } from '../../infrastructure/api/usuario-api.service';

describe('AuthService', () => {
  let service: AuthService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [AuthService],
    });
    service = TestBed.inject(AuthService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => httpMock.verify());

  it('login() debe hacer POST a /api/auth/login', () => {
    const mockRes: JwtResponseDTO = { token: 'LOGIN_OK' };
    service.login('u', 'p').subscribe((res) => expect(res).toEqual(mockRes));

    const req = httpMock.expectOne((req) => req.url.endsWith('/api/auth/login'));
    expect(req.request.method).toBe('POST');
    expect(req.request.body).toEqual({ nombreUsuario: 'u', password: 'p' });
    req.flush(mockRes);
  });

  it('login2FA() debe hacer POST a /api/auth/login-2fa', () => {
    const mockRes = { token: 'XYZ' };
    service.login2FA('u', 'code').subscribe((res) => expect(res).toEqual(mockRes));

    const req = httpMock.expectOne((req) => req.url.endsWith('/api/auth/login-2fa'));
    expect(req.request.method).toBe('POST');
    expect(req.request.body).toEqual({ nombreUsuario: 'u', token2FA: 'code' });
    req.flush(mockRes);
  });
});
