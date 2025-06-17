import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class ThemeService {
  private isDark = false;

  constructor() {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    this.isDark = prefersDark;
    this.applyTheme();
  }

  toggleTheme(): void {
    this.isDark = !this.isDark;
    this.applyTheme();
  }

  private applyTheme(): void {
    const html = document.documentElement;

    if (this.isDark) {
      html.classList.add('theme-dark');
      html.style.colorScheme = 'dark'; 
    } else {
      html.classList.remove('theme-dark');
      html.style.colorScheme = 'light';
    }
  }

  get isDarkMode(): boolean {
    return this.isDark;
  }
}