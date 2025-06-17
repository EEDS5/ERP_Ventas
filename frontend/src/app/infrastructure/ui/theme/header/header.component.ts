import { Component, EventEmitter, Input, Output, ViewEncapsulation } from '@angular/core';
import { MatToolbarModule }  from '@angular/material/toolbar';
import { MatButtonModule }   from '@angular/material/button';
import { MatIconModule }     from '@angular/material/icon';
import { ThemeToggleComponent } from '@shared/components/theme-toggle/theme-toggle.component';
import screenfull from 'screenfull';

import { BrandingComponent }        from '../widgets/branding.component';
/* import { GithubButtonComponent }    from '../widgets/github.component'; */
/* import { NotificationComponent }    from '../widgets/notification.component'; */
/* import { TranslateComponent }       from '../widgets/translate.component'; */
import { UserComponent }            from '../widgets/user.component';

import { CommonModule, NgIf } from '@angular/common';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [
    CommonModule,
    NgIf,
    MatToolbarModule,
    MatButtonModule,
    MatIconModule,
    BrandingComponent,
    /* GithubButtonComponent, */
    /* NotificationComponent, */
    /* TranslateComponent, */
    UserComponent,
    ThemeToggleComponent
  ],
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
  host: {
    class: 'matero-header',
  },
  encapsulation: ViewEncapsulation.None,
})
export class HeaderComponent {
  @Input() showToggle = true;
  @Input() showBranding = false;

  @Output() toggleSidenav       = new EventEmitter<void>();
  @Output() toggleSidenavNotice = new EventEmitter<void>();

  toggleFullscreen() {
  if (screenfull.isEnabled) {
    screenfull.toggle();
  }
}
}
