// src/app/app.routes.ts
import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./features/home/home.module').then(m => m.HomeModule)
  },
  {
    path: 'login',
    loadChildren: () => import('./features/auth/auth.module').then(m => m.AuthModule)
  },
  {
    path: 'ventas',
    loadChildren: () => import('./features/ventas/ventas.module').then(m => m.VentasModule)
  },
  {
    path: '**',
    redirectTo: ''
  }
];
// This file defines the routes for the application. It uses lazy loading to load feature modules only when needed.
