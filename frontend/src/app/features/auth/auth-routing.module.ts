// src/app/features/auth/auth-routing.module.ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginComponent }      from './components/login/login.component';
import { RegisterComponent }   from './components/register/register.component';
import { SetupTwoFaComponent } from './components/setup-two-fa/setup-two-fa.component';
import { VerifyTwoFaComponent }from './components/verify-two-fa/verify-two-fa.component';

const routes: Routes = [
  { path: 'login',       component: LoginComponent },
  { path: 'register',    component: RegisterComponent },
  { path: 'setup-2fa',   component: SetupTwoFaComponent },
  { path: 'verify-2fa',  component: VerifyTwoFaComponent },
  // opcional: redirect por defecto de /auth → /auth/login
  { path: '', redirectTo: 'login', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AuthRoutingModule {}
