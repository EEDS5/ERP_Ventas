import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';

import { Producto } from 'src/app/core/models/productos/producto.model';
import { ProductosApiService } from 'src/app/infrastructure/api/productos/productos-api.service';
import { CreateProductoDTO } from 'src/app/core/models/productos/create-producto-dto.model';
import { UpdateProductoDTO } from 'src/app/core/models/productos/update-producto-dto.model';

@Component({
  selector: 'app-productos-create-edit-dialog',
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
  templateUrl: './productos-create-edit-dialog.component.html',
  styleUrls: ['./productos-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProductosCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  isEdit: boolean;

  constructor(
    private fb: FormBuilder,
    private api: ProductosApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { producto?: Producto },
    private dialogRef: MatDialogRef<ProductosCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.producto;
  }

  ngOnInit(): void {
    this.form = this.fb.group({
      nombre: [this.data.producto?.nombre ?? '', Validators.required],
      descripcion: [this.data.producto?.descripcion ?? ''],
      precio: [this.data.producto?.precio ?? '', [Validators.required, Validators.min(0)]],
      stock: [this.data.producto?.stock ?? '', [Validators.required, Validators.min(0)]],
    });
  }

  submit(): void {
    if (this.form.invalid) return;

    if (this.isEdit && this.data.producto) {
      const dto: UpdateProductoDTO = this.form.value;
      this.api.actualizarProducto(this.data.producto.productoId, dto).subscribe({
        next: () => {
          this.snackBar.open('Producto actualizado correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
        },
      });
    } else {
      const dto: CreateProductoDTO = this.form.value;
      this.api.crearProducto(dto).subscribe({
        next: () => {
          this.snackBar.open('Producto creado correctamente', '', { duration: 3000 });
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
