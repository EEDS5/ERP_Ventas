import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { VentasPorClienteRoutingModule } from './ventas-por-cliente-routing.module';
import { HttpClientModule } from '@angular/common/http';
import { VentasPorClienteComponent } from './ventas-por-cliente/ventas-por-cliente.component'; // standalone

@NgModule({
  imports: [
    CommonModule,
    HttpClientModule,
    VentasPorClienteRoutingModule,
    VentasPorClienteComponent
  ]
})
export class VentasPorClienteModule { }
