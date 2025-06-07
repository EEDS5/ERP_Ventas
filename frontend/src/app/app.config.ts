// src/app/app.config.ts
import { importProvidersFrom, APP_INITIALIZER, LOCALE_ID } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClientModule, HTTP_INTERCEPTORS, HttpClient } from '@angular/common/http';
import { provideRouter, withHashLocation } from '@angular/router';
import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';
import { MatSnackBarModule } from '@angular/material/snack-bar';

/* import * as echarts from 'echarts/core';
import { NgxEchartsModule } from 'ngx-echarts'; */

import { routes } from './app.routes';
import { JwtInterceptor } from './core/interceptors/jwt.interceptor';
import { ErrorInterceptor } from './core/interceptors/error.interceptor';

import { initNgMateroLayoutFactory } from './core/config/init-layout.config';
import { MenuService } from './core/services/menu.service';
import { SettingsService } from './core/services/settings.service';

import { NgxPermissionsModule } from 'ngx-permissions';

// fábrica para cargar JSON de assets/i18n/*.json
export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
}

export const appConfig = {
  providers: [
    importProvidersFrom(
      BrowserModule,
      BrowserAnimationsModule,
      HttpClientModule,
      MatSnackBarModule,
      // Configuración de ngx-echarts
      /* NgxEchartsModule.forRoot({ echarts }), */
      // Modulo de traducción
      TranslateModule.forRoot({
        defaultLanguage: 'en-US',
        loader: {
          provide: TranslateLoader,
          useFactory: HttpLoaderFactory,
          deps: [HttpClient],
        },
      }),
      NgxPermissionsModule.forRoot(),
    ),
    provideRouter(routes, withHashLocation()),
    { provide: HTTP_INTERCEPTORS, useClass: JwtInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true },

    {
      provide: LOCALE_ID,
      useFactory: (settingsService: SettingsService) => {
        const lang = settingsService.options.language; // e.g. 'es-ES', 'zh-CN', etc.

        if (lang.startsWith('es')) {
          return 'es'; // coincide con registerLocaleData(localeEs)
        }
        if (lang.startsWith('zh-CN')) {
          return 'zh-Hans'; // coincide con registerLocaleData(localeZhHans)
        }
        if (lang.startsWith('zh-TW')) {
          return 'zh-Hant'; // coincide con registerLocaleData(localeZhHant)
        }
        return 'en-US'; // por defecto
      },
      deps: [SettingsService],
    },

    {
      provide: APP_INITIALIZER,
      useFactory: initNgMateroLayoutFactory,
      deps: [MenuService, SettingsService],
      multi: true,
    },
  ],
};
// El interceptor de errores se encarga de gestionar los errores de las peticiones HTTP
