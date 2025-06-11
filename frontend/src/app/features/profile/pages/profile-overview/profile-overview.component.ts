// frontend/src/app/features/profile/pages/profile-overview/profile-overview.component.ts

import { Component, ChangeDetectionStrategy, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { TranslateModule } from '@ngx-translate/core';

import { MatDividerModule } from '@angular/material/divider';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

import { ProfileService } from '@core/services/profile.service';
import { Usuario } from '@core/models/auth/usuario.model';
import { ProfileDetailComponent } from '../components/profile/profile-detail.component';
import { Observable } from 'rxjs';

import { SettingsService } from '@core/services/settings.service';

import { LocalizedDatePipe } from '@shared/pipes/localized-date.pipe';

@Component({
  selector: 'app-profile-overview',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatDividerModule,
    MatProgressSpinnerModule,
    TranslateModule,
    LocalizedDatePipe,
    ProfileDetailComponent,
  ],
  templateUrl: './profile-overview.component.html',
  styleUrls: ['./profile-overview.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProfileOverviewComponent {
  private readonly profileService = inject(ProfileService);
  private readonly settings = inject(SettingsService);

  /** Observable que expone los datos del usuario autenticado */
  user$: Observable<Usuario> = this.profileService.getMyProfile();

  copyToClipboard(text: string): void {
    navigator.clipboard.writeText(text);
  }

  /** Devuelve el locale para DatePipe según la configuración actual */
  get dateLocale(): string {
    const lang = this.settings.options.language; // 'es-ES', 'en-US', etc.
    if (lang.startsWith('es')) return 'es';
    if (lang.startsWith('zh-CN')) return 'zh-Hans';
    if (lang.startsWith('zh-TW')) return 'zh-Hant';
    return 'en-US';
  }
}
