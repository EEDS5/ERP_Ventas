import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { AppSettings, defaults } from '../settings';
import { BehaviorSubject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class SettingsService {
  // Idiomas soportados para evitar peticiones 404
  private readonly languages = ['en-US', 'es-ES', 'zh-CN', 'zh-TW'];
  private optionsSubject = new BehaviorSubject<AppSettings>({ ...defaults });
  public readonly notify$ = this.optionsSubject.asObservable();

  constructor(private translate: TranslateService) {
    // Registrar idiomas disponibles
    this.translate.addLangs(this.languages);
    // Determinar y usar el idioma inicial
    const initialLang = this.getTranslateLang();
    this.translate.use(initialLang);
    this.setOptions({ language: initialLang });
  }

  get options(): AppSettings {
    return this.optionsSubject.getValue();
  }

  setOptions(newOptions: Partial<AppSettings>): void {
    const updated = { ...this.options, ...newOptions };
    this.optionsSubject.next(updated);
  }

  reset(): void {
    this.optionsSubject.next({ ...defaults });
  }

  private getTranslateLang(): string {
    if (this.options.language === 'auto') {
      const browserLang = navigator.language; // p.ej. "es-BO" o "zh-Hans"
      // Extraemos solamente el prefijo de los primeros dos caracteres (minúsculas)
      const prefix = browserLang.slice(0, 2).toLowerCase(); // "es", "zh", etc.

      // Construimos un pequeño mapa de prefijo → idioma completo
      const prefixMap: Record<string, string> = {
        en: 'en-US',
        es: 'es-ES',
        zh: this.matchChineseVariant(browserLang),
        // si quieres mapear más prefijos (p. ej. 'pt' → 'pt-BR'), agrégalos aquí
      };

      // Si existe el prefijo en nuestro mapa, devolvemos ese idioma; si no, fallback a 'en-US'
      return prefixMap[prefix] || 'en-US';
    }
    return this.options.language;
  }

  /** (Método auxiliar para distinguir chino simplificado vs tradicional) */
  private matchChineseVariant(browserLang: string): string {
    // Si el navegador dice "zh-TW" o "zh-Hant", devolvemos "zh-TW"
    // Si dice "zh-CN" o "zh-Hans", devolvemos "zh-CN"
    const lower = browserLang.toLowerCase();
    if (
      lower.includes('zh-tw') ||
      lower.includes('zh-hant') ||
      lower.includes('zh-hk') ||
      lower.includes('zh-mo')
    ) {
      return 'zh-TW';
    }
    // En cualquier otro caso (p.ej. "zh", "zh-cn", "zh-hans"), asumimos simplificado
    return 'zh-CN';
  }

  setLanguage(lang: string): void {
    const chosenLang = this.languages.includes(lang) ? lang : this.getTranslateLang();
    this.translate.use(chosenLang);
    this.setOptions({ language: chosenLang });
  }

  setTheme(): void {
    const theme = this.options.theme;
    const htmlEl = document.documentElement;
    htmlEl.classList.remove('theme-dark', 'theme-light');
    if (theme === 'dark') htmlEl.classList.add('theme-dark');
    else if (theme === 'light') htmlEl.classList.add('theme-light');
  }

  setDirection(): void {
    document.documentElement.dir = this.options.dir;
  }
}
