import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';

import { CategoriaProducto } from 'src/app/core/models/productos/categoria-producto.model';
import { CategoriasApiService } from 'src/app/infrastructure/api/categorias/categorias-api.service';
import { CreateCategoriaDTO } from 'src/app/core/models/productos/create-categoria-dto.model';
import { UpdateCategoriaDTO } from 'src/app/core/models/productos/update-categoria-dto.model';

@Component({
  selector: 'app-categorias-create-edit-dialog',
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
  templateUrl: './categorias-create-edit-dialog.component.html',
  styleUrls: ['./categorias-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class CategoriasCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  isEdit: boolean;

  constructor(
    private fb: FormBuilder,
    private api: CategoriasApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { categoria?: CategoriaProducto },
    private dialogRef: MatDialogRef<CategoriasCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.categoria;
  }

  ngOnInit(): void {
    this.form = this.fb.group({
      nombre: [this.data.categoria?.nombre ?? '', Validators.required],
      descripcion: [this.data.categoria?.descripcion ?? ''],
    });
  }

  submit(): void {
    if (this.form.invalid) return;

    if (this.isEdit && this.data.categoria) {
      const dto: UpdateCategoriaDTO = this.form.value;
      this.api.actualizarCategoria(this.data.categoria.categoriaId, dto).subscribe({
        next: () => {
          this.snackBar.open('Categoría actualizada correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
        },
      });
    } else {
      const dto: CreateCategoriaDTO = this.form.value;
      this.api.crearCategoria(dto).subscribe({
        next: () => {
          this.snackBar.open('Categoría creada correctamente', '', { duration: 3000 });
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
