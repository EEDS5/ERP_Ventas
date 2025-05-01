import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { VentasPorClienteComponent } from './ventas-por-cliente.component';

describe('VentasPorClienteComponent', () => {
  let component: VentasPorClienteComponent;
  let fixture: ComponentFixture<VentasPorClienteComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VentasPorClienteComponent, HttpClientTestingModule]
    }).compileComponents();

    fixture = TestBed.createComponent(VentasPorClienteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
