// frontend/src/app/app.routes.ts

import { Routes } from '@angular/router';
import { AuthGuard } from './core/guards/auth.guard';
import { AdminLayoutComponent } from './infrastructure/ui/theme/admin-layout/admin-layout.component';

export const routes: Routes = [
  // (1) Home público
  {
    path: '',
    pathMatch: 'full',
    loadChildren: () => import('./features/home/home.module').then((m) => m.HomeModule),
  },

  // (2) Auth completo bajo /auth
  {
    path: 'auth',
    loadChildren: () => import('./features/auth/auth.module').then((m) => m.AuthModule),
  },

  // (3) Resto protegido bajo el layout Admin
  {
    path: '',
    component: AdminLayoutComponent,
    canActivate: [AuthGuard],
    children: [
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' },

      // ====== RUTAS DE DASHBOARD / VENTAS / REPORTES ======

      {
        path: 'dashboard',
        loadComponent: () =>
          import('./features/dashboard/pages/dashboard.component').then(
            (m) => m.DashboardComponent,
          ),
      },
      {
        path: 'ventas',
        loadComponent: () =>
          import('./features/ventas/pages/ventas.component').then((m) => m.VentasComponent),
      },
      {
        path: 'clientes',
        loadComponent: () =>
          import('./features/clientes/pages/clientes.component').then((m) => m.ClientesComponent),
      },
      {
        path: 'reporte-ventas',
        loadComponent: () =>
          import('./features/reportes/pages/reporte-ventas/reporte-ventas.component').then(
            (m) => m.ReporteVentasComponent,
          ),
      },
      {
        path: 'facturacion-mensual',
        loadComponent: () =>
          import(
            './features/reportes/pages/reporte-facturacion/reporte-facturacion.component'
          ).then((m) => m.ReporteFacturacionComponent),
      },
      {
        path: 'cuentas-por-cobrar',
        loadComponent: () =>
          import(
            './features/reportes/pages/reporte-cuentas-por-cobrar/reporte-cuentas-por-cobrar.component'
          ).then((m) => m.ReporteCuentasPorCobrarComponent),
      },

      // ====== RUTAS DE PRODUCTOS ======
      {
        path: 'productos',
        loadComponent: () =>
          import('./features/productos/pages/productos.component').then(
            (m) => m.ProductosComponent,
          ),
      },
      {
        path: 'categorias',
        loadComponent: () =>
          import('./features/categorias/pages/categorias.component').then(
            (m) => m.CategoriasComponent,
          ),
      },
      {
        path: 'usuarios',
        loadComponent: () =>
          import('./features/usuarios/pages/usuarios.component').then(
            (m) => m.UsuariosComponent,
          ),
      },

      // ====== RUTAS DE PERFIL ======
      {
        path: 'profile',
        children: [
          {
            path: 'overview',
            loadComponent: () =>
              import('./features/profile/pages/profile-overview/profile-overview.component').then(
                (m) => m.ProfileOverviewComponent,
              ),
          },
          {
            path: 'settings',
            loadComponent: () =>
              import('./features/profile/pages/profile-settings/profile-settings.component').then(
                (m) => m.ProfileSettingsComponent,
              ),
          },
          { path: '', redirectTo: 'overview', pathMatch: 'full' },
        ],
      },
    ],
  },

  // (4) Wildcard global (si no coincide con nada, va al home público)
  { path: '**', redirectTo: '' },
];
