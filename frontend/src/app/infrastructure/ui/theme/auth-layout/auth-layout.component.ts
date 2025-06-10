import { Component, ViewEncapsulation } from '@angular/core';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-auth-layout',
  standalone: true,
  templateUrl: './auth-layout.component.html',
  styleUrls: ['./auth-layout.component.scss'],
  encapsulation: ViewEncapsulation.None,
  imports: [RouterOutlet],
})
export class AuthLayoutComponent {}
