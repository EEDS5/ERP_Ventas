// src/app/features/dashboard/pages/components/chart-cuentas-por-cobrar/chart-cuentas-por-cobrar.component.ts
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';

import { NgxEchartsModule, provideEchartsCore } from 'ngx-echarts';

import * as echartsCore from 'echarts/core';
import { PieChart } from 'echarts/charts';
import { TooltipComponent, LegendComponent } from 'echarts/components';
import { CanvasRenderer } from 'echarts/renderers';

import type { EChartsCoreOption } from 'echarts/core';

import { DashboardService } from '../../../services/dashboard.service';
import { ResumenCuentasResponse } from '../../../../../core/models/dashboard/cuentas.model';

// Registro explícito y minimalista
echartsCore.use([PieChart, TooltipComponent, LegendComponent, CanvasRenderer]);

@Component({
  selector: 'app-chart-cuentas-por-cobrar',
  standalone: true,
  imports: [CommonModule, MatCardModule, NgxEchartsModule],
  providers: [provideEchartsCore({ echarts: echartsCore })],
  templateUrl: './chart-cuentas-por-cobrar.component.html',
  styleUrls: ['./chart-cuentas-por-cobrar.component.scss'],
})
export class ChartCuentasPorCobrarComponent implements OnInit {
  chartOption!: EChartsCoreOption;

  constructor(private dashboardService: DashboardService) {}

  ngOnInit() {
    this.dashboardService.getResumenCuentas().subscribe((res: ResumenCuentasResponse) => {
      this.chartOption = this.buildOption(res.estadoCuentas);
    });
  }

  private buildOption(states: Record<string, number>): EChartsCoreOption {
    const data = Object.keys(states).map((key) => ({ name: key, value: states[key] }));

    // Obtener color de fondo real del elemento contenedor
    const bgColor = getComputedStyle(document.body).backgroundColor || '#ffffff';

    // Determinar si es claro u oscuro
    const isDark = this.isDarkColor(bgColor);

    return {
      tooltip: {
        trigger: 'item',
      },
      legend: {
        orient: 'vertical',
        left: 'left',
        textStyle: {
          color: isDark ? '#ffffff' : '#000000',
        },
      },
      series: [
        {
          name: 'Cuentas',
          type: 'pie',
          radius: '50%',
          data,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)',
            },
          },
        },
      ],
    };
  }

  private isDarkColor(rgbColor: string): boolean {
    const match = rgbColor.match(/\d+/g);
    if (!match || match.length < 3) return false;

    const [r, g, b] = match.map(Number);
    // Luminosidad: fórmula estándar
    const brightness = (r * 299 + g * 587 + b * 114) / 1000;
    return brightness < 128;
  }
}
