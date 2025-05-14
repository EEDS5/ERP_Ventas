import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { AuthRoutingModule } from './auth-routing.module';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { SetupTwoFaComponent } from './components/setup-two-fa/setup-two-fa.component';
import { VerifyTwoFaComponent } from './components/verify-two-fa/verify-two-fa.component';

@NgModule({
  imports: [
    CommonModule,
    ReactiveFormsModule,
    AuthRoutingModule,
    LoginComponent,
    RegisterComponent,
    SetupTwoFaComponent, 
    VerifyTwoFaComponent
  ]
})
export class AuthModule {}
