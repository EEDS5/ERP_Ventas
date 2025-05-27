import { ComponentFixture, TestBed } from '@angular/core/testing';
import { NO_ERRORS_SCHEMA } from '@angular/core';
import { of } from 'rxjs';

import { DashboardComponent } from './dashboard.component';
import { DashboardService } from '../services/dashboard.service';
import { TranslateModule } from '@ngx-translate/core';
import { CommonModule } from '@angular/common';
import { RouterTestingModule } from '@angular/router/testing';

// Importación de tipos para mocks
import { VentasHoyResponse } from '@core/models/dashboard/ventas-hoy.model';
import { FacturacionActualResponse } from '@core/models/dashboard/facturacion-actual.model';
import { ResumenCuentasResponse } from '@core/models/dashboard/cuentas.model';
import { StockBajoResponse } from '@core/models/dashboard/stock-bajo.model';
import { Usuarios2FAResponse } from '@core/models/dashboard/usuarios-2fa.model';
import { MesFacturadoResponse } from '@core/models/reportes/facturacion.model';

// Mocks tipados sin usar any
const mockVentasHoy: Partial<VentasHoyResponse> = {};
const mockFacturacionActual: Partial<FacturacionActualResponse> = {};
const mockResumenCuentas: Partial<ResumenCuentasResponse> = {};
const mockStockBajo: Partial<StockBajoResponse> = {};
const mockUsuarios2FA: Partial<Usuarios2FAResponse> = {};
const mockFacturacionMensual: Partial<MesFacturadoResponse>[] = [];

describe('DashboardComponent', () => {
  let component: DashboardComponent;
  let fixture: ComponentFixture<DashboardComponent>;
  let dashboardSpy: jasmine.SpyObj<DashboardService>;

  beforeEach(async () => {
    // Spy con todos los métodos incluyendo getFacturacionMensual
    dashboardSpy = jasmine.createSpyObj('DashboardService', [
      'getVentasHoy',
      'getFacturacionActual',
      'getResumenCuentas',
      'getStockBajo',
      'getUsuarios2FA',
      'getFacturacionMensual'
    ]);

    // Definir retornos
    dashboardSpy.getVentasHoy.and.returnValue(of(mockVentasHoy as VentasHoyResponse));
    dashboardSpy.getFacturacionActual.and.returnValue(of(mockFacturacionActual as FacturacionActualResponse));
    dashboardSpy.getResumenCuentas.and.returnValue(of(mockResumenCuentas as ResumenCuentasResponse));
    dashboardSpy.getStockBajo.and.returnValue(of(mockStockBajo as StockBajoResponse));
    dashboardSpy.getUsuarios2FA.and.returnValue(of(mockUsuarios2FA as Usuarios2FAResponse));
    dashboardSpy.getFacturacionMensual.and.returnValue(of(mockFacturacionMensual as MesFacturadoResponse[]));

    await TestBed.configureTestingModule({
      imports: [
        CommonModule,
        TranslateModule.forRoot(),
        RouterTestingModule,
        DashboardComponent
      ],
      providers: [
        { provide: DashboardService, useValue: dashboardSpy }
      ],
      schemas: [NO_ERRORS_SCHEMA]
    }).compileComponents();

    fixture = TestBed.createComponent(DashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
