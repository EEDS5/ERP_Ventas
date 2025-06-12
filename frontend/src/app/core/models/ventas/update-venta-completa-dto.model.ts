import { DetalleVentaForm } from './detalle-venta-form.model';

export interface UpdateVentaCompletaDTO {
  metodoPagoId: number;
  detalles: DetalleVentaForm[];
}
