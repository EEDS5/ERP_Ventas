import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';

import { Cliente } from 'src/app/core/models/clientes/cliente.model';
import { CreateClienteDTO } from 'src/app/core/models/clientes/create-cliente-dto.model';
import { UpdateClienteDTO } from 'src/app/core/models/clientes/update-cliente-dto.model';
import { ClientesApiService } from 'src/app/infrastructure/api/clientes/clientes-api.service';

@Component({
  selector: 'app-clientes-create-edit-dialog',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatSnackBarModule,
  ],
  templateUrl: './clientes-create-edit-dialog.component.html',
  styleUrls: ['./clientes-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ClientesCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  isEdit: boolean;

  constructor(
    private fb: FormBuilder,
    private api: ClientesApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { cliente?: Cliente },
    private dialogRef: MatDialogRef<ClientesCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.cliente;
  }

  ngOnInit(): void {
    this.form = this.fb.group({
      nombre: [this.data.cliente?.nombre ?? '', Validators.required],
      correo: [this.data.cliente?.correo ?? '', [Validators.required, Validators.email]],
      telefono: [this.data.cliente?.telefono ?? ''],
      direccion: [this.data.cliente?.direccion ?? ''],
    });
  }

  submit(): void {
    if (this.form.invalid) return;

    if (this.isEdit && this.data.cliente) {
      const dto: UpdateClienteDTO = this.form.value;
      this.api.actualizarCliente(this.data.cliente.clienteId, dto).subscribe({
        next: () => {
          this.snackBar.open('Cliente actualizado correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
        },
      });
    } else {
      const dto: CreateClienteDTO = {
        ...this.form.value,
        creadoPorUsuarioId: 1,
      };
      this.api.crearCliente(dto).subscribe({
        next: () => {
          this.snackBar.open('Cliente creado correctamente', '', { duration: 3000 });
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
