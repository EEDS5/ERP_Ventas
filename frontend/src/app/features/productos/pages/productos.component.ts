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

import { Producto } from 'src/app/core/models/productos/producto.model';
import { ProductosApiService } from 'src/app/infrastructure/api/productos/productos-api.service';
import { ProductosCreateEditDialogComponent } from './create-edit-dialog/productos-create-edit-dialog.component';

import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-productos',
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
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProductosComponent implements OnInit {
  dataSource = new MatTableDataSource<Producto>();
  loading = false;
  displayedColumns = ['nombre', 'precio', 'stock', 'estado', 'acciones'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild('searchInput') searchInput!: ElementRef<HTMLInputElement>;

  constructor(
    private api: ProductosApiService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar,
  ) {}

  ngOnInit(): void {
    this.cargarProductos();
  }

  private cargarProductos(): void {
    this.loading = true;
    this.api.obtenerProductos().subscribe({
      next: (data: Producto[]) => {
        this.dataSource.data = data;
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
        this.snackBar.open('Error al cargar productos', '', { duration: 3000 });
      },
    });
  }

  filtrarProducto(event: Event): void {
    const filtro = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filtro;
  }

  clearFilter(): void {
    this.dataSource.filter = '';
    this.searchInput.nativeElement.value = '';
  }

  nuevoProducto(): void {
    const ref = this.dialog.open(ProductosCreateEditDialogComponent, {
      width: '500px',
      data: {},
    });
    ref.afterClosed().subscribe((created: boolean) => {
      if (created) this.cargarProductos();
    });
  }

  editarProducto(producto: Producto): void {
    const ref = this.dialog.open(ProductosCreateEditDialogComponent, {
      width: '500px',
      data: { producto },
    });
    ref.afterClosed().subscribe((updated: boolean) => {
      if (updated) this.cargarProductos();
    });
  }

  eliminarProducto(id: number): void {
    this.api.eliminarProducto(id).subscribe({
      next: () => {
        this.snackBar.open('Producto eliminado correctamente', '', { duration: 3000 });
        this.cargarProductos();
      },
      error: (err: HttpErrorResponse) => {
        // err.error puede ser un objecto { error: "mensaje" } o una cadena
        interface ErrorResponse {
          error: string;
        }
        let msg = 'Ocurrió un error inesperado';
        if (err.error) {
          if (typeof err.error === 'string') {
            msg = err.error; // cuerpo de texto plano
          } else if ((err.error as ErrorResponse).error) {
            msg = (err.error as ErrorResponse).error; // { error: "...mensaje..." }
          }
        } else {
          msg = err.message; // fallback
        }
        this.snackBar.open(`Error: ${msg}`, '', { duration: 5000 });
      },
    });
  }

  activarProducto(id: number): void {
    this.api.activarProducto(id).subscribe({
      next: () => {
        this.snackBar.open('Producto restaurado correctamente', '', { duration: 3000 });
        this.cargarProductos();
      },
      error: () => {
        this.snackBar.open('Error al restaurar producto', '', { duration: 5000 });
      },
    });
  }
}
