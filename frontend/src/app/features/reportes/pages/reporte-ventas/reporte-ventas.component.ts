import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { SummaryCardComponent } from 'src/app/shared/components/summary-card/summary-card.component';
import { ReportesApiService } from 'src/app/infrastructure/api/reportes/reportes-api.service';
import { VentaPorCliente } from '../../../../core/models/reportes/venta-por-cliente.model';

@Component({
  standalone: true,
  selector: 'app-reporte-ventas',
  imports: [
    CommonModule,
    MatButtonModule,
    MatGridListModule,
    MatTableModule,
    MatProgressSpinnerModule,
    SummaryCardComponent,
  ],
  templateUrl: './reporte-ventas.component.html',
  styleUrls: ['./reporte-ventas.component.scss'],
})
export class ReporteVentasComponent implements OnInit {
  salesData: VentaPorCliente[] = [];
  dataLoading = false;
  pdfLoading = false;
  excelLoading = false;

  // resumen
  summary = {
    totalVentas: 0,
    totalClientes: 0,
  };

  // columnas de la tabla
  displayedColumns = ['ventaId', 'clienteNombre', 'fechaVenta', 'totalVenta'];

  constructor(private reportesApi: ReportesApiService) {}

  ngOnInit() {
    this.cargarDatos();
  }

  private cargarDatos() {
    this.dataLoading = true;
    this.reportesApi.obtenerVentasPorCliente().subscribe({
      next: (data) => {
        this.salesData = data;
        this.summary.totalVentas = data.map((v) => v.totalVenta).reduce((a, b) => a + b, 0);
        this.summary.totalClientes = new Set(data.map((v) => v.clienteId)).size;
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
    this.reportesApi.descargarReporteVentasPorClientePdf().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteVentasPorCliente.pdf';
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
    this.reportesApi.descargarReporteVentasPorClienteExcel().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteVentasPorCliente.xlsx';
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
