import { Component, Inject, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatCardModule } from '@angular/material/card';
import { Venta } from 'src/app/core/models/ventas/venta.model';
import { VentasApiService } from 'src/app/infrastructure/api/ventas/ventas-api.service';

@Component({
  selector: 'app-detalle-venta-dialog',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatCardModule
  ],
  templateUrl: './detalle-venta-dialog.component.html',
  styleUrls: ['./detalle-venta-dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class DetalleVentaDialogComponent implements OnInit {
  venta?: Venta;
  loading = true;

  constructor(
    private api: VentasApiService,
    @Inject(MAT_DIALOG_DATA) public data: { ventaId: number },
    private dialogRef: MatDialogRef<DetalleVentaDialogComponent>
  ) {}

  ngOnInit() {
    this.api.obtenerVenta(this.data.ventaId).subscribe({
      next: (v: Venta) => {
        this.venta = v;
        this.loading = false;
      },
      error: () => this.loading = false
    });
  }

  cerrar() {
    this.dialogRef.close();
  }
}
