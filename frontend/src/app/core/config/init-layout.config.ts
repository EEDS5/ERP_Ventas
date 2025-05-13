// src/app/core/config/init-layout.config.ts
import { MenuService } from '../services/menu.service';
import { SettingsService } from '../services/settings.service';

// Factory que Angular invoca dentro de un contexto de inyección
export function initNgMateroLayoutFactory(
  menuService: MenuService,
  settingsService: SettingsService
) {
  return () => {
    menuService.set([
      { route: 'dashboard', name: 'Dashboard', icon: 'dashboard', type: 'link', badge: { color: 'warn', value: '5' } },
      { route: 'sessions', name: 'Sessions', icon: 'event', type: 'sub', children: [
          { route: 'login', name: 'Login', type: 'link' },
          { route: 'register', name: 'Register', type: 'link' }
        ]
      }
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
