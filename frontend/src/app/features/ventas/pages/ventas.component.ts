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

import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { FormsModule } from '@angular/forms';

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
    MatDatepickerModule,
    MatNativeDateModule,
    FormsModule,
  ],
  templateUrl: './ventas.component.html',
  styleUrls: ['./ventas.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class VentasComponent implements OnInit {
  dataSource = new MatTableDataSource<Venta>();
  loading = false;

  // NUEVAS VARIABLES PARA FILTRO
  searchText = '';
  fechaDesde?: Date;
  fechaHasta?: Date;

  displayedColumns = ['fechaVenta', 'clienteNombre', 'total', 'estado', 'acciones'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild('searchInput') searchInput!: ElementRef<HTMLInputElement>;

  constructor(
    private api: VentasApiService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar,
  ) {}

  ngOnInit(): void {
    this.dataSource.filterPredicate = (data: Venta, filter: string) => {
      const { text, from, to } = JSON.parse(filter);
      const matchesText = data.clienteNombre.toLowerCase().includes(text.toLowerCase());
      const rowDate = new Date(data.fechaVenta);
      const afterFrom = !from || rowDate >= new Date(from);
      const beforeTo = !to || rowDate <= new Date(to);
      return matchesText && afterFrom && beforeTo;
    };

    this.cargarVentas();
  }

  private cargarVentas(): void {
    this.loading = true;
    this.api.obtenerVentas().subscribe({
      next: (data: Venta[]) => {
        // Mostrar todas, sin filtrar por activo
        this.dataSource.data = data;
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;

        // Sort por defecto:
        this.sort.active = 'fechaVenta';
        this.sort.direction = 'desc';

        // Emitimos el evento para que la tabla reordene inmediatamente:
        this.sort.sortChange.emit({ active: 'fechaVenta', direction: 'desc' });

        this.loading = false;
      },
      error: () => {
        this.loading = false;
        this.snackBar.open('Error al cargar ventas', '', { duration: 3000 });
      },
    });
  }

  onSearchTextChange(event: Event): void {
    const input = (event.target as HTMLInputElement).value.trim();
    this.searchText = input;
    this.applyFilter();
  }

  onDateChange(): void {
    this.applyFilter();
  }

  private applyFilter(): void {
    const filtro = {
      text: this.searchText,
      from: this.fechaDesde?.toISOString() ?? null,
      to: this.fechaHasta?.toISOString() ?? null,
    };
    this.dataSource.filter = JSON.stringify(filtro);
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

  activarVenta(id: number): void {
    this.api.activarVenta(id).subscribe({
      next: () => {
        this.snackBar.open('Venta reactivada correctamente', '', { duration: 3000 });
        this.cargarVentas();
      },
      error: (err) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }
}
