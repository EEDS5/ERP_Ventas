import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { ChartVentasMensualesComponent } from './chart-ventas-mensuales.component';
import { of } from 'rxjs';
import { DashboardService } from '../../../services/dashboard.service';
import { MesFacturadoResponse } from '../../../../../core/models/reportes/facturacion.model';

interface BarSeriesOption {
  type: string;
}

interface OptionWithSeries {
  series?: BarSeriesOption[];
}

describe('ChartVentasMensualesComponent', () => {
  let component: ChartVentasMensualesComponent;
  let fixture: ComponentFixture<ChartVentasMensualesComponent>;
  let mockDashboardService: jasmine.SpyObj<DashboardService>;

  beforeEach(waitForAsync(() => {
    mockDashboardService = jasmine.createSpyObj('DashboardService', ['getFacturacionMensual']);
    TestBed.configureTestingModule({
      imports: [ChartVentasMensualesComponent],
      providers: [{ provide: DashboardService, useValue: mockDashboardService }],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChartVentasMensualesComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should load chart options based on monthly data', () => {
    const dummyData: MesFacturadoResponse[] = [
      { mes: 'Enero', totalFacturado: 1000 },
      { mes: 'Febrero', totalFacturado: 2000 },
    ];

    mockDashboardService.getFacturacionMensual.and.returnValue(of(dummyData));
    fixture.detectChanges(); // dispara ngOnInit()

    expect(mockDashboardService.getFacturacionMensual).toHaveBeenCalled();

    // Cast al tipo mínimo que conoce 'series'
    const opt = component.chartOption as OptionWithSeries;
    expect(opt.series).toBeDefined();
    expect(Array.isArray(opt.series)).toBeTrue();
    expect(opt.series![0].type).toBe('bar');
  });
});
