import { Component, OnInit, ViewEncapsulation, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { RouterLink } from '@angular/router';
import { AuthService } from '@core/services/auth.service';
import { Usuario } from '@core/models/auth/usuario.model';

import { TranslateModule } from '@ngx-translate/core';

@Component({
  selector: 'app-user-panel',
  standalone: true,
  template: `
    <div class="matero-user-panel" routerLink="/profile/overview">
      <mat-icon
        class="matero-user-panel-avatar"
        fontIcon="account_circle"
        style="font-size: 64px;"
      ></mat-icon>
      <div class="matero-user-panel-info">
        <h4>{{ user.nombreUsuario }}</h4>
        <h5>{{ user.email }}</h5>
      </div>
    </div>
  `,
  styleUrl: './user-panel.component.scss',
  encapsulation: ViewEncapsulation.None,
  imports: [RouterLink, MatButtonModule, MatIconModule, MatTooltipModule, TranslateModule],
})
export class UserPanelComponent implements OnInit {
  private readonly auth = inject(AuthService);

  user!: Usuario;

  ngOnInit(): void {
    this.auth.user$.subscribe((user: Usuario | null) => {
      if (user) this.user = user;
    });
  }
}
