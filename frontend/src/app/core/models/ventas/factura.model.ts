export interface Factura {
  facturaId: number;
  ventaId: number;
  numeroFactura: string;
  fechaEmision: string;
  xmlFactura: string | null;
  creadoPorUsuarioId: number;
  creadoPorUsuarioNombre: string;
  activo: boolean;
}
