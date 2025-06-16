import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatSelectModule } from '@angular/material/select';

import { Producto } from 'src/app/core/models/productos/producto.model';
import { ProductosApiService } from 'src/app/infrastructure/api/productos/productos-api.service';
import { CreateProductoDTO } from 'src/app/core/models/productos/create-producto-dto.model';
import { UpdateProductoDTO } from 'src/app/core/models/productos/update-producto-dto.model';

import { CategoriasApiService } from 'src/app/infrastructure/api/categorias/categorias-api.service';
import { CategoriaProducto } from 'src/app/core/models/productos/categoria-producto.model';

import { HttpErrorResponse } from '@angular/common/http';

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
    MatSelectModule,
  ],
  templateUrl: './productos-create-edit-dialog.component.html',
  styleUrls: ['./productos-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProductosCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  isEdit: boolean;
  categorias: CategoriaProducto[] = [];

  constructor(
    private fb: FormBuilder,
    private api: ProductosApiService,
    @Inject(CategoriasApiService) private categoriasApi: CategoriasApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { producto?: Producto },
    private dialogRef: MatDialogRef<ProductosCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.producto;
  }

  ngOnInit(): void {
    // Carga el listado de categorías
    this.categoriasApi.obtenerCategorias().subscribe((cats) => (this.categorias = cats));

    // Construye el formulario, ahora con categoriaId obligatorio
    this.form = this.fb.group({
      nombre: [this.data.producto?.nombre ?? '', Validators.required],
      descripcion: [this.data.producto?.descripcion ?? '', Validators.maxLength(255)],
      precio: [this.data.producto?.precio ?? 0, [Validators.required, Validators.min(0)]],
      stock: [this.data.producto?.stock ?? 0, [Validators.required, Validators.min(0)]],
      categoriaId: [this.data.producto?.categoriaId ?? null, Validators.required],
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
        error: (err: HttpErrorResponse) => {
          let msg = 'Ocurrió un error inesperado';
          if (err.error) {
            if (typeof err.error === 'string') {
              msg = err.error;
            } else if (err.error.error) {
              msg = err.error.error;
            }
          } else {
            msg = err.message;
          }

          this.snackBar.open(`Error: ${msg}`, '', { duration: 5000 });
        },
      });
    } else {
      const dto: CreateProductoDTO = this.form.value;
      /* console.log('Payload enviado:', dto); */
      this.api.crearProducto(dto).subscribe({
        next: () => {
          this.snackBar.open('Producto creado correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: HttpErrorResponse) => {
          let msg = 'Ocurrió un error inesperado';
          if (err.error) {
            if (typeof err.error === 'string') {
              msg = err.error;
            } else if (err.error.error) {
              msg = err.error.error;
            }
          } else {
            msg = err.message;
          }

          this.snackBar.open(`Error: ${msg}`, '', { duration: 5000 });
        },
      });
    }
  }

  cancelar(): void {
    this.dialogRef.close();
  }
}
