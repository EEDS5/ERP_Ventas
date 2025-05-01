import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { VentasPorClienteComponent } from './ventas-por-cliente/ventas-por-cliente.component';

const routes: Routes = [
  { path: '', component: VentasPorClienteComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class VentasPorClienteRoutingModule { }
