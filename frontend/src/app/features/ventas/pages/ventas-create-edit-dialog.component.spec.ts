import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { ReactiveFormsModule } from '@angular/forms';
import { of } from 'rxjs';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { VentasCreateEditDialogComponent } from './ventas-create-edit-dialog.component';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';
import { ClientesApiService } from 'src/app/infrastructure/api/clientes/clientes-api.service';
import { MetodosPagoApiService } from 'src/app/infrastructure/api/metodos-pago/metodos-pago-api.service';

describe('VentasCreateEditDialogComponent', () => {
  let component: VentasCreateEditDialogComponent;
  let fixture: ComponentFixture<VentasCreateEditDialogComponent>;
  let mockVentasApi: jasmine.SpyObj<VentasApiService>;
  let mockClientesApi: jasmine.SpyObj<ClientesApiService>;
  let mockMetodosApi: jasmine.SpyObj<MetodosPagoApiService>;

  beforeEach(waitForAsync(() => {
    mockVentasApi = jasmine.createSpyObj('VentasApiService', ['crearVenta', 'actualizarVenta']);
    mockClientesApi = jasmine.createSpyObj('ClientesApiService', ['obtenerClientes']);
    mockMetodosApi = jasmine.createSpyObj('MetodosPagoApiService', ['obtenerMetodosPago']);

    TestBed.configureTestingModule({
      imports: [VentasCreateEditDialogComponent, ReactiveFormsModule],
      providers: [
        { provide: VentasApiService, useValue: mockVentasApi },
        { provide: ClientesApiService, useValue: mockClientesApi },
        { provide: MetodosPagoApiService, useValue: mockMetodosApi },
        { provide: MatSnackBar, useValue: { open: () => null } },
        { provide: MatDialogRef, useValue: { close: () => {} } },
        { provide: MAT_DIALOG_DATA, useValue: {} },
      ],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VentasCreateEditDialogComponent);
    component = fixture.componentInstance;
    mockClientesApi.obtenerClientes.and.returnValue(of([]));
    mockMetodosApi.obtenerMetodosPago.and.returnValue(of([]));
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
