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

import { Venta } from 'src/app/core/models/ventas/venta.model';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';
import { DetalleVentaDialogComponent } from './detalle-venta-dialog.component';
import { VentasCreateEditDialogComponent } from './ventas-create-edit-dialog.component';

@Component({
  selector: 'app-ventas',
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
  templateUrl: './ventas.component.html',
  styleUrls: ['./ventas.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class VentasComponent implements OnInit {
  dataSource = new MatTableDataSource<Venta>();
  loading = false;
  displayedColumns = ['fechaVenta', 'clienteNombre', 'total', 'acciones'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild('searchInput') searchInput!: ElementRef<HTMLInputElement>;

  constructor(
    private api: VentasApiService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar,
  ) {}

  ngOnInit(): void {
    this.cargarVentas();
  }

  private cargarVentas(): void {
    this.loading = true;
    this.api.obtenerVentas().subscribe({
      next: (data: Venta[]) => {
        this.dataSource.data = data.filter((v) => v.activo);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
        this.snackBar.open('Error al cargar ventas', '', { duration: 3000 });
      },
    });
  }

  filtrarCliente(event: Event): void {
    const filtro = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filtro;
  }

  clearFilter(): void {
    this.dataSource.filter = '';
    this.searchInput.nativeElement.value = '';
  }

  verDetalleVenta(id: number): void {
    this.dialog.open(DetalleVentaDialogComponent, {
      data: { ventaId: id },
      width: '600px',
    });
  }

  nuevaVenta(): void {
    const ref = this.dialog.open(VentasCreateEditDialogComponent, {
      width: '500px',
      data: {},
    });
    ref.afterClosed().subscribe((created: boolean) => {
      if (created) this.cargarVentas();
    });
  }

  editarVenta(venta: Venta): void {
    const ref = this.dialog.open(VentasCreateEditDialogComponent, {
      width: '500px',
      data: { venta },
    });
    ref.afterClosed().subscribe((updated: boolean) => {
      if (updated) this.cargarVentas();
    });
  }

  eliminarVenta(id: number): void {
    this.api.eliminarVenta(id).subscribe({
      next: () => {
        this.snackBar.open('Venta eliminada correctamente', '', { duration: 3000 });
        this.cargarVentas();
      },
      error: (err: Error) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }
}
