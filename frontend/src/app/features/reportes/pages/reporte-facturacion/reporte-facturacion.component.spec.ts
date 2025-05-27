import { ComponentFixture, TestBed } from '@angular/core/testing';
import { NO_ERRORS_SCHEMA } from '@angular/core';
import { of, throwError } from 'rxjs';

import { ReporteFacturacionComponent } from './reporte-facturacion.component';
import { ReportesApiService } from 'src/app/infrastructure/api/reportes/reportes-api.service';
import { MesFacturado } from 'src/app/core/models/reportes/mes-facturado.model';

describe('ReporteFacturacionComponent', () => {
  let component: ReporteFacturacionComponent;
  let fixture: ComponentFixture<ReporteFacturacionComponent>;
  let apiSpy: jasmine.SpyObj<ReportesApiService>;

  beforeEach(async () => {
    apiSpy = jasmine.createSpyObj('ReportesApiService', [
      'obtenerFacturacionMensual',
      'descargarReporteFacturacionPdf',
      'descargarReporteFacturacionExcel'
    ]);

    await TestBed.configureTestingModule({
      imports: [ReporteFacturacionComponent],
      providers: [
        { provide: ReportesApiService, useValue: apiSpy }
      ],
      schemas: [NO_ERRORS_SCHEMA]
    }).compileComponents();

    fixture = TestBed.createComponent(ReporteFacturacionComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('debe cargar facturación en ngOnInit', () => {
    const mockData: MesFacturado[] = [
      { mes: 'Enero', totalFacturado: 200 },
      { mes: 'Febrero', totalFacturado: 300 }
    ];
    apiSpy.obtenerFacturacionMensual.and.returnValue(of(mockData));

    component.ngOnInit();
    expect(component.dataLoading).toBeFalse();
    expect(component.facturacionData).toEqual(mockData);
    expect(component.summary.totalFacturado).toBe(500);
    expect(component.summary.totalMeses).toBe(2);
  });

  it('debe manejar error al cargar facturación', () => {
    apiSpy.obtenerFacturacionMensual.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component['cargarDatos']();
    expect(component.dataLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('No se pudieron cargar los datos del reporte.');
  });

  it('debe descargar PDF de facturación', () => {
    const fakeBlob = new Blob([], { type: 'application/pdf' });
    apiSpy.descargarReporteFacturacionPdf.and.returnValue(of(fakeBlob));

    component.descargarPdf();
    expect(component.pdfLoading).toBeFalse();
    expect(apiSpy.descargarReporteFacturacionPdf).toHaveBeenCalled();
  });

  it('debe manejar error al descargar PDF de facturación', () => {
    apiSpy.descargarReporteFacturacionPdf.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component.descargarPdf();
    expect(component.pdfLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('Ocurrió un error al generar el PDF.');
  });

  it('debe descargar Excel de facturación', () => {
    const fakeBlob = new Blob([], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
    apiSpy.descargarReporteFacturacionExcel.and.returnValue(of(fakeBlob));

    component.descargarExcel();
    expect(component.excelLoading).toBeFalse();
    expect(apiSpy.descargarReporteFacturacionExcel).toHaveBeenCalled();
  });

  it('debe manejar error al descargar Excel de facturación', () => {
    apiSpy.descargarReporteFacturacionExcel.and.returnValue(throwError(() => new Error()));
    spyOn(window, 'alert');

    component.descargarExcel();
    expect(component.excelLoading).toBeFalse();
    expect(window.alert).toHaveBeenCalledWith('Ocurrió un error al generar el Excel.');
  });
});
