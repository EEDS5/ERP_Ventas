import {
  Component,
  Input,
  OnInit,
  ViewEncapsulation,
  ChangeDetectionStrategy,
  inject,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, NavigationEnd, RouterModule } from '@angular/router';
import { MatIconModule } from '@angular/material/icon';
import { TranslateModule } from '@ngx-translate/core';
import { filter, startWith } from 'rxjs';
import { MenuService } from '@core/services/menu.service';

@Component({
  selector: 'app-breadcrumb',
  standalone: true,
  imports: [
    CommonModule,    // NgForOf, NgIf, etc.
    RouterModule,    // routerLink and RouterOutlet integration
    MatIconModule,   // <mat-icon>
    TranslateModule  // | translate
  ],
  templateUrl: './breadcrumb.component.html',
  styleUrls: ['./breadcrumb.component.scss'],
  encapsulation: ViewEncapsulation.None,
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class BreadcrumbComponent implements OnInit {
  private readonly router = inject(Router);
  private readonly menu = inject(MenuService);

  @Input() nav: string[] = [];
  navItems: string[] = [];

  trackByNavItem(index: number, item: string) {
    return item;
  }

  ngOnInit() {
    this.router.events
      .pipe(
        filter(event => event instanceof NavigationEnd),
        startWith(this.router)  // para inicializar
      )
      .subscribe(() => this.genBreadcrumb());
  }

  private genBreadcrumb() {
    const routes = this.router.url.slice(1).split('/');
    if (this.nav.length > 0) {
      this.navItems = [...this.nav];
    } else {
      this.navItems = this.menu.getLevel(routes);
      this.navItems.unshift('home');
    }
  }
}
