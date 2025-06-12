export interface Factura {
  facturaId: number;
  ventaId: number;
  numeroFactura: string;
  fechaEmision: string;
  xmlFactura: string;
  creadoPorUsuarioId: number;
  activo: boolean;
}
