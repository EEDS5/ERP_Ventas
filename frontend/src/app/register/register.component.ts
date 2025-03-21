// src/app/register/register.component.ts
import { Component } from '@angular/core';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html'
})
export class RegisterComponent {
  username = '';
  email = '';
  password = '';

  constructor(private authService: AuthService) {}

  onRegister() {
    const dto = {
      nombreUsuario: this.username,
      email: this.email,
      password: this.password
    };
    this.authService.register(dto).subscribe({
      next: (res) => { 
        console.log('Usuario registrado:', res);
      },
      error: (err) => { 
        console.error('Error:', err);
      }
    });
  }
}
