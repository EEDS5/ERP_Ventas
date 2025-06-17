import {
  Component,
  OnInit,
  ChangeDetectionStrategy,
  inject,
  ChangeDetectorRef,
} from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatDividerModule } from '@angular/material/divider';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { TranslateModule } from '@ngx-translate/core';
import { MatSnackBar } from '@angular/material/snack-bar';

import { Observable } from 'rxjs';
import { shareReplay, take } from 'rxjs/operators';

import { ProfileService } from '@core/services/profile.service';
import { Usuario } from '@core/models/auth/usuario.model';
import { ChangePasswordDialogComponent } from '../components/profile/change-password-dialog.component';
import { UsuarioApiService } from '../../../../infrastructure/api/usuario/usuario-api.service';
import { TwoFactorSetupResponseDTO } from '@core/models/auth/twofactor-setup-response.dto';

type UpdateUsuarioDTO = Partial<Usuario> & {
  secret2FA?: string;
  twoFAEnabled?: boolean;
};

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
  private readonly dialog = inject(MatDialog);
  private readonly usuarioApi = inject(UsuarioApiService);
  private readonly cdr = inject(ChangeDetectorRef);
  private readonly translate = inject(TranslateService);
  private readonly snackBar = inject(MatSnackBar);

  // Datos del usuario
  public user$: Observable<Usuario> = this.profileService
    .getMyProfile()
    .pipe(shareReplay({ bufferSize: 1, refCount: true }));

  profileForm!: FormGroup;

  // 2FA
  isLoadingQR = false;
  setupQRData: TwoFactorSetupResponseDTO | null = null;

  ngOnInit(): void {
    this.buildForm();

    this.user$.pipe(take(1)).subscribe({
      next: (u) => {
        this.profileForm.patchValue({
          nombreUsuario: u.nombreUsuario,
          email: u.email,
        });
        // ← Aquí se sincroniza el estado real de 2FA
        this.twoFAEnabled = u.twoFAEnabled;
      },
      error: (err) => console.error('Error cargando perfil:', err),
    });
  }

  private buildForm() {
    this.profileForm = this.fb.group({
      nombreUsuario: ['', [Validators.required, Validators.minLength(4)]],
      email: ['', [Validators.required, Validators.email]],
      codigo2FA: [''],
    });
  }

  openChangePasswordDialog(): void {
    this.dialog.open(ChangePasswordDialogComponent, {
      width: '400px',
      panelClass: 'change-password-dialog-panel',
    });
  }

  onSubmit(): void {
    if (this.profileForm.invalid) {
      this.profileForm.markAllAsTouched();
      return;
    }

    const payload: UpdateUsuarioDTO = {
      nombreUsuario: this.profileForm.value.nombreUsuario,
      email: this.profileForm.value.email,
      twoFAEnabled: this.twoFAEnabled,
      // Solo incluir secret cuando se genere y valide:
      ...(this.setupQRData && this.profileForm.value.codigo2FA
        ? { secret2FA: this.setupQRData.secret }
        : {}),
    };

    // Validar código 2FA si se generó QR
    if (this.setupQRData && this.profileForm.value.codigo2FA) {
      const codigo: string = this.profileForm.value.codigo2FA;
      const nombreUsuario = this.profileForm.value.nombreUsuario!;

      this.usuarioApi.verify2FA({ nombreUsuario, token2FA: codigo }).subscribe({
        next: (result: string) => {
          if (result === '2FA_OK') {
            // Guardamos el secret y activamos 2FA
            payload.secret2FA = this.setupQRData!.secret;
            payload.twoFAEnabled = true;
            this.mostrarMensaje(this.translate.instant('2fa_enabled_successfully'));
            this.enviarActualizacion(payload);
          } else {
            alert(this.translate.instant('invalid_2fa_code'));
          }
        },
        error: (error: unknown) => {
          console.error('Error verificando código 2FA:', error);
          alert(this.translate.instant('error_verifying_2fa'));
        },
      });
    } else {
      this.enviarActualizacion(payload);
    }
  }

  private enviarActualizacion(payload: Partial<Usuario>) {
    this.profileService.updateMyProfile(payload).subscribe({
      next: () => {
        this.mostrarMensaje(this.translate.instant('profile_updated_successfully'));
        this.router.navigate(['/profile/overview']);
      },
      error: (err) => {
        console.error('Error al actualizar perfil:', err);
        this.mostrarMensaje(this.translate.instant('error_updating_profile'));
      },
    });
  }

  // Activación 2FA
  onGenerate2FA(): void {
    this.isLoadingQR = true;
    this.setupQRData = null;

    this.usuarioApi.generate2FASecret('EEDS').subscribe({
      next: (data) => {
        this.setupQRData = data;
        this.isLoadingQR = false;
        this.twoFAEnabled = true;
        this.cdr.detectChanges();
      },
      error: () => {
        this.isLoadingQR = false;
        alert('Error generando QR');
      },
    });
  }

  get nombreUsuarioControl() {
    return this.profileForm.get('nombreUsuario');
  }

  // Control interno para mostrar u ocultar botones de 2FA
  twoFAEnabled = false;

  // Simulación de desactivación 2FA
  onDisable2FA(): void {
    const username = this.profileForm.value.nombreUsuario!;
    this.usuarioApi.update2FAStatus(username, false).subscribe({
      next: () => {
        this.twoFAEnabled = false;
        this.setupQRData = null;
        this.mostrarMensaje(this.translate.instant('2fa_disabled_successfully'));
      },
      error: (err: unknown) => {
        console.error('Error deshabilitando 2FA:', err);
        this.mostrarMensaje(this.translate.instant('error_disabling_2fa'));
      },
    });
  }

  get emailControl() {
    return this.profileForm.get('email');
  }

  private mostrarMensaje(mensaje: string) {
    this.snackBar.open(mensaje, 'Cerrar', {
      duration: 3000,
      horizontalPosition: 'center',
      verticalPosition: 'bottom',
    });
  }
}
