export interface ResumenCuentasResponse {
  totalPendiente: number;
  cantidadClientesDeudores: number;
  estadoCuentas: Record<string, number>;
}
