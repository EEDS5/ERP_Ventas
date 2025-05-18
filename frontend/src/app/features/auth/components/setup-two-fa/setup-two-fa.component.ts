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
  styleUrls: ['./setup-two-fa.component.scss']
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
    const x = e.clientX / window.innerWidth - 0.5;
    const y = e.clientY / window.innerHeight - 0.5;

    // Parallax general
    document.documentElement.style.setProperty('--bg-shift-x', `${x * 30}px`);
    document.documentElement.style.setProperty('--bg-shift-y', `${y * 30}px`);

    // Tilt específico para la QR card
    const tiltX = x * 10;   // rotación Y
    const tiltY = -y * 10;  // rotación X
    document.documentElement.style.setProperty('--tiltX', `${tiltX}deg`);
    document.documentElement.style.setProperty('--tiltY', `${tiltY}deg`);
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
