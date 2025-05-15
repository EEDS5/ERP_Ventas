import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { AuthService } from '@core/services/auth.service';

@Component({
  selector: 'app-verify-two-fa',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './verify-two-fa.component.html',
})
export class VerifyTwoFaComponent {
  private fb = inject(FormBuilder);
  private authService = inject(AuthService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);

  form = this.fb.group({
    token2FA: ['', [Validators.required, Validators.pattern(/^\d{6}$/)]],
  });

  enviar(): void {
    const user = this.authService.getUser();
    if (!user) {
      this.snackBar.open('Debes iniciar sesión primero.', 'Cerrar', { duration: 3000 });
      // Redirigir a la página de inicio de sesión
      this.router.navigate(['/auth/login']);
      return;
    }

    const token2FA = this.form.value.token2FA!;
    this.authService.login2FA(user.nombreUsuario, token2FA).subscribe({
      next: (res) => {
        // Guardar JWT y estado de usuario
        localStorage.setItem('token', res.token);
        this.authService.setUser(user);

        this.snackBar.open('¡2FA activado y autenticado correctamente!', 'Cerrar', {
          duration: 5000,
        });
        // Redirigir al dashboard
        this.router.navigate(['/dashboard']);
      },
      error: (err) => {
        console.error('Error al verificar 2FA:', err);
        this.snackBar.open('Código incorrecto o error al verificar.', 'Cerrar', {
          duration: 5000,
        });
      },
    });
  }
}
