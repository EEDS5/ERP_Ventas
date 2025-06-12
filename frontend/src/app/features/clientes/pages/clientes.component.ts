import { Component, OnInit, ChangeDetectionStrategy, ViewChild, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatCardModule } from '@angular/material/card';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

import { Cliente } from 'src/app/core/models/clientes/cliente.model';
import { ClientesApiService } from 'src/app/infrastructure/api/clientes/clientes-api.service';
import { ClientesCreateEditDialogComponent } from './clientes-create-edit-dialog.component';

@Component({
  selector: 'app-clientes',
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
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ClientesComponent implements OnInit {
  dataSource = new MatTableDataSource<Cliente>();
  loading = false;
  displayedColumns = ['nombre', 'correo', 'telefono', 'acciones'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild('searchInput') searchInput!: ElementRef<HTMLInputElement>;

  constructor(
    private api: ClientesApiService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar,
  ) {}

  ngOnInit(): void {
    this.cargarClientes();
  }

  private cargarClientes(): void {
    this.loading = true;
    this.api.obtenerClientes().subscribe({
      next: (data: Cliente[]) => {
        this.dataSource.data = data.filter(c => c.activo);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
        this.snackBar.open('Error al cargar clientes', '', { duration: 3000 });
      },
    });
  }

  filtrar(event: Event): void {
    const filtro = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filtro;
  }

  clearFilter(): void {
    this.dataSource.filter = '';
    this.searchInput.nativeElement.value = '';
  }

  nuevoCliente(): void {
    const ref = this.dialog.open(ClientesCreateEditDialogComponent, {
      width: '500px',
      data: {},
    });
    ref.afterClosed().subscribe((created: boolean) => {
      if (created) this.cargarClientes();
    });
  }

  editarCliente(cliente: Cliente): void {
    const ref = this.dialog.open(ClientesCreateEditDialogComponent, {
      width: '500px',
      data: { cliente },
    });
    ref.afterClosed().subscribe((updated: boolean) => {
      if (updated) this.cargarClientes();
    });
  }

  eliminarCliente(id: number): void {
    this.api.eliminarCliente(id).subscribe({
      next: () => {
        this.snackBar.open('Cliente eliminado correctamente', '', { duration: 3000 });
        this.cargarClientes();
      },
      error: (err: Error) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }
}
