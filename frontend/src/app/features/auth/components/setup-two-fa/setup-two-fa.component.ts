import { Component, inject, HostListener, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { AuthService } from '@core/services/auth.service';
import { TwoFactorSetupResponseDTO } from '@core/models/twofactor-setup-response.dto';

@Component({
  selector: 'app-setup-two-fa',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './setup-two-fa.component.html',
})
export class SetupTwoFaComponent implements OnInit {
  private authService = inject(AuthService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);

  qrUrl = '';
  secret = '';

  /* ---------------- Parallax interactivo ---------------- */
  @HostListener('document:mousemove', ['$event'])
  onMouseMove(e: MouseEvent) {
    // Normalizamos de –0.5 a 0.5
    const x = e.clientX / window.innerWidth - 0.5;
    const y = e.clientY / window.innerHeight - 0.5;
    // Actualizamos variables CSS para usar en el SCSS
    document.documentElement.style.setProperty('--bg-shift-x', `${x * 30}px`);
    document.documentElement.style.setProperty('--bg-shift-y', `${y * 30}px`);
  }

  ngOnInit(): void {
    const user = this.authService.getUser();
    if (!user) {
      this.router.navigate(['/login']);
      return;
    }

    this.authService['usuarioApi']
      .generate2FASecret(user.nombreUsuario)
      .subscribe({
        next: (res: TwoFactorSetupResponseDTO) => {
          this.qrUrl = res.qrUrl;
          this.secret = res.secret;
        },
        error: (err) => {
          console.error('Error generando QR 2FA:', err);
          this.snackBar.open('Error al generar el código 2FA.', 'Cerrar', {
            duration: 5000,
          });
        },
      });
  }

  continuar(): void {
    this.router.navigate(['/auth', 'verify-2fa']);
  }
}
