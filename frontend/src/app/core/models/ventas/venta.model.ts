export interface Venta {
  ventaId: number;
  clienteId: number;
  clienteNombre: string;
  fechaVenta: string;
  total: number;
  metodoPagoId: number;
  metodoPagoNombre: string;
  creadoPorUsuarioId: number;
  creadoPorUsuarioNombre: string;
  activo: boolean;
  facturada: boolean;
}
