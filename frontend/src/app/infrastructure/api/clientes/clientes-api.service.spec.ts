import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { ClientesApiService } from './clientes-api.service';
import { Cliente } from 'src/app/core/models/clientes/cliente.model';

describe('ClientesApiService', () => {
  let service: ClientesApiService;
  let http: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [ClientesApiService]
    });
    service = TestBed.inject(ClientesApiService);
    http = TestBed.inject(HttpTestingController);
  });

  afterEach(() => http.verify());

  it('obtenerClientes() debe hacer GET a /api/clientes', () => {
    const dummy: Cliente[] = [{ clienteId: 1, nombre: 'C' }];
    service.obtenerClientes().subscribe(res => expect(res).toEqual(dummy));

    const req = http.expectOne(r => r.url.endsWith('/api/clientes'));
    expect(req.request.method).toBe('GET');
    req.flush(dummy);
  });
});
