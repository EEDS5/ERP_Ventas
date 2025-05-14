import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
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

  form = this.fb.group({
    token2FA: ['', [Validators.required, Validators.pattern(/^\d{6}$/)]],
  });

  enviar(): void {
    const user = this.authService.getUser();
    if (!user) {
      // Navegación sin return
      this.router.navigate(['/auth/login']);
      return;
    }

    const token2FA = this.form.value.token2FA!;
    this.authService.login2FA(user.nombreUsuario, token2FA).subscribe({
      next: (res) => {
        // Guardar JWT y estado de usuario
        localStorage.setItem('token', res.token);
        this.authService.setUser(user);

        alert('2FA activado y autenticado correctamente');
        // Navegación sin return
        this.router.navigate(['/dashboard']);
      },
      error: (err) => {
        console.error('Error al verificar 2FA:', err);
        alert('Código incorrecto o error al verificar.');
      },
    });
  }
}
