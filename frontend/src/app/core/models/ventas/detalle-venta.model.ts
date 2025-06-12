export interface DetalleVenta {
  detalleId: number;
  ventaId: number;
  productoId: number;
  productoNombre: string;
  cantidad: number;
  precioUnitario: number;
  subtotal: number;
  activo: boolean;
}
