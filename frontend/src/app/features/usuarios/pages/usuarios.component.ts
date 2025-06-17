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
import { TranslateModule } from '@ngx-translate/core';
import { forkJoin, switchMap, map } from 'rxjs';

import { Usuario } from 'src/app/core/models/auth/usuario.model';
import { UsuarioApiService } from 'src/app/infrastructure/api/usuario/usuario-api.service';
import { UsuariosCreateEditDialogComponent } from './create-edit-dialog/usuarios-create-edit-dialog.component';
import { UsuariosCambiarPasswordDialogComponent } from './cambiar-password-dialog/usuarios-cambiar-password-dialog.component';

@Component({
  selector: 'app-usuarios',
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
    TranslateModule,
  ],
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UsuariosComponent implements OnInit {
  dataSource = new MatTableDataSource<Usuario>();
  loading = false;
  displayedColumns = ['usuarioID', 'nombreUsuario', 'email', 'roles', 'twoFA', 'fechaRegistro', 'estado', 'acciones'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild('searchInput') searchInput!: ElementRef<HTMLInputElement>;

  constructor(
    private api: UsuarioApiService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar,
  ) {}

  ngOnInit(): void {
    this.cargarUsuarios();
  }

  private cargarUsuarios(): void {
    this.loading = true;
    this.api
      .obtenerUsuarios()
      .pipe(
        switchMap((users: Usuario[]) => {
          const requests = users.map((u) =>
            this.api.obtenerRolesDeUsuario(u.usuarioID).pipe(
              map((roles) => {
                u.roles = roles;
                return u;
              })
            )
          );
          return forkJoin(requests);
        })
      )
      .subscribe({
        next: (users: Usuario[]) => {
          this.dataSource.data = users;
          this.dataSource.paginator = this.paginator;
          this.dataSource.sort = this.sort;
          this.dataSource.filterPredicate = (u: Usuario, filter: string) =>
            u.nombreUsuario.toLowerCase().includes(filter) || u.email.toLowerCase().includes(filter);
          this.loading = false;
        },
        error: () => {
          this.loading = false;
          this.snackBar.open('Error al cargar usuarios', '', { duration: 3000 });
        },
      });
  }

  filtrarUsuario(event: Event): void {
    const filtro = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filtro;
  }

  clearFilter(): void {
    this.dataSource.filter = '';
    this.searchInput.nativeElement.value = '';
  }

  nuevoUsuario(): void {
    const ref = this.dialog.open(UsuariosCreateEditDialogComponent, {
      width: '500px',
      data: {},
    });
    ref.afterClosed().subscribe((created: boolean) => {
      if (created) this.cargarUsuarios();
    });
  }

  editarUsuario(usuario: Usuario): void {
    const ref = this.dialog.open(UsuariosCreateEditDialogComponent, {
      width: '500px',
      data: { usuario },
    });
    ref.afterClosed().subscribe((updated: boolean) => {
      if (updated) this.cargarUsuarios();
    });
  }

  cambiarPassword(usuario: Usuario): void {
    const ref = this.dialog.open(UsuariosCambiarPasswordDialogComponent, {
      width: '400px',
      data: { userId: usuario.usuarioID },
    });
    ref.afterClosed().subscribe();
  }

  eliminarUsuario(id: number): void {
    this.api.eliminarUsuario(id).subscribe({
      next: () => {
        this.snackBar.open('Usuario eliminado correctamente', '', { duration: 3000 });
        this.cargarUsuarios();
      },
      error: (err: Error) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }

  restaurarUsuario(id: number): void {
    this.api.restaurarUsuario(id).subscribe({
      next: () => {
        this.snackBar.open('Usuario restaurado', '', { duration: 3000 });
        this.cargarUsuarios();
      },
      error: (err) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }
}
