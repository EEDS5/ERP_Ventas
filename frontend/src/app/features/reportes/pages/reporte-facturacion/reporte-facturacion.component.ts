import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { SummaryCardComponent } from 'src/app/shared/components/summary-card/summary-card.component';
import { ReportesApiService } from 'src/app/infrastructure/api/reportes/reportes-api.service';
import { MesFacturado } from '../../../../core/models/reportes/mes-facturado.model';

@Component({
  standalone: true,
  selector: 'app-reporte-facturacion',
  imports: [
    CommonModule,
    MatButtonModule,
    MatGridListModule,
    MatTableModule,
    MatProgressSpinnerModule,
    SummaryCardComponent,
  ],
  templateUrl: './reporte-facturacion.component.html',
  styleUrls: ['./reporte-facturacion.component.scss'],
})
export class ReporteFacturacionComponent implements OnInit {
  facturacionData: MesFacturado[] = [];
  dataLoading = false;
  pdfLoading = false;
  excelLoading = false;

  summary = {
    totalFacturado: 0,
    totalMeses: 0,
  };

  displayedColumns = ['mes', 'totalFacturado'];

  constructor(private reportesApi: ReportesApiService) {}

  ngOnInit() {
    this.cargarDatos();
  }

  private cargarDatos() {
    this.dataLoading = true;
    this.reportesApi.obtenerFacturacionMensual().subscribe({
      next: (data) => {
        this.facturacionData = data;
        this.summary.totalFacturado = data.reduce((sum, d) => sum + d.totalFacturado, 0);
        this.summary.totalMeses = data.length;
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
    this.reportesApi.descargarReporteFacturacionPdf().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteFacturacionMensual.pdf';
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
    this.reportesApi.descargarReporteFacturacionExcel().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteFacturacionMensual.xlsx';
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
