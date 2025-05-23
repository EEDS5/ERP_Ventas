// src/app/features/dashboard/pages/components/chart-ventas-mensuales/chart-ventas-mensuales.component.ts
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';

import { NgxEchartsModule, provideEchartsCore } from 'ngx-echarts';

import * as echartsCore from 'echarts/core';
import { BarChart } from 'echarts/charts';
import { TooltipComponent, GridComponent, TitleComponent } from 'echarts/components';
import { CanvasRenderer } from 'echarts/renderers';

import type { EChartsCoreOption } from 'echarts/core';

import { DashboardService } from '../../../services/dashboard.service';
import { MesFacturadoResponse } from '../../../../../core/models/reportes/facturacion.model';

// Registro de los módulos necesarios
echartsCore.use([BarChart, TooltipComponent, GridComponent, TitleComponent, CanvasRenderer]);

@Component({
  selector: 'app-chart-ventas-mensuales',
  standalone: true,
  imports: [CommonModule, MatCardModule, NgxEchartsModule],
  providers: [provideEchartsCore({ echarts: echartsCore })],
  templateUrl: './chart-ventas-mensuales.component.html',
  styleUrls: ['./chart-ventas-mensuales.component.scss'],
})
export class ChartVentasMensualesComponent implements OnInit {
  chartOption!: EChartsCoreOption;

  constructor(private dashboardService: DashboardService) {}

  ngOnInit() {
    this.dashboardService.getFacturacionMensual().subscribe((data: MesFacturadoResponse[]) => {
      this.chartOption = this.buildOption(data);
    });
  }

  private buildOption(data: MesFacturadoResponse[]): EChartsCoreOption {
    const bgColor = getComputedStyle(document.body).backgroundColor || '#ffffff';
    const isDark = this.isDarkColor(bgColor);

    return {
      tooltip: {},
      xAxis: {
        type: 'category',
        data: data.map((d) => d.mes),
        axisLabel: {
          color: isDark ? '#ffffff' : '#000000',
        },
        axisLine: {
          lineStyle: {
            color: isDark ? '#aaaaaa' : '#333333',
          },
        },
      },
      yAxis: {
        type: 'value',
        axisLabel: {
          color: isDark ? '#ffffff' : '#000000',
        },
        axisLine: {
          lineStyle: {
            color: isDark ? '#aaaaaa' : '#333333',
          },
        },
        splitLine: {
          lineStyle: {
            // Líneas de fondo más suaves en modo claro y más tenues en modo oscuro
            color: isDark ? '#2e2e2e' : '#e0e0e0',
            type: 'solid',
          },
        },
      },
      series: [
        {
          data: data.map((d) => d.totalFacturado),
          type: 'bar',
          itemStyle: {
            color: '#5C6BC0',
          },
        },
      ],
    };
  }

  private isDarkColor(rgbColor: string): boolean {
    const match = rgbColor.match(/\d+/g);
    if (!match || match.length < 3) return false;

    const [r, g, b] = match.map(Number);
    const brightness = (r * 299 + g * 587 + b * 114) / 1000;
    return brightness < 128;
  }
}
