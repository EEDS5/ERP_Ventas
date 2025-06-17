import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { TranslateModule } from '@ngx-translate/core';

import { UsuarioApiService } from 'src/app/infrastructure/api/usuario/usuario-api.service';
import { UpdateUserPasswordDTO } from 'src/app/core/models/auth/update-user-password-dto.model';

@Component({
  selector: 'app-usuarios-cambiar-password-dialog',
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
  templateUrl: './usuarios-cambiar-password-dialog.component.html',
  styleUrls: ['./usuarios-cambiar-password-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UsuariosCambiarPasswordDialogComponent implements OnInit {
  form!: FormGroup;

  constructor(
    private fb: FormBuilder,
    private api: UsuarioApiService,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: { userId: number },
    private dialogRef: MatDialogRef<UsuariosCambiarPasswordDialogComponent>,
  ) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      currentPassword: ['', Validators.required],
      newPassword: ['', Validators.required],
    });
  }

  submit(): void {
    if (this.form.invalid) return;

    const dto: UpdateUserPasswordDTO = this.form.value;
    this.api.cambiarPassword(this.data.userId, dto).subscribe({
      next: () => {
        this.snackBar.open('Contraseña actualizada correctamente', '', { duration: 3000 });
        this.dialogRef.close(true);
      },
      error: (err: Error) => {
        this.snackBar.open(`Error: ${err.message}`, '', { duration: 5000 });
      },
    });
  }

  cancelar(): void {
    this.dialogRef.close();
  }
}
