export interface CuentaPorCobrar {
  cliente: string;
  ventaId: number;
  numeroFactura: string;
  fechaVencimiento: string;
  montoPendiente: number;
  estado: string;
  fechaUltimoPago: string;
}
