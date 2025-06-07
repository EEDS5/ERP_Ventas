import { Pipe, PipeTransform, inject } from '@angular/core';
import { DatePipe } from '@angular/common';
import { TranslateService } from '@ngx-translate/core';

@Pipe({
  name: 'localizedDate',
  standalone: true,
  pure: true, // inmutable: sólo recalcula cuando cambie la referencia
})
export class LocalizedDatePipe implements PipeTransform {
  // inyectamos ngx-translate para obtener el idioma actual
  private translate = inject(TranslateService);

  transform(
  value: string | Date | number,
  format = 'longDate'
  ): string | null {
    // currentLang será 'es-ES', 'en-US', 'zh-CN', etc.
    const locale = this.translate.currentLang || this.translate.defaultLang;
    const datePipe = new DatePipe(locale);
    return datePipe.transform(value, format);
  }
}
