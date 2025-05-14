import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
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

  qrUrl = '';
  secret = '';

  ngOnInit(): void {
    const user = this.authService.getUser();
    if (!user) {
      this.router.navigate(['/login']);
      return;
    }

    this.authService['usuarioApi'].generate2FASecret(user.nombreUsuario).subscribe({
      next: (res: TwoFactorSetupResponseDTO) => {
        this.qrUrl = res.qrUrl;
        this.secret = res.secret;
      },
      error: (err) => {
        console.error('Error generando QR 2FA:', err);
        alert('Ocurrió un error al generar el código 2FA');
      },
    });
  }

  continuar(): void {
    this.router.navigate(['/auth', 'verify-2fa']);
  }
}
