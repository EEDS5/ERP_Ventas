import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { ChartCuentasPorCobrarComponent } from './chart-cuentas-por-cobrar.component';
import { of } from 'rxjs';
import { DashboardService } from '../../../services/dashboard.service';
import { ResumenCuentasResponse } from '../../../../../core/models/dashboard/cuentas.model';

interface PieSeriesOption {
  type: string;
}

interface OptionWithSeries {
  series?: PieSeriesOption[];
}

describe('ChartCuentasPorCobrarComponent', () => {
  let component: ChartCuentasPorCobrarComponent;
  let fixture: ComponentFixture<ChartCuentasPorCobrarComponent>;
  let mockDashboardService: jasmine.SpyObj<DashboardService>;

  beforeEach(waitForAsync(() => {
    mockDashboardService = jasmine.createSpyObj('DashboardService', ['getResumenCuentas']);
    TestBed.configureTestingModule({
      imports: [ChartCuentasPorCobrarComponent],
      providers: [{ provide: DashboardService, useValue: mockDashboardService }],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChartCuentasPorCobrarComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should load chart options based on service data', () => {
    const dummyData: ResumenCuentasResponse = {
      totalPendiente: 10000,
      cantidadClientesDeudores: 4,
      estadoCuentas: { PENDIENTE: 2, VENCIDA: 2 },
    };

    mockDashboardService.getResumenCuentas.and.returnValue(of(dummyData));
    fixture.detectChanges(); // dispara ngOnInit()

    expect(mockDashboardService.getResumenCuentas).toHaveBeenCalled();

    // Cast al tipo mínimo que conoce 'series'
    const opt = component.chartOption as OptionWithSeries;
    expect(opt.series).toBeDefined();
    expect(Array.isArray(opt.series)).toBeTrue();
    expect(opt.series![0].type).toBe('pie');
  });
});
