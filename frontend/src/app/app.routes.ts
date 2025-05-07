// src/app/app.routes.ts
import { Routes } from '@angular/router';
import { AuthGuard } from './auth.guard';

export const routes: Routes = [
  { path: '', loadChildren: () => import('./features/home/home.module').then(m => m.HomeModule) },

  { path: 'login',
    loadChildren: () => import('./features/auth/auth.module').then(m => m.AuthModule)
  },
  { path: 'register',
    loadComponent: () => import('./features/auth/components/register/register.component').then(m => m.RegisterComponent)
  },

  // Rutas protegidas por el guardia de autenticación
  {
    path: 'dashboard',
    loadComponent: () => import('./features/dashboard/pages/dashboard.component')
                                   .then(m => m.DashboardComponent),
    canActivate: [AuthGuard]
  },
  {
    path: 'ventas',
    loadChildren: () => import('./features/ventas/ventas.module').then(m => m.VentasModule),
    canActivate: [AuthGuard]
  },

  { path: '**', redirectTo: 'login' }           // ← Opcional: redirige a login si no coincide ruta
];
