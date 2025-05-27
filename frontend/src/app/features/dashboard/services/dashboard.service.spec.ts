import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { DashboardService } from './dashboard.service';
import { VentasHoyResponse } from '@core/models/dashboard/ventas-hoy.model';
import { FacturacionActualResponse } from '@core/models/dashboard/facturacion-actual.model';
import { ResumenCuentasResponse } from '@core/models/dashboard/cuentas.model';
import { StockBajoResponse } from '@core/models/dashboard/stock-bajo.model';
import { Usuarios2FAResponse } from '@core/models/dashboard/usuarios-2fa.model';
import { MesFacturadoResponse } from '@core/models/reportes/facturacion.model';

describe('DashboardService', () => {
  let service: DashboardService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [DashboardService]
    });
    service = TestBed.inject(DashboardService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should get ventas hoy', () => {
    const dummyResponse: VentasHoyResponse = { total: 100 };

    service.getVentasHoy().subscribe(res => {
      expect(res).toEqual(dummyResponse);
    });

    const req = httpMock.expectOne('http://localhost:8080/api/dashboard/ventas-hoy');
    expect(req.request.method).toBe('GET');
    req.flush(dummyResponse);
  });

  it('should get facturación actual', () => {
    const dummyResponse: FacturacionActualResponse = {
      mes: 'Mayo',
      total: 5000
    };

    service.getFacturacionActual().subscribe(res => {
      expect(res).toEqual(dummyResponse);
    });

    const req = httpMock.expectOne('http://localhost:8080/api/dashboard/facturacion-actual');
    expect(req.request.method).toBe('GET');
    req.flush(dummyResponse);
  });

  it('should get resumen de cuentas', () => {
    const dummyResponse: ResumenCuentasResponse = {
      totalPendiente: 12345.67,
      cantidadClientesDeudores: 3,
      estadoCuentas: { PENDIENTE: 2, VENCIDA: 1 }
    };

    service.getResumenCuentas().subscribe(res => {
      expect(res).toEqual(dummyResponse);
    });

    const req = httpMock.expectOne('http://localhost:8080/api/dashboard/resumen-cuentas');
    expect(req.request.method).toBe('GET');
    req.flush(dummyResponse);
  });

  it('should get stock bajo', () => {
    const dummyResponse: StockBajoResponse = { cantidad: 5 };

    service.getStockBajo().subscribe(res => {
      expect(res).toEqual(dummyResponse);
    });

    const req = httpMock.expectOne('http://localhost:8080/api/dashboard/stock-bajo');
    expect(req.request.method).toBe('GET');
    req.flush(dummyResponse);
  });

  it('should get usuarios con 2FA', () => {
    const dummyResponse: Usuarios2FAResponse = { cantidad: 10 };

    service.getUsuarios2FA().subscribe(res => {
      expect(res).toEqual(dummyResponse);
    });

    const req = httpMock.expectOne('http://localhost:8080/api/dashboard/usuarios-2fa');
    expect(req.request.method).toBe('GET');
    req.flush(dummyResponse);
  });

  it('should get facturación mensual', () => {
    const dummyResponse: MesFacturadoResponse[] = [
      { mes: 'Enero', totalFacturado: 1500 },
      { mes: 'Febrero', totalFacturado: 1200 }
    ];

    service.getFacturacionMensual().subscribe(res => {
      expect(res).toEqual(dummyResponse);
      expect(res.length).toBe(2);
    });

    const req = httpMock.expectOne('http://localhost:8080/api/reportes/facturacion-mensual');
    expect(req.request.method).toBe('GET');
    req.flush(dummyResponse);
  });
});
