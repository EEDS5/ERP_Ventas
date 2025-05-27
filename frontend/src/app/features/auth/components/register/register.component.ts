import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../../../core/services/auth.service';
import { CommonModule } from '@angular/common';

@Component({
  standalone: true,
  selector: 'app-register',
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
})
export class RegisterComponent {
  registerForm: FormGroup;
  errorMessage = '';
  successMessage = '';

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
  ) {
    this.registerForm = this.fb.group({
      nombreUsuario: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
    });
  }

  onSubmit(): void {
    if (this.registerForm.invalid) return;

    const { nombreUsuario, email, password } = this.registerForm.value;

    this.authService.register(nombreUsuario, email, password).subscribe({
      next: (res) => {
        // 1) Guardar el token temporal en localStorage
        if (res.token) {
          localStorage.setItem('token', res.token);
        }

        // 2) Guardar el usuario para futuras referencias
        if (res.user) {
          this.authService.setUser(res.user);
        }

        // 3) Mostrar mensaje de éxito y redirigir al setup de 2FA
        this.successMessage = '¡Registro exitoso! Redirigiendo a la configuración de 2FA…';
        setTimeout(() => this.router.navigate(['/auth', 'setup-2fa']), 1500);
      },
      error: (err) => {
        this.errorMessage = err?.error?.message || 'Error al registrar. Intenta de nuevo.';
      },
    });
  }
}
