// src/app/login/login.component.ts
import { Component } from '@angular/core';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html'
})
export class LoginComponent {
  username = '';
  password = '';
  twoFactorCode = '';
  twoFARequired = false;

  constructor(private authService: AuthService) {}

  onLogin() {
    const dto = {
      nombreUsuario: this.username,
      password: this.password
    };
    this.authService.login(dto).subscribe({
      next: (res) => {
        if (res === '2FA_REQUIRED') {
          this.twoFARequired = true;
        } else {
          console.log('Login OK, token:', res);
        }
      },
      error: (err) => { 
        console.error('Error login:', err);
      }
    });
  }

  onVerify2FA() {
    const dto = {
      nombreUsuario: this.username,
      token2FA: this.twoFactorCode
    };
    this.authService.verify2FA(dto).subscribe({
      next: (res) => {
        if (res === '2FA_OK') {
          console.log('2FA verificado. Usuario logueado.');
        } else {
          console.error('Token inválido');
        }
      },
      error: (err) => { 
        console.error('Error 2FA:', err);
      }
    });
  }
}
