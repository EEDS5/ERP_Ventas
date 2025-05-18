import { Component, HostListener, inject } from '@angular/core';
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

  /* ---------------------- 2FA ---------------------- */
  enviar(): void {
    const user = this.authService.getUser();
    if (!user) {
      this.snackBar.open('Debes iniciar sesión primero.', 'Cerrar', { duration: 3000 });
      this.router.navigate(['/auth/login']);
      return;
    }

    const token2FA = this.form.value.token2FA!;
    this.authService.login2FA(user.nombreUsuario, token2FA).subscribe({
      next: (res) => {
        localStorage.setItem('token', res.token);
        this.authService.setUser(user);
        this.snackBar.open('¡2FA activado y autenticado correctamente!', 'Cerrar', {
          duration: 5000,
        });
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

  /* ------------------- Parallax -------------------- */
  @HostListener('document:mousemove', ['$event'])
  onMouseMove(e: MouseEvent) {
    const x = e.clientX / window.innerWidth - 0.5;
    const y = e.clientY / window.innerHeight - 0.5;
    document.documentElement.style.setProperty('--bg-shift-x', `${x * 30}px`);
    document.documentElement.style.setProperty('--bg-shift-y', `${y * 30}px`);
  }
}
