import { Component } from '@angular/core';

@Component({
  standalone: true,
  imports: [], // Add necessary imports here if required
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {
  title = 'frontend-app';
}
