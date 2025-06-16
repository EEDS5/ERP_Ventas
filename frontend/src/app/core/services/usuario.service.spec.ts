import { TestBed } from '@angular/core/testing';
import { UsuarioService } from './usuario.service';
import { UsuarioApiService } from '../../infrastructure/api/usuario/usuario-api.service';
import { of } from 'rxjs';
import { Usuario } from '../models/auth/usuario.model';

describe('UsuarioService', () => {
  let service: UsuarioService;
  let mockUsuarioApi: jasmine.SpyObj<UsuarioApiService>;

  beforeEach(() => {
    mockUsuarioApi = jasmine.createSpyObj('UsuarioApiService', ['obtenerUsuarios']);
    TestBed.configureTestingModule({
      providers: [
        UsuarioService,
        { provide: UsuarioApiService, useValue: mockUsuarioApi }
      ]
    });
    service = TestBed.inject(UsuarioService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should filter and return only active users', (done) => {
    const usuariosMock: Usuario[] = [
      {
        usuarioID: 1,
        nombreUsuario: 'Activo1',
        email: 'a1@example.com',
        twoFAEnabled: false,
        fechaRegistro: '2025-01-01T00:00:00Z',
        activo: true
      },
      {
        usuarioID: 2,
        nombreUsuario: 'Inactivo',
        email: 'i@example.com',
        twoFAEnabled: true,
        fechaRegistro: '2025-01-02T00:00:00Z',
        activo: false
      },
      {
        usuarioID: 3,
        nombreUsuario: 'Activo2',
        email: 'a2@example.com',
        twoFAEnabled: true,
        fechaRegistro: '2025-01-03T00:00:00Z',
        activo: true
      }
    ];

    mockUsuarioApi.obtenerUsuarios.and.returnValue(of(usuariosMock));

    service.listarActivos().subscribe(result => {
      expect(result.length).toBe(2);
      expect(result.every(u => u.activo)).toBeTrue();
      expect(result.map(u => u.usuarioID)).toEqual([1, 3]);
      done();
    });
  });
});
