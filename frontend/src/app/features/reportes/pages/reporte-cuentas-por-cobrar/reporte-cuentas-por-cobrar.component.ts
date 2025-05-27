import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { SummaryCardComponent } from 'src/app/shared/components/summary-card/summary-card.component';
import { ReportesApiService } from 'src/app/infrastructure/api/reportes/reportes-api.service';
import { CuentaPorCobrar } from '../../../../core/models/reportes/cuenta-por-cobrar.model';

@Component({
  standalone: true,
  selector: 'app-reporte-cuentas-por-cobrar',
  imports: [
    CommonModule,
    MatButtonModule,
    MatGridListModule,
    MatTableModule,
    MatProgressSpinnerModule,
    SummaryCardComponent,
  ],
  templateUrl: './reporte-cuentas-por-cobrar.component.html',
  styleUrls: ['./reporte-cuentas-por-cobrar.component.scss'],
})
export class ReporteCuentasPorCobrarComponent implements OnInit {
  cuentasData: CuentaPorCobrar[] = [];
  dataLoading = false;
  pdfLoading = false;
  excelLoading = false;

  summary = {
    totalPendiente: 0,
    totalCuentas: 0,
  };

  displayedColumns = ['cliente', 'ventaId', 'numeroFactura', 'fechaVencimiento', 'montoPendiente', 'estado', 'fechaUltimoPago'];

  constructor(private reportesApi: ReportesApiService) {}

  ngOnInit() {
    this.cargarDatos();
  }

  private cargarDatos() {
    this.dataLoading = true;
    this.reportesApi.obtenerCuentasPorCobrar().subscribe({
      next: (data) => {
        this.cuentasData = data;
        this.summary.totalPendiente = data.reduce((sum, d) => sum + d.montoPendiente, 0);
        this.summary.totalCuentas = data.length;
        this.dataLoading = false;
      },
      error: () => {
        alert('No se pudieron cargar los datos del reporte.');
        this.dataLoading = false;
      },
    });
  }

  descargarPdf() {
    this.pdfLoading = true;
    this.reportesApi.descargarReporteCuentasPdf().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteCuentasPorCobrar.pdf';
        a.click();
        window.URL.revokeObjectURL(url);
        this.pdfLoading = false;
      },
      error: () => {
        alert('Ocurrió un error al generar el PDF.');
        this.pdfLoading = false;
      },
    });
  }

  descargarExcel() {
    this.excelLoading = true;
    this.reportesApi.descargarReporteCuentasExcel().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteCuentasPorCobrar.xlsx';
        a.click();
        window.URL.revokeObjectURL(url);
        this.excelLoading = false;
      },
      error: () => {
        alert('Ocurrió un error al generar el Excel.');
        this.excelLoading = false;
      },
    });
  }
}
