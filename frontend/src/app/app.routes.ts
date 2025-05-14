// src/app/app.routes.ts
import { Routes } from '@angular/router';
import { AuthGuard } from './core/guards/auth.guard';
import { AdminLayoutComponent } from './infrastructure/ui/theme/admin-layout/admin-layout.component';

export const routes: Routes = [
  // 1) Home público
  {
    path: '',
    pathMatch: 'full',
    loadChildren: () =>
      import('./features/home/home.module').then(m => m.HomeModule),
  },

  // 2) Auth completo bajo /auth
  {
    path: 'auth',
    loadChildren: () =>
      import('./features/auth/auth.module').then(m => m.AuthModule),
  },

  // 3) Resto protegido
  {
    path: '',
    component: AdminLayoutComponent,
    canActivate: [AuthGuard],
    children: [
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
      {
        path: 'dashboard',
        loadComponent: () =>
          import('./features/dashboard/pages/dashboard.component')
            .then(m => m.DashboardComponent),
      },
      {
        path: 'ventas',
        loadChildren: () =>
          import('./features/ventas/ventas.module').then(m => m.VentasModule),
      },
    ],
  },

  // 4) Wildcard al home
  { path: '**', redirectTo: '' },
];
