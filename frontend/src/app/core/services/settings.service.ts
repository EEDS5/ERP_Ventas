import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { AppSettings, defaults } from '../settings';
import { BehaviorSubject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class SettingsService {
  // Idiomas soportados para evitar peticiones 404
  private readonly languages = ['en-US'];
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
      const browserLang = navigator.language;
      return this.languages.includes(browserLang) ? browserLang : 'en-US';
    }
    return this.options.language;
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
