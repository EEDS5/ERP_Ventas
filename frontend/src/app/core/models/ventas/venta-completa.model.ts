import { Venta } from './venta.model';
import { DetalleVenta } from './detalle-venta.model';

export interface VentaCompleta extends Venta {
  detalles: DetalleVenta[];
}
