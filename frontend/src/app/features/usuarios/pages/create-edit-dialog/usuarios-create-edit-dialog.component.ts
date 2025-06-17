import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { TranslateModule } from '@ngx-translate/core';

import { Usuario } from 'src/app/core/models/auth/usuario.model';
import { UsuarioApiService, RegisterUserDTO } from 'src/app/infrastructure/api/usuario/usuario-api.service';
import { UpdateUserDTO } from 'src/app/core/models/auth/update-user-dto.model';

@Component({
  selector: 'app-usuarios-create-edit-dialog',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatSnackBarModule,
    TranslateModule,
  ],
  templateUrl: './usuarios-create-edit-dialog.component.html',
  styleUrls: ['./usuarios-create-edit-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UsuariosCreateEditDialogComponent implements OnInit {
  form!: FormGroup;
  isEdit: boolean;

  constructor(
    private fb: FormBuilder,
    private api: UsuarioApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { usuario?: Usuario },
    private dialogRef: MatDialogRef<UsuariosCreateEditDialogComponent>,
  ) {
    this.isEdit = !!data.usuario;
  }

  ngOnInit(): void {
    this.form = this.fb.group({
      nombreUsuario: [this.data.usuario?.nombreUsuario ?? '', Validators.required],
      email: [this.data.usuario?.email ?? '', [Validators.required, Validators.email]],
      password: [''],
    });

    if (this.isEdit) {
      this.form.removeControl('password');
    } else {
      this.form.get('password')?.addValidators(Validators.required);
    }
  }

  submit(): void {
    if (this.form.invalid) return;

    if (this.isEdit && this.data.usuario) {
      const dto: UpdateUserDTO = {
        nombreUsuario: this.form.value.nombreUsuario,
        email: this.form.value.email,
      };
      this.api.updateUsuario(this.data.usuario.usuarioID, dto).subscribe({
        next: () => {
          this.snackBar.open('Usuario actualizado correctamente', '', { duration: 3000 });
          this.dialogRef.close(true);
        },
        error: (err: Error) => {
          this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
        },
      });
    } else {
      const dto: RegisterUserDTO = {
        nombreUsuario: this.form.value.nombreUsuario,
        email: this.form.value.email,
        password: this.form.value.password,
      };
      this.api.register(dto).subscribe({
        next: () => {
          this.snackBar.open('Usuario creado correctamente', '', { duration: 3000 });
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
