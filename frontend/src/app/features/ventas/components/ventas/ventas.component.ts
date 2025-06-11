import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { SummaryCardComponent } from 'src/app/shared/components/summary-card/summary-card.component';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';
import { Venta } from '@core/models/ventas/venta.model';

@Component({
  selector: 'app-ventas',
  standalone: true,
  imports: [CommonModule, MatTableModule, MatProgressSpinnerModule, SummaryCardComponent],
  templateUrl: './ventas.component.html',
  styleUrls: ['./ventas.component.scss']
})
export class VentasComponent implements OnInit {
  ventas: Venta[] = [];
  loading = false;
  displayedColumns = ['ventaId', 'clienteNombre', 'fechaVenta', 'total'];
  totalVentas = 0;

  constructor(private ventasApi: VentasApiService) {}

  ngOnInit() {
    this.cargarVentas();
  }

  private cargarVentas() {
    this.loading = true;
    this.ventasApi.obtenerVentas().subscribe({
      next: (data) => {
        this.ventas = data;
        this.totalVentas = data.reduce((sum, v) => sum + Number(v.total), 0);
        this.loading = false;
      },
      error: () => {
        alert('No se pudieron cargar las ventas');
        this.loading = false;
      }
    });
  }
}
