// src/main.ts
import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';

// registrar localización
import { registerLocaleData } from '@angular/common';
import localeEs from '@angular/common/locales/es';
import localeZhHans from '@angular/common/locales/zh-Hans';
import localeZhHant from '@angular/common/locales/zh-Hant';

registerLocaleData(localeEs);        // registro bajo 'es'
registerLocaleData(localeZhHans);    // registro bajo 'zh-Hans'
registerLocaleData(localeZhHant);    // registro bajo 'zh-Hant'

bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));
// El archivo main.ts es el punto de entrada de la aplicación Angular. Aquí se configura la aplicación y se inicia el proceso de arranque.