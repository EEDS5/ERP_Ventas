// src/app/infrastructure/ui/theme/admin-layout/admin-layout.component.ts
import { Component, OnDestroy, ViewChild, HostBinding, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  Router,
  RouterModule,
  NavigationStart,
  NavigationEnd,
  NavigationCancel,
  NavigationError
} from '@angular/router';
import { BreakpointObserver } from '@angular/cdk/layout';
import { Subscription } from 'rxjs';
import { filter } from 'rxjs/operators';

import { MatSidenav, MatSidenavContent, MatSidenavModule } from '@angular/material/sidenav';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { MatBadgeModule } from '@angular/material/badge';
import { MatProgressBarModule } from '@angular/material/progress-bar';

import { AppSettings } from '@core/settings';
import { SettingsService } from '@core/services/settings.service';

import { HeaderComponent } from '../header/header.component';
import { SidebarComponent } from '../sidebar/sidebar.component';
import { SidebarNoticeComponent } from '../sidebar-notice/sidebar-notice.component';
import { TopmenuComponent } from '../topmenu/topmenu.component';

@Component({
  selector: 'app-admin-layout',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatSidenavModule,
    MatToolbarModule,
    MatIconModule,
    MatListModule,
    MatBadgeModule,
    MatProgressBarModule,
    HeaderComponent,
    SidebarComponent,
    SidebarNoticeComponent,
    TopmenuComponent
  ],
  templateUrl: './admin-layout.component.html',
  styleUrls: ['./admin-layout.component.scss'],
})
export class AdminLayoutComponent implements OnDestroy {
  @ViewChild('sidenav',    { static: true }) sidenav!: MatSidenav;
  @ViewChild('content',    { static: true }) content!: MatSidenavContent;

  /** bandera para mostrar/ocultar la barra de progreso */
  loading = false;

  /** suscripciones para limpiar al destruir */
  private routerEventsSub        = Subscription.EMPTY;
  private layoutChangesSubscription = Subscription.EMPTY;

  /** servicios inyectados vía `inject()` */
  private readonly router            = inject(Router);
  private readonly breakpointObserver = inject(BreakpointObserver);
  private readonly settings          = inject(SettingsService);

  /** opciones de UI */
  options: AppSettings = this.settings.options;
  private isMobileScreen       = false;
  private isContentWidthFixed  = true;
  private isCollapsedWidthFixed = false;

  @HostBinding('class.matero-content-width-fix')
  get isOver() {
    return this.isMobileScreen;
  }

  get contentWidthFix() {
    return (
      this.isContentWidthFixed &&
      this.options.navPos === 'side' &&
      this.options.sidenavOpened &&
      !this.isOver
    );
  }

  @HostBinding('class.matero-sidenav-collapsed-fix')
  get collapsedWidthFix() {
    return (
      this.isCollapsedWidthFixed &&
      (this.options.navPos === 'top' || (this.options.sidenavOpened && this.isOver))
    );
  }

  constructor() {
    // 1) Barra de progreso en eventos del router
    this.routerEventsSub = this.router.events
      .pipe(filter(event =>
        event instanceof NavigationStart ||
        event instanceof NavigationEnd ||
        event instanceof NavigationCancel ||
        event instanceof NavigationError
      ))
      .subscribe(event => {
        this.loading = event instanceof NavigationStart;
      });

    // 2) Ajustes de layout según ancho de pantalla
    this.layoutChangesSubscription = this.breakpointObserver
      .observe([
        '(max-width: 599px)',                                // móvil
        '(min-width: 600px) and (max-width: 959px)',         // tablet
        '(min-width: 1280px)'                                // desktop grande
      ])
      .subscribe(state => {
        this.options.sidenavOpened = true;
        this.isMobileScreen = state.breakpoints['(max-width: 599px)'];
        this.options.sidenavCollapsed =
          state.breakpoints['(min-width: 600px) and (max-width: 959px)'];
        this.isContentWidthFixed = state.breakpoints['(min-width: 1280px)'];
      });

    // 3) Scroll to top en cada fin de navegación
    this.router.events
      .pipe(filter(event => event instanceof NavigationEnd))
      .subscribe(() => {
        if (this.isOver) {
          this.sidenav.close();
        }
        this.content.scrollTo({ top: 0 });
      });
  }

  ngOnDestroy() {
    this.routerEventsSub.unsubscribe();
    this.layoutChangesSubscription.unsubscribe();
  }

  toggleCollapsed() {
    this.isContentWidthFixed = false;
    this.options.sidenavCollapsed = !this.options.sidenavCollapsed;
    this.resetCollapsedState();
  }

  resetCollapsedState(timer = 400) {
    setTimeout(() => {
      this.settings.setOptions(this.options);
    }, timer);
  }

  onSidenavClosedStart() {
    this.isContentWidthFixed = false;
  }

  onSidenavOpenedChange(isOpened: boolean) {
    this.isCollapsedWidthFixed = !this.isOver;
    this.options.sidenavOpened = isOpened;
    this.settings.setOptions(this.options);
  }

  updateOptions(options: AppSettings) {
    this.options = options;
    this.settings.setOptions(options);
    this.settings.setDirection();
    this.settings.setTheme();
  }
}
