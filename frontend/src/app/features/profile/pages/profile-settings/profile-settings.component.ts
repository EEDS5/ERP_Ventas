// frontend/src/app/features/profile/pages/profile-settings/profile-settings.component.ts

import {
  Component,
  OnInit,
  ChangeDetectionStrategy,
  inject,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { TranslateModule } from '@ngx-translate/core';

import { MatDividerModule } from '@angular/material/divider';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

import { ProfileService } from '@core/services/profile.service';
import { Usuario } from '@core/models/auth/usuario.model';
import { finalize } from 'rxjs';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-profile-settings',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatDividerModule,
    MatIconModule,
    MatProgressSpinnerModule,
    RouterLink,
    TranslateModule,
  ],
  templateUrl: './profile-settings.component.html',
  styleUrls: ['./profile-settings.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProfileSettingsComponent implements OnInit {
  private readonly profileService = inject(ProfileService);
  private readonly fb = inject(FormBuilder);
  private readonly router = inject(Router);

  // Observable para el usuario, usado en la plantilla con async
  public user$: Observable<Usuario> = this.profileService.getMyProfile();

  /** Formulario reutilizable para editar perfil */
  profileForm!: FormGroup;

  /** Flag para deshabilitar botones mientras se hace la petición */
  isLoading = false;

  ngOnInit(): void {
    this.buildForm();
    this.loadUserData();
  }

  /** Construye el FormGroup con validaciones */
  private buildForm() {
    this.profileForm = this.fb.group({
      nombreUsuario: ['', [Validators.required, Validators.minLength(4)]],
      email: ['', [Validators.required, Validators.email]],
      // Si en el futuro quisieras agregar campos adicionales (e.g. avatarUrl),
      // los incluirías aquí.
    });
  }

  /** Carga datos actuales desde el servicio y rellena el formulario */
  private loadUserData() {
  this.isLoading = true;
  this.user$
    .pipe(finalize(() => (this.isLoading = false)))
    .subscribe({
      next: (user: Usuario) => {
        this.profileForm.patchValue({
          nombreUsuario: user.nombreUsuario,
          email: user.email,
        });
      },
      error: (err) => {
        console.error('Error al cargar perfil:', err);
      },
    });
}

  /** Se lanza al hacer submit del formulario */
  onSubmit(): void {
    if (this.profileForm.invalid) {
      this.profileForm.markAllAsTouched();
      return;
    }

    const payload: Partial<Usuario> = {
      nombreUsuario: this.profileForm.value.nombreUsuario,
      email: this.profileForm.value.email,
    };

    this.isLoading = true;
    this.profileService
      .updateMyProfile(payload)
      .pipe(finalize(() => (this.isLoading = false)))
      .subscribe({
        next: () => {
          // Después de actualizar, redirigimos a overview o mostramos un mensaje
          this.router.navigate(['/profile/overview']);
        },
        error: (err) => {
          console.error('Error al actualizar perfil:', err);
          // Aquí podrías abrir un MatSnackBar o Toastr con mensaje de error
        },
      });
  }

  /** Obtener control para manejar validaciones en la plantilla */
  get nombreUsuarioControl() {
    return this.profileForm.get('nombreUsuario');
  }

  get emailControl() {
    return this.profileForm.get('email');
  }
}
