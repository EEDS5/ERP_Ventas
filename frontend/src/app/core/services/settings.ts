import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';

export type AppTheme = 'light' | 'dark' | 'auto';

export interface AppSettings {
  navPos: 'side' | 'top';
  dir: 'ltr' | 'rtl';
  theme: AppTheme;
  showHeader: boolean;
  headerPos: 'fixed' | 'static' | 'above';
  showUserPanel: boolean;
  sidenavOpened: boolean;
  sidenavCollapsed: boolean;
  language: string;
}

export const defaults: AppSettings = {
  navPos: 'side',
  theme: 'auto',
  dir: 'ltr',
  showHeader: true,
  headerPos: 'fixed',
  showUserPanel: true,
  sidenavOpened: true,
  sidenavCollapsed: false,
  language: 'auto',
};

@Injectable({ providedIn: 'root' })
export class SettingsService {
  constructor(private translate: TranslateService) {}

  private appSettings: AppSettings = { ...defaults };

  get options(): AppSettings {
    return this.appSettings;
  }

  setOptions(newSettings: AppSettings) {
    this.appSettings = { ...newSettings };
  }

  reset(): void {
    this.appSettings = { ...defaults };
  }

  setLanguage(lang: string): void {
    this.appSettings.language = lang;
    this.translate.use(lang); // ahora sí existe this.translate
  }

  setTheme() {
    // lógica para tema
  }

  setDirection() {
    document.documentElement.dir = this.appSettings.dir;
  }
}
