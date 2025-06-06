import { Component } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { SettingsService } from 'src/app/core/services/settings.service';
import { SUPPORTED_LANGUAGES, LanguageOption } from 'src/app/shared/components/constants/language.constants';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-language-selector',
  standalone: true,
  imports: [CommonModule, TranslateModule],
  templateUrl: './language-selector.component.html',
})
export class LanguageSelectorComponent {
  supportedLanguages: LanguageOption[] = SUPPORTED_LANGUAGES;

  constructor(private settingsService: SettingsService) {}

  onLanguageChange(lang: string) {
    this.settingsService.setLanguage(lang);
  }

  get currentLang(): string {
    return this.settingsService.options.language;
  }
}
