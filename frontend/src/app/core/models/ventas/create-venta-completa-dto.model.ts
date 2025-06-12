import { DetalleVentaForm } from './detalle-venta-form.model';

export interface CreateVentaCompletaDTO {
  clienteId: number;
  metodoPagoId: number;
  creadoPorUsuarioId: number;
  detalles: DetalleVentaForm[];
}
