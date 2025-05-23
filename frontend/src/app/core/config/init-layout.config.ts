// src/app/core/config/init-layout.config.ts
import { MenuService } from '../services/menu.service';
import { SettingsService } from '../services/settings.service';

// Factory que Angular invoca dentro de un contexto de inyección
export function initNgMateroLayoutFactory(
  menuService: MenuService,
  settingsService: SettingsService,
) {
  return () => {
    menuService.set([
      {
        route: 'dashboard',
        name: 'Panel de Control',
        icon: 'dashboard',
        type: 'link',
        badge: { color: 'warn', value: '5' },
      },
      /* { route: 'sessions', name: 'Sessions', icon: 'event', type: 'sub', children: [
          { route: 'login', name: 'Login', type: 'link' },
          { route: 'register', name: 'Register', type: 'link' }
        ]
      } */
      {
        route: '',
        name: 'Gestión de Ventas',
        icon: 'point_of_sale',
        type: 'sub',
        children: [
          { route: 'ventas', name: 'Ventas', type: 'link' },
          { route: 'facturas', name: 'Facturas', type: 'link' },
          { route: 'detalle-ventas', name: 'Detalle de Ventas', type: 'link' },
        ],
      },
      {
        route: '',
        name: 'Clientes y Cobros',
        icon: 'people',
        type: 'sub',
        children: [
          { route: 'clientes', name: 'Clientes', type: 'link' },
          { route: 'cuentas-por-cobrar', name: 'Cuentas por Cobrar', type: 'link' },
          { route: 'pagos', name: 'Pagos', type: 'link' },
        ],
      },
      {
        route: '',
        name: 'Productos',
        icon: 'inventory_2',
        type: 'sub',
        children: [
          { route: 'productos', name: 'Productos', type: 'link' },
          { route: 'categorias', name: 'Categorías', type: 'link' },
        ],
      },
      {
        route: '',
        name: 'Pasarelas de Pago',
        icon: 'credit_card',
        type: 'sub',
        children: [
          { route: 'pasarelas', name: 'Pasarelas', type: 'link' },
          { route: 'transacciones', name: 'Transacciones', type: 'link' },
        ],
      },
      {
        route: '',
        name: 'Reportes',
        icon: 'bar_chart',
        type: 'sub',
        children: [
          { route: 'reporte-ventas', name: 'Historial de Ventas', type: 'link' },
          { route: 'reporte-facturacion', name: 'Facturación Mensual', type: 'link' },
          {
            route: 'reporte-facturacion-categoria',
            name: 'Facturación por Categoría',
            type: 'link',
          },
        ],
      },
      {
        route: '',
        name: 'Administración',
        icon: 'settings',
        type: 'sub',
        children: [
          { route: 'usuarios', name: 'Usuarios', type: 'link' },
          { route: 'metodos-pago', name: 'Métodos de Pago', type: 'link' },
          { route: 'pasarelas', name: 'Pasarelas de Pago', type: 'link' },
        ],
      },
    ]);
    settingsService.setOptions({
      navPos: 'side',
      theme: 'dark',
      dir: 'ltr',
      showHeader: true,
      headerPos: 'fixed',
      showUserPanel: true,
      sidenavOpened: true,
      sidenavCollapsed: false,
      language: 'en',
    });
  };
}
