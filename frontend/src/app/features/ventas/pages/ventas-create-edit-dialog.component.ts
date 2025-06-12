// frontend/src/app/features/ventas/pages/ventas-create-edit-dialog.component.ts

import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { Observable } from 'rxjs';

import { Venta } from 'src/app/core/models/ventas/venta.model';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';
import { CreateVentaDTO } from 'src/app/core/models/ventas/create-venta-dto.model';
import { UpdateVentaDTO } from 'src/app/core/models/ventas/update-venta-dto.model';
import { Cliente } from 'src/app/core/models/clientes/cliente.model';
import { MetodoPago } from 'src/app/core/models/productos/metodo-pago.model';
import { ClientesApiService } from 'src/app/infrastructure/api/clientes/clientes-api.service';
import { MetodosPagoApiService } from 'src/app/infrastructure/api/metodos-pago/metodos-pago-api.service';

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
  ],
  templateUrl: './ventas-create-edit-dialog.component.html',
  styleUrls: ['./ventas-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class VentasCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  clientes$!: Observable<Cliente[]>;
  metodosPago$!: Observable<MetodoPago[]>;
  isEdit: boolean;

  constructor(
    private fb: FormBuilder,
    private ventasApi: VentasApiService,
    private clientesApi: ClientesApiService,
    private metodosApi: MetodosPagoApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { venta?: Venta },
    private dialogRef: MatDialogRef<VentasCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.venta;
  }

  ngOnInit(): void {
    this.clientes$ = this.clientesApi.obtenerClientes();
    this.metodosPago$ = this.metodosApi.obtenerMetodosPago();

    this.form = this.fb.group({
      clienteId: [
        { value: this.data.venta?.clienteId ?? '', disabled: this.isEdit },
        Validators.required,
      ],
      metodoPagoId: [this.data.venta?.metodoPagoId ?? '', Validators.required],
      total: [this.data.venta?.total ?? '', [Validators.required, Validators.min(0.01)]],
    });
  }

  submit(): void {
    if (this.form.invalid) return;

    if (this.isEdit && this.data.venta) {
      const dto: UpdateVentaDTO = {
        metodoPagoId: this.form.value.metodoPagoId,
        total: this.form.value.total,
      };
      this.ventasApi.actualizarVenta(this.data.venta.ventaId, dto).subscribe({
        next: () => {
          this.snackBar.open('Venta actualizada correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
        },
      });
    } else {
      const dto: CreateVentaDTO = {
        clienteId: this.form.value.clienteId,
        metodoPagoId: this.form.value.metodoPagoId,
        creadoPorUsuarioId: 1,
        total: this.form.value.total,
      };
      this.ventasApi.crearVenta(dto).subscribe({
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
