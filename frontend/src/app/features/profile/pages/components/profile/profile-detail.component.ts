import { Component, Input, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-profile-detail',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="detail-item">
      <span class="detail-label">{{ label }}</span>
      <span class="detail-value">
        <ng-content></ng-content>
      </span>
    </div>
  `,
  styleUrls: ['./profile-detail.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProfileDetailComponent {
  @Input() label!: string;
}
// Este componente se utiliza para mostrar detalles del perfil de usuario.
