import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';
import { Venta } from 'src/app/core/models/ventas/venta.model';

@Component({
  selector: 'app-ventas',
  standalone: true,
  imports: [CommonModule, MatTableModule, MatProgressSpinnerModule],
  templateUrl: './ventas.component.html',
  styleUrls: ['./ventas.component.scss'],
})
export class VentasComponent implements OnInit {
  ventas: Venta[] = [];
  displayedColumns = ['ventaId', 'clienteNombre', 'fechaVenta', 'total', 'metodoPago'];
  loading = false;

  constructor(private ventasApi: VentasApiService) {}

  ngOnInit() {
    this.cargarVentas();
  }

  private cargarVentas() {
    this.loading = true;
    this.ventasApi.obtenerVentas().subscribe({
      next: (data: Venta[]) => {
        this.ventas = data;
        this.loading = false;
      },
      error: () => {
        alert('No se pudieron cargar las ventas');
        this.loading = false;
      },
    });
  }

  private onVentasCargadas(data: Venta[]) {
    this.ventas = data;
    this.loading = false;
  }

  private onErrorCargaVentas() {
    alert('No se pudieron cargar las ventas');
    this.loading = false;
  }
}
