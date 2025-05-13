// src/app/app.routes.ts
import { Routes } from '@angular/router';
import { AuthGuard } from './core/guards/auth.guard';
import { AdminLayoutComponent } from './infrastructure/ui/theme/admin-layout/admin-layout.component';

export const routes: Routes = [
  // 1) Pantalla de inicio públic­a (ruta exacta '/')
  {
    path: '',
    pathMatch: 'full',
    loadChildren: () =>
      import('./features/home/home.module').then(m => m.HomeModule),
  },

  // 2) Autenticación pública
  {
    path: 'login',
    loadChildren: () =>
      import('./features/auth/auth.module').then(m => m.AuthModule),
  },
  {
    path: 'register',
    loadComponent: () =>
      import('./features/auth/components/register/register.component')
        .then(m => m.RegisterComponent),
  },

  // 3) Shell protegido: AdminLayoutComponent envuelve todo lo demás
  {
    path: '',
    component: AdminLayoutComponent,
    canActivate: [AuthGuard],
    children: [
      // 3.a) Redirige '' → dashboard si ya estás autenticado
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' },

      // 3.b) Dashboard
      {
        path: 'dashboard',
        loadComponent: () =>
          import('./features/dashboard/pages/dashboard.component')
            .then(m => m.DashboardComponent),
      },

      // 3.c) Ventas (y resto de rutas protegidas)
      {
        path: 'ventas',
        loadChildren: () =>
          import('./features/ventas/ventas.module').then(m => m.VentasModule),
      },
      // ← aquí podrías añadir más hijos protegidos
    ],
  },

  // 4) Cualquier otra ruta no válida
  { path: '**', redirectTo: '' },
];
