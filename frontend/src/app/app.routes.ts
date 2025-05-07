// src/app/app.routes.ts
import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', loadChildren: () => import('./features/home/home.module').then((m) => m.HomeModule) },
  {
    path: 'login',
    loadChildren: () => import('./features/auth/auth.module').then((m) => m.AuthModule),
  },
  {
    path: 'register', 
    loadComponent: () =>
      import('./features/auth/components/register/register.component').then(
        (m) => m.RegisterComponent,
      ),
  },
  {
    path: 'dashboard',
    loadComponent: () =>
      import('./features/dashboard/pages/dashboard.component').then((m) => m.DashboardComponent),
  },
  {
    path: 'ventas',
    loadChildren: () => import('./features/ventas/ventas.module').then((m) => m.VentasModule),
  },
  { path: '**', redirectTo: '' },
];

// This file defines the routes for the application. It uses lazy loading to load feature modules only when needed.
