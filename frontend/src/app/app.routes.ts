// src/app/app.routes.ts
import { Routes } from '@angular/router';
import { AuthGuard } from './core/guards/auth.guard';
import { AdminLayoutComponent } from './infrastructure/ui/theme/admin-layout/admin-layout.component';

export const routes: Routes = [
  // 1) Rutas públicas (login/register)
  {
    path: 'login',
    loadChildren: () => import('./features/auth/auth.module').then(m => m.AuthModule),
  },
  {
    path: 'register',
    loadComponent: () =>
      import('./features/auth/components/register/register.component')
        .then(m => m.RegisterComponent),
  },

  // 2) Shell protegido: aquí dentro va TODO lo que use el layout de Ng-Matero
  {
    path: '',
    component: AdminLayoutComponent,
    canActivate: [AuthGuard],     // protege todo el subtree
    children: [
      // ruta por defecto
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' },

      // dashboard
      {
        path: 'dashboard',
        loadComponent: () =>
          import('./features/dashboard/pages/dashboard.component')
            .then(m => m.DashboardComponent),
      },

      // ventas (y cualquier otra ruta protegida)
      {
        path: 'ventas',
        loadChildren: () =>
          import('./features/ventas/ventas.module').then(m => m.VentasModule),
      },
    ],
  },

  // 3) Cualquier otra va a login
  { path: '**', redirectTo: 'login' },
];
