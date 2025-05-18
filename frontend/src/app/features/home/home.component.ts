import { Component, HostListener } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-home',
  imports: [RouterModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent {
  title = 'frontend-app';

  /* -------- Parallax interactivo (mouse / tilt) -------- */
  @HostListener('document:mousemove', ['$event'])
  onMouseMove(e: MouseEvent) {
    const x = (e.clientX / window.innerWidth  - 0.5) * 30;   // ±15 px
    const y = (e.clientY / window.innerHeight - 0.5) * 20;   // ±10 px
    document.documentElement.style.setProperty('--waveX', `${x}px`);
    document.documentElement.style.setProperty('--waveY', `${y}px`);
    document.documentElement.style.setProperty('--heroShift', `${-y * 0.6}px`);
  }

  /* -------- Parallax en móviles (basado en inclinación) */
  @HostListener('window:deviceorientation', ['$event'])
  onTilt(ev: DeviceOrientationEvent) {
    if (!ev.beta || !ev.gamma) return;
    const x = (ev.gamma / 45) * 15;   // gamma:-45 → +45
    const y = (ev.beta  / 90) * 10;   // beta :-90 → +90
    document.documentElement.style.setProperty('--waveX', `${x}px`);
    document.documentElement.style.setProperty('--waveY', `${y}px`);
    document.documentElement.style.setProperty('--heroShift', `${-y * 0.6}px`);
  }
}
