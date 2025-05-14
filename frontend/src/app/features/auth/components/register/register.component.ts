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
      next: (usuario) => {
        // 1) Guarda el usuario para el siguiente paso
        this.authService.setUser(usuario);

        // 2) Mensaje de éxito
        this.successMessage = '¡Registro exitoso! Redirigiendo a la configuración de 2FA…';

        // 3) Redirige a /login/setup-2fa (dentro del módulo lazy-loaded)
        setTimeout(() => this.router.navigate(['/auth', 'setup-2fa']), 1500);
      },
      error: (err) => {
        this.errorMessage = err?.error?.message || 'Error al registrar. Intenta de nuevo.';
      },
    });
  }
}
