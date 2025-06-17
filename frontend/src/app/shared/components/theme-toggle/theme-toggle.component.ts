import { Component, effect, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ThemeService } from '@core/services/theme.service';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-theme-toggle',
  standalone: true,
  imports: [CommonModule, MatIconModule, MatButtonModule],
  template: `
    <button mat-icon-button (click)="toggle()" [attr.aria-label]="'Cambiar tema'" class="theme-toggle">
      <mat-icon>{{ isDark() ? 'dark_mode' : 'light_mode' }}</mat-icon>
    </button>
  `,
  styleUrls: ['./theme-toggle.component.scss'],
})
export class ThemeToggleComponent {
  isDark = signal(false);

  constructor(private theme: ThemeService) {
    effect(() => {
      this.isDark.set(this.theme.isDarkMode);
    });
  }

  toggle(): void {
    this.theme.toggleTheme();
    this.isDark.set(this.theme.isDarkMode);
  }
}
