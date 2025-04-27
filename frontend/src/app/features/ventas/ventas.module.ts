import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { VentasRoutingModule } from './ventas-routing.module';
import { VentasComponent } from './components/ventas/ventas.component';

@NgModule({
  imports: [
    CommonModule,
    VentasRoutingModule,
    VentasComponent
  ]
})
export class VentasModule {}
