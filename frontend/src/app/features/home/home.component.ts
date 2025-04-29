import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';   // ← importa el router

@Component({
  standalone: true,
  selector: 'app-home',

  /* 👇 añade RouterModule en imports */
  imports: [RouterModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {
  title = 'frontend-app';
}
