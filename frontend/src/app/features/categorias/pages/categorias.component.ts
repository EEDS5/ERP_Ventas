import { Component, OnInit, ChangeDetectionStrategy, ViewChild, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatPaginatorModule, MatPaginator } from '@angular/material/paginator';
import { MatSortModule, MatSort } from '@angular/material/sort';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatCardModule } from '@angular/material/card';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

import { CategoriaProducto } from 'src/app/core/models/productos/categoria-producto.model';
import { CategoriasApiService } from 'src/app/infrastructure/api/categorias/categorias-api.service';
import { CategoriasCreateEditDialogComponent } from './create-edit-dialog/categorias-create-edit-dialog.component';

@Component({
  selector: 'app-categorias',
  standalone: true,
  imports: [
    CommonModule,
    MatTableModule,
    MatPaginatorModule,
    MatSortModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule,
    MatDialogModule,
    MatSnackBarModule,
    MatCardModule,
    MatProgressSpinnerModule,
  ],
  templateUrl: './categorias.component.html',
  styleUrls: ['./categorias.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class CategoriasComponent implements OnInit {
  dataSource = new MatTableDataSource<CategoriaProducto>();
  loading = false;
  displayedColumns = ['nombre', 'estado', 'acciones'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild('searchInput') searchInput!: ElementRef<HTMLInputElement>;

  constructor(
    private api: CategoriasApiService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar,
  ) {}

  ngOnInit(): void {
    this.cargarCategorias();
  }

  private cargarCategorias(): void {
    this.loading = true;
    this.api.obtenerCategorias().subscribe({
      next: (data: CategoriaProducto[]) => {
        // Mostrar activos e inactivos
        this.dataSource.data = data;
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
        this.snackBar.open('Error al cargar categorías', '', { duration: 3000 });
      },
    });
  }

  filtrarCategoria(event: Event): void {
    const filtro = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filtro;
  }

  clearFilter(): void {
    this.dataSource.filter = '';
    this.searchInput.nativeElement.value = '';
  }

  nuevaCategoria(): void {
    const ref = this.dialog.open(CategoriasCreateEditDialogComponent, {
      width: '500px',
      data: {},
    });
    ref.afterClosed().subscribe((created: boolean) => {
      if (created) this.cargarCategorias();
    });
  }

  editarCategoria(categoria: CategoriaProducto): void {
    const ref = this.dialog.open(CategoriasCreateEditDialogComponent, {
      width: '500px',
      data: { categoria },
    });
    ref.afterClosed().subscribe((updated: boolean) => {
      if (updated) this.cargarCategorias();
    });
  }

  eliminarCategoria(id: number): void {
    this.api.eliminarCategoria(id).subscribe({
      next: () => {
        this.snackBar.open('Categoría eliminada correctamente', '', { duration: 3000 });
        this.cargarCategorias();
      },
      error: (err: Error) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }

  restoreCategoria(id: number): void {
    this.api.restoreCategoria(id).subscribe({
      next: () => {
        this.snackBar.open('Categoría restaurada', '', { duration: 3000 });
        this.cargarCategorias();
      },
      error: (err) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }
}
