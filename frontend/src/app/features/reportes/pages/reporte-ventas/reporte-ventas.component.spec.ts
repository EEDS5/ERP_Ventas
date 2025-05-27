import { ComponentFixture, TestBed } from '@angular/core/testing';
import { NO_ERRORS_SCHEMA } from '@angular/core';
import { of, throwError } from 'rxjs';

import { ReporteVentasComponent } from './reporte-ventas.component';
import { ReportesApiService } from 'src/app/infrastructure/api/reportes/reportes-api.service';
import { VentaPorCliente } from 'src/app/core/models/reportes/venta-por-cliente.model';

describe('ReporteVentasComponent', () => {
  let component: ReporteVentasComponent;
  let fixture: ComponentFixture<ReporteVentasComponent>;
  let apiSpy: jasmine.SpyObj<ReportesApiService>;

  beforeEach(async () => {
    apiSpy = jasmine.createSpyObj('ReportesApiService', [
      'obtenerVentasPorCliente',
      'descargarReporteVentasPorClientePdf',
      'descargarReporteVentasPorClienteExcel'
    ]);

    await TestBed.configureTestingModule({
      imports: [ReporteVentasComponent],
      providers: [{ provide: ReportesApiService, useValue: apiSpy }],
      schemas: [NO_ERRORS_SCHEMA],
    }).compileComponents();

    fixture = TestBed.createComponent(ReporteVentasComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('debe cargar datos de ventas en ngOnInit', () => {
    const mockSales: VentaPorCliente[] = [
      {
        clienteId: 1,
        clienteNombre: 'ACME',
        ventaId: 101,
        fechaVenta: '2025-05-01',
        totalVenta: 120
      },
      {
        clienteId: 2,
        clienteNombre: 'Umbrella',
        ventaId: 102,
        fechaVenta: '2025-05-02',
        totalVenta: 180
      }
    ];
    apiSpy.obtenerVentasPorCliente.and.returnValue(of(mockSales));

    component.ngOnInit();

    expect(component.dataLoading).toBeFalse();
    expect(component.salesData).toEqual(mockSales);
    expect(component.summary.totalVentas).toBe(300);
    expect(component.summary.totalClientes).toBe(2);
  });

  it('debe manejar error al cargar datos de ventas', () => {
    apiSpy.obtenerVentasPorCliente.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (component as any).cargarDatos();

    expect(component.dataLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('No se pudieron cargar los datos del reporte.');
  });

  it('debe descargar PDF de ventas correctamente', () => {
    const fakeBlob = new Blob([], { type: 'application/pdf' });
    apiSpy.descargarReporteVentasPorClientePdf.and.returnValue(of(fakeBlob));
    spyOn(document, 'createElement').and.callThrough();

    component.descargarPdf();

    expect(component.pdfLoading).toBeFalse();
    expect(apiSpy.descargarReporteVentasPorClientePdf).toHaveBeenCalled();
  });

  it('debe manejar error al descargar PDF de ventas', () => {
    apiSpy.descargarReporteVentasPorClientePdf.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component.descargarPdf();

    expect(component.pdfLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('Ocurrió un error al generar el PDF.');
  });

  it('debe descargar Excel de ventas correctamente', () => {
    const fakeBlob = new Blob([], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    });
    apiSpy.descargarReporteVentasPorClienteExcel.and.returnValue(of(fakeBlob));

    component.descargarExcel();

    expect(component.excelLoading).toBeFalse();
    expect(apiSpy.descargarReporteVentasPorClienteExcel).toHaveBeenCalled();
  });

  it('debe manejar error al descargar Excel de ventas', () => {
    apiSpy.descargarReporteVentasPorClienteExcel.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component.descargarExcel();

    expect(component.excelLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('Ocurrió un error al generar el Excel.');
  });
});
