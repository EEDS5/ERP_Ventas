import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../../../core/services/auth.service';
import { JwtResponseDTO } from '../../../../infrastructure/api/usuario-api.service';
import { CommonModule } from '@angular/common';

@Component({
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent {
  loginForm: FormGroup;
  errorMessage = '';
  twoFactorRequired = false;
  nombreUsuario = '';

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
  ) {
    this.loginForm = this.fb.group({
      nombreUsuario: ['', Validators.required],
      password: ['', Validators.required],
      verificationCode: [''], // Solo se usa si se requiere 2FA
    });
  }

  onSubmit(): void {
    if (this.twoFactorRequired) {
      this.loginWith2FA();
    } else {
      this.loginInitial();
    }
  }

  private loginInitial(): void {
    const { nombreUsuario, password } = this.loginForm.value;
    this.authService.login(nombreUsuario, password).subscribe({
      next: (response: JwtResponseDTO) => {
        // 1) Si el token es "2FA_REQUIRED", habilitamos el flujo de 2FA
        if (response.token === '2FA_REQUIRED') {
          this.twoFactorRequired = true;
          this.nombreUsuario = nombreUsuario;
          this.loginForm.get('password')?.disable();
        } else {
          // 2) Si no, tenemos ya un JWT válido: lo guardamos y navegamos
          localStorage.setItem('token', response.token);
          this.router.navigate(['/dashboard']);
        }
      },
      error: () => {
        this.errorMessage = 'Credenciales inválidas o usuario inactivo';
      },
    });
  }

  private loginWith2FA(): void {
    const verificationCode = this.loginForm.get('verificationCode')?.value;
    this.authService.login2FA(this.nombreUsuario, verificationCode).subscribe({
      next: (response) => {
        localStorage.setItem('token', response.token);
        this.router.navigate(['/dashboard']);
      },
      error: () => {
        this.errorMessage = 'Código 2FA incorrecto';
      },
    });
  }
}
