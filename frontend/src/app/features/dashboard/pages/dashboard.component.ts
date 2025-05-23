import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PageHeaderComponent } from 'src/app/shared/components/page-header/page-header.component';
import { SummaryCardComponent } from 'src/app/shared/components/summary-card/summary-card.component';
import { ChartVentasMensualesComponent } from './components/chart-ventas-mensuales/chart-ventas-mensuales.component';
import { ChartCuentasPorCobrarComponent } from './components/chart-cuentas-por-cobrar/chart-cuentas-por-cobrar.component';
import { DashboardService } from '../services/dashboard.service';
import { VentasHoyResponse } from '@core/models/dashboard/ventas-hoy.model';
import { FacturacionActualResponse } from '@core/models/dashboard/facturacion-actual.model';
import { ResumenCuentasResponse } from '@core/models/dashboard/cuentas.model';
import { StockBajoResponse } from '@core/models/dashboard/stock-bajo.model';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    PageHeaderComponent,
    SummaryCardComponent,
    ChartVentasMensualesComponent,
    ChartCuentasPorCobrarComponent
  ],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
})
export class DashboardComponent implements OnInit {
  ventasHoy?: VentasHoyResponse;
  facturacionActual?: FacturacionActualResponse;
  resumenCuentas?: ResumenCuentasResponse;
  stockBajo?: StockBajoResponse;

  constructor(private svc: DashboardService) {}

  ngOnInit() {
    this.svc.getVentasHoy().subscribe(v => this.ventasHoy = v);
    this.svc.getFacturacionActual().subscribe(f => this.facturacionActual = f);
    this.svc.getResumenCuentas().subscribe(r => this.resumenCuentas = r);
    this.svc.getStockBajo().subscribe(s => this.stockBajo = s);
  }
}
