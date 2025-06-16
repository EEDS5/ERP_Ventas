// frontend/src/app/features/ventas/pages/ventas-create-edit-dialog.component.ts

import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { Observable } from 'rxjs';

import { Usuario } from 'src/app/core/models/auth/usuario.model';
import { Venta } from 'src/app/core/models/ventas/venta.model';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';
import { UpdateVentaCompletaDTO } from 'src/app/core/models/ventas/update-venta-completa-dto.model';
import { DetalleVentaForm } from 'src/app/core/models/ventas/detalle-venta-form.model';
import { ProductoConPrecio } from 'src/app/core/models/ventas/producto-con-precio.model';
import { CreateVentaCompletaDTO } from 'src/app/core/models/ventas/create-venta-completa-dto.model';
import { Cliente } from 'src/app/core/models/clientes/cliente.model';
import { MetodoPago } from 'src/app/core/models/productos/metodo-pago.model';
import { ClientesApiService } from 'src/app/infrastructure/api/clientes/clientes-api.service';
import { MetodosPagoApiService } from 'src/app/infrastructure/api/metodos-pago/metodos-pago-api.service';
import { ProductosApiService } from 'src/app/infrastructure/api/productos/productos-api.service';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-ventas-create-edit-dialog',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatSnackBarModule,
    MatIconModule,
  ],
  templateUrl: './ventas-create-edit-dialog.component.html',
  styleUrls: ['./ventas-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class VentasCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  clientes$!: Observable<Cliente[]>;
  metodosPago$!: Observable<MetodoPago[]>;
  productos: ProductoConPrecio[] = [];
  isEdit: boolean;
  usuarioActual!: Usuario;
  showPaypal = false;

  private initPaypalButtons(): void {
    const existing = document.getElementById('paypal-script');
    if (!existing) {
      const script = document.createElement('script');
      script.id = 'paypal-script';
      script.src = 'https://www.paypal.com/sdk/js?client-id=TU_CLIENT_ID_SANDBOX&currency=USD';
      script.onload = () => this.renderPaypalButtons();
      document.body.appendChild(script);
    } else {
      this.renderPaypalButtons();
    }
  }

  private renderPaypalButtons(): void {
    const paypal = (window as any).paypal;
    if (!paypal) return;
    paypal.Buttons({
      createOrder: () => fetch('/api/ventas/paypal/create-order?amount=' + this.form.get('total')?.value, { method: 'post' })
        .then(res => res.text()),
      onApprove: (data: any) => {
        const dto: CreateVentaCompletaDTO = {
          clienteId: this.form.value.clienteId,
          metodoPagoId: this.form.value.metodoPagoId,
          creadoPorUsuarioId: this.usuarioActual.usuarioID,
          detalles: this.detalles.value,
        };
        fetch('/api/ventas/paypal/capture-order?orderId=' + data.orderID, {
          method: 'post',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(dto),
        }).then(() => {
          this.snackBar.open('Venta creada correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        });
      }
    }).render('#paypal-button-container');
  }

  constructor(
    private fb: FormBuilder,
    private ventasApi: VentasApiService,
    private clientesApi: ClientesApiService,
    private metodosApi: MetodosPagoApiService,
    private productosApi: ProductosApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { venta?: Venta },
    private dialogRef: MatDialogRef<VentasCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.venta;
  }

  ngOnInit(): void {

    // obtener usuario actual desde localStorage
    // si no hay usuario, muestra error y cierra el diálogo
    const userRaw = localStorage.getItem('user');
    if (!userRaw) {
      this.snackBar.open('Error: usuario no autenticado', '', { duration: 3000 });
      this.dialogRef.close();
      return;
    }
    this.usuarioActual = JSON.parse(userRaw);

    // carga datos iniciales
    this.clientes$ = this.clientesApi.obtenerClientes();
    this.metodosPago$ = this.metodosApi.obtenerMetodosPago();
    this.productosApi.obtenerProductos().subscribe((p) => {
      this.productos = p.map((pr) => ({
        productoId: pr.productoId,
        nombre: pr.nombre,
        precio: pr.precio,
      }));
    });

    // inicializa form
    this.form = this.fb.group({
      clienteId: [
        { value: this.data.venta?.clienteId ?? '', disabled: this.isEdit },
        Validators.required,
      ],
      metodoPagoId: [this.data.venta?.metodoPagoId ?? '', Validators.required],
      detalles: this.fb.array([], Validators.required),
      total: [{ value: 0, disabled: true }],
    });

    if (this.isEdit && this.data.venta) {
      // carga los detalles desde el backend
      this.ventasApi.obtenerVentaCompleta(this.data.venta.ventaId).subscribe((vc) => {
        const fa = this.detalles;
        fa.clear(); // quita el row vacío
        vc.detalles.forEach((d) =>
          this.addDetalle({ productoId: d.productoId, cantidad: d.cantidad }),
        );
        this.calcularTotal();
      });
    } else {
      // modo creación, comienzo con una fila vacía
      this.addDetalle();
    }

    // recalcular total a cada cambio
    this.detalles.valueChanges.subscribe(() => this.calcularTotal());
    this.form.get('metodoPagoId')?.valueChanges.subscribe((id) => {
      this.showPaypal = Number(id) === 2;
      if (this.showPaypal) {
        this.initPaypalButtons();
      }
    });
  }

  get detalles(): FormArray {
    return this.form.get('detalles') as FormArray;
  }

  addDetalle(initial?: { productoId: number; cantidad: number }): void {
    this.detalles.push(
      this.fb.group({
        productoId: this.fb.control<number | null>(
          initial?.productoId ?? null,
          Validators.required,
        ),
        cantidad: this.fb.control<number>(initial?.cantidad ?? 1, [
          Validators.required,
          Validators.min(1),
        ]),
      }),
    );
  }

  removeDetalle(index: number): void {
    this.detalles.removeAt(index);
    this.calcularTotal();
  }

  private calcularTotal(): void {
    const total = this.detalles.controls.reduce((sum, grp) => {
      const val = grp.value as DetalleVentaForm;
      const prod = this.productos.find((p) => p.productoId === Number(val.productoId));
      const price = prod?.precio ?? 0;
      return sum + price * (val.cantidad ?? 0);
    }, 0);
    this.form.get('total')?.setValue(total);
  }

  submit(): void {
    if (this.form.invalid) return;
    if (this.showPaypal) return;

    if (this.isEdit && this.data.venta) {
      const dto: UpdateVentaCompletaDTO = {
        metodoPagoId: this.form.value.metodoPagoId,
        detalles: this.detalles.value,
      };
      this.ventasApi.actualizarVentaCompleta(this.data.venta.ventaId, dto).subscribe({
        next: () => {
          this.snackBar.open('Venta actualizada correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error al actualizar venta completa: ${err.message}`, '', {
            duration: 5000,
          });
        },
      });
    } else {
      const dto: CreateVentaCompletaDTO = {
        clienteId: this.form.value.clienteId,
        metodoPagoId: this.form.value.metodoPagoId,
        creadoPorUsuarioId: this.usuarioActual.usuarioID,
        detalles: this.detalles.value,
      };
      this.ventasApi.crearVentaCompleta(dto).subscribe({
        next: () => {
          this.snackBar.open('Venta creada correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
        },
      });
    }
  }

  cancelar(): void {
    this.dialogRef.close();
  }
}
