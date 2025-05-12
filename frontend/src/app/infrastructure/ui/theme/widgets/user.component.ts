import { ChangeDetectorRef, Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatMenuModule } from '@angular/material/menu';
import { Router, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { debounceTime, tap } from 'rxjs';

import { AuthService } from '@core/services/auth.service';
import { SettingsService } from '@core/services/settings';
import { Usuario } from '@core/models/usuario.model';

@Component({
  selector: 'app-user',
  standalone: true,
  template: `
    <button mat-icon-button [matMenuTriggerFor]="menu">
      <!-- <img class="avatar" [src]="user.avatar" width="24" alt="avatar" /> -->
      <mat-icon>account_circle</mat-icon>
    </button>

    <mat-menu #menu="matMenu">
      <button routerLink="/profile/overview" mat-menu-item>
        <mat-icon>account_circle</mat-icon>
        <span>{{ 'profile' | translate }}</span>
      </button>
      <button routerLink="/profile/settings" mat-menu-item>
        <mat-icon>edit</mat-icon>
        <span>{{ 'edit_profile' | translate }}</span>
      </button>
      <button mat-menu-item (click)="restore()">
        <mat-icon>restore</mat-icon>
        <span>{{ 'restore_defaults' | translate }}</span>
      </button>
      <button mat-menu-item (click)="logout()">
        <mat-icon>exit_to_app</mat-icon>
        <span>{{ 'logout' | translate }}</span>
      </button>
    </mat-menu>
  `,
  styles: `
    .avatar {
      width: 1.5rem;
      height: 1.5rem;
      border-radius: 50rem;
    }
  `,
  imports: [RouterLink, MatButtonModule, MatIconModule, MatMenuModule, TranslateModule],
})
export class UserComponent implements OnInit {
  private readonly cdr = inject(ChangeDetectorRef);
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);
  private readonly settings = inject(SettingsService);

  user: Usuario | null = null;

  ngOnInit(): void {
    this.auth.user$
      .pipe(
        tap((user) => (this.user = user as Usuario)),
        debounceTime(10),
      )
      .subscribe(() => this.cdr.detectChanges());
  }

  logout() {
    this.auth.logout();
    this.router.navigate(['/login']);
  }

  restore() {
    this.settings.reset();
    window.location.reload();
  }
}
