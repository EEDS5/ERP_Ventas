// src/app/core/config/init-layout.config.ts
import { MenuService, Menu } from '../services/menu.service';
import { SettingsService } from '../services/settings.service';
import { RolesService } from '../services/roles.service';

// Factory que Angular invoca dentro de un contexto de inyección
export function initNgMateroLayoutFactory(
  menuService: MenuService,
  settingsService: SettingsService,
  rolesService: RolesService,
) {
  return () => {
    const menu: Menu[] = [];

    menu.push({
      route: 'dashboard',
      name: 'Panel de Control',
      icon: 'dashboard',
      type: 'link',
      /* badge: { color: 'warn', value: '5' }, */
    });

    /* { route: 'auth', name: 'Sessions', icon: 'event', type: 'sub', children: [
        { route: 'login', name: 'Login', type: 'link' },
        { route: 'register', name: 'Register', type: 'link' }
      ]
    }, */

    if (rolesService.hasAnyRole(['ADMINISTRADOR', 'VENDEDOR'])) {
      menu.push({
        route: '',
        name: 'Gestión de Ventas',
        icon: 'point_of_sale',
        type: 'sub',
        children: [
          { route: 'ventas', name: 'Ventas', type: 'link' },
          /* { route: 'facturas', name: 'Facturas', type: 'link' },
          { route: 'detalle-ventas', name: 'Detalle de Ventas', type: 'link' }, */
        ],
      });
    }

    /* {
      route: '',
      name: 'Clientes y Cobros',
      icon: 'people',
      type: 'sub',
      children: [
        { route: 'clientes', name: 'Clientes', type: 'link' },
        { route: 'cuentas-por-cobrar', name: 'Cuentas por Cobrar', type: 'link' },
        { route: 'pagos', name: 'Pagos', type: 'link' },
      ],
    }, */

    if (rolesService.hasAnyRole(['ADMINISTRADOR', 'INVENTARIO'])) {
      menu.push({
        route: '',
        name: 'Productos',
        icon: 'inventory_2',
        type: 'sub',
        children: [
          { route: 'productos', name: 'Productos', type: 'link' },
          { route: 'categorias', name: 'Categorías', type: 'link' },
        ],
      });
    }

    /* {
      route: '',
      name: 'Pasarelas de Pago',
      icon: 'credit_card',
      type: 'sub',
      children: [
        { route: 'pasarelas', name: 'Pasarelas', type: 'link' },
        { route: 'transacciones', name: 'Transacciones', type: 'link' },
      ],
    }, */

    if (rolesService.hasAnyRole(['ADMINISTRADOR', 'CONTADOR'])) {
      menu.push({
        route: '',
        name: 'Reportes',
        icon: 'bar_chart',
        type: 'sub',
        children: [
          { route: 'reporte-ventas', name: 'Historial de Ventas', type: 'link' },
          { route: 'facturacion-mensual', name: 'Facturación Mensual', type: 'link' },
          { route: 'cuentas-por-cobrar', name: 'Cuentas por Cobrar y Pagos', type: 'link' },
        ],
      });
    }

    if (rolesService.hasRole('ADMINISTRADOR')) {
      menu.push({
        route: '',
        name: 'Administración',
        icon: 'settings',
        type: 'sub',
        children: [
          { route: 'usuarios', name: 'Usuarios', type: 'link' },
          /* { route: 'metodos-pago', name: 'Métodos de Pago', type: 'link' },
          { route: 'pasarelas', name: 'Pasarelas de Pago', type: 'link' }, */
        ],
      });
    }

    menuService.set(menu);

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
