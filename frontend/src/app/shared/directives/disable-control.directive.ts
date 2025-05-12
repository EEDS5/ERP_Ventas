// src/app/shared/directives/disable-control.directive.ts
import { Directive, Input, OnChanges, inject } from '@angular/core';
import { NgControl } from '@angular/forms';

@Directive({
  selector: 'mat-slide-toggle[appDisableControl]',
  standalone: true
})
export class DisableControlDirective implements OnChanges {
  private readonly ngControl = inject(NgControl, { optional: true });

  // aquí le decimos que el binding [appDisableControl] llene este campo
  @Input('appDisableControl') disableControl = false;

  ngOnChanges(): void {
    if (this.disableControl) {
      this.ngControl?.control?.disable();
    } else {
      this.ngControl?.control?.enable();
    }
  }
}
