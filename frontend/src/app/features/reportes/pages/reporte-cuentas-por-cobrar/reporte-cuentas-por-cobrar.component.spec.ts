import { ComponentFixture, TestBed } from '@angular/core/testing';
import { NO_ERRORS_SCHEMA } from '@angular/core';
import { of, throwError } from 'rxjs';

import { ReporteCuentasPorCobrarComponent } from './reporte-cuentas-por-cobrar.component';
import { ReportesApiService } from 'src/app/infrastructure/api/reportes/reportes-api.service';
import { CuentaPorCobrar } from 'src/app/core/models/reportes/cuenta-por-cobrar.model';

describe('ReporteCuentasPorCobrarComponent', () => {
  let component: ReporteCuentasPorCobrarComponent;
  let fixture: ComponentFixture<ReporteCuentasPorCobrarComponent>;
  let apiSpy: jasmine.SpyObj<ReportesApiService>;

  beforeEach(async () => {
    apiSpy = jasmine.createSpyObj('ReportesApiService', [
      'obtenerCuentasPorCobrar',
      'descargarReporteCuentasPdf',
      'descargarReporteCuentasExcel',
    ]);

    await TestBed.configureTestingModule({
      imports: [ReporteCuentasPorCobrarComponent],
      providers: [{ provide: ReportesApiService, useValue: apiSpy }],
      schemas: [NO_ERRORS_SCHEMA], // evita declarar módulos de Material
    }).compileComponents();

    fixture = TestBed.createComponent(ReporteCuentasPorCobrarComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('debe cargar datos correctamente en ngOnInit', () => {
    const mockData: CuentaPorCobrar[] = [
      {
        cliente: 'ACME',
        ventaId: 42,
        numeroFactura: 'F-001',
        fechaVencimiento: '2025-06-01', // ← string en ISO
        montoPendiente: 150,
        estado: 'Pendiente',
        fechaUltimoPago: '2025-05-15', // ← string en ISO
      },
    ];
    apiSpy.obtenerCuentasPorCobrar.and.returnValue(of(mockData));

    component.ngOnInit();
    expect(component.dataLoading).toBeFalse();
    expect(component.cuentasData).toEqual(mockData);
    expect(component.summary.totalPendiente).toBe(150);
    expect(component.summary.totalCuentas).toBe(1);
  });

  it('debe manejar error al cargar datos', () => {
    apiSpy.obtenerCuentasPorCobrar.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component['cargarDatos']();
    expect(component.dataLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('No se pudieron cargar los datos del reporte.');
  });

  it('debe descargar PDF correctamente', () => {
    const fakeBlob = new Blob([], { type: 'application/pdf' });
    apiSpy.descargarReporteCuentasPdf.and.returnValue(of(fakeBlob));
    spyOn(document, 'createElement').and.callThrough();

    component.descargarPdf();

    expect(component.pdfLoading).toBeFalse();
    expect(apiSpy.descargarReporteCuentasPdf).toHaveBeenCalled();
  });

  it('debe manejar error al descargar PDF', () => {
    apiSpy.descargarReporteCuentasPdf.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component.descargarPdf();

    expect(component.pdfLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('Ocurrió un error al generar el PDF.');
  });

  it('debe descargar Excel correctamente', () => {
    const fakeBlob = new Blob([], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    });
    apiSpy.descargarReporteCuentasExcel.and.returnValue(of(fakeBlob));

    component.descargarExcel();

    expect(component.excelLoading).toBeFalse();
    expect(apiSpy.descargarReporteCuentasExcel).toHaveBeenCalled();
  });

  it('debe manejar error al descargar Excel', () => {
    apiSpy.descargarReporteCuentasExcel.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component.descargarExcel();

    expect(component.excelLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('Ocurrió un error al generar el Excel.');
  });
});
