import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-ventas-por-cliente',
  templateUrl: './ventas-por-cliente.component.html',
  styleUrls: ['./ventas-por-cliente.component.scss']
})
export class VentasPorClienteComponent {
  constructor(private http: HttpClient) {}

  descargarPdf() {
    this.http
      .get('/api/reportes/ventas-por-cliente/pdf', { responseType: 'blob' })
      .subscribe(blob => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'ReporteVentasPorCliente.pdf';
        a.click();
        window.URL.revokeObjectURL(url);
      });
  }
}
